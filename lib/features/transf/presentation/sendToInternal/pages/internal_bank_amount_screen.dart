import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/router/route_name.dart';
import 'package:super_app/core/utils/local_storage.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_bloc.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_event.dart';
import 'package:super_app/features/accounts/application/list/bloc/accounts_state.dart';
import 'package:super_app/features/transf/application/validation/bloc/account_validation_bloc.dart';

class InternalBankAmountScreen extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const InternalBankAmountScreen({
    super.key,
    required this.transferData,
  });

  @override
  State<InternalBankAmountScreen> createState() =>
      _InternalBankAmountScreenState();
}

class _InternalBankAmountScreenState extends State<InternalBankAmountScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _hasInput = false;
  late final AccountValidationBloc _validationBloc;
  late final AccountsBloc _accountsBloc;
  bool _isAccountsFetched = false;

  @override
  void initState() {
    super.initState();
    _validationBloc = getIt<AccountValidationBloc>();
    _accountsBloc = getIt<AccountsBloc>();
    _amountController.addListener(_onAmountChanged);

    // Ensure we have accounts loaded
    _fetchAccountsIfNeeded();
  }

  void _fetchAccountsIfNeeded() {
    final accountsState = _accountsBloc.state;
    if (accountsState.accounts.isEmpty && !accountsState.isLoading) {
      _accountsBloc.add(const FetchAccounts());
      _isAccountsFetched = true;
    } else {
      _isAccountsFetched = true;
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final text = _amountController.text;
    final hasInput = text.isNotEmpty;

    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }

    // Update the validation bloc with the new amount if available
    if (text.isNotEmpty) {
      final double? amount = double.tryParse(text);
      if (amount != null) {
        // We still need to store the recipient's account ID in the bloc state
        // for display purposes, but it won't be used for validation
        final recipientAccountId = int.tryParse(
                widget.transferData['accountNumber']?.toString() ?? '') ??
            0;

        // Update the bloc with the new details
        _validationBloc.add(
          AccountValidationEvent.accountDetailsChanged(
            accountId:
                recipientAccountId, // This is not used for validation anymore
            amount: amount,
          ),
        );
      }
    }
  }

  void _validateBalance() {
    // Check if accounts are loaded first
    final accountsState = _accountsBloc.state;
    if (accountsState.accounts.isEmpty) {
      // If accounts are loading, show a message to wait
      if (accountsState.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Loading your accounts. Please wait a moment...'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      // If accounts failed to load, try again
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Unable to load your accounts. Trying again...'),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Retry',
            onPressed: () {
              _accountsBloc.add(const FetchAccounts());
            },
          ),
        ),
      );

      // Trigger a fetch
      _accountsBloc.add(const FetchAccounts());
      return;
    }

    // Validate amount format first
    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Get recipient account ID for display purposes (not used in validation)
    final recipientAccountId =
        int.tryParse(widget.transferData['accountNumber']?.toString() ?? '') ??
            0;

    // Update the bloc state with the parsed values
    _validationBloc.add(
      AccountValidationEvent.accountDetailsChanged(
        accountId: recipientAccountId, // Just stored for reference
        amount: amount,
      ),
    );

    // Trigger validation (now the validation will use the account ID from AccountsBloc)
    _validationBloc.add(
      const AccountValidationEvent.validateAccountSubmitted(),
    );
  }

  void _handleSessionExpired() async {
    // Clear user session data
    await LocalStorage.instance.clearUserSession();

    // Show message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please login again.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );

      // Navigate to login screen
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.go('/login');
        }
      });
    }
  }

  void _navigateToConfirmationScreen() {
    // Add amount to transfer data and navigate to confirmation screen
    final completeTransferData = {
      ...widget.transferData,
      'amount': double.parse(_amountController.text),
      'name': 'Goh Betoch Bank',
    };

    // Navigate to internal confirmation screen
    context.pushNamed(RouteName.internalConfirmTransfer,
        extra: completeTransferData);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _validationBloc),
        BlocProvider.value(value: _accountsBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AccountsBloc, AccountsState>(
            listener: (context, accountsState) {
              // If accounts are loaded successfully and we have accounts,
              // we can potentially re-enable validation
              if (!accountsState.isLoading &&
                  !accountsState.hasError &&
                  accountsState.accounts.isNotEmpty) {
                setState(() {
                  _isAccountsFetched = true;
                });
              }

              // Show error if account loading failed
              if (accountsState.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Failed to load your accounts. Please try again.',
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.orange,
                    action: SnackBarAction(
                      label: 'Retry',
                      onPressed: () {
                        _accountsBloc.add(const FetchAccounts());
                      },
                      textColor: Colors.white,
                    ),
                  ),
                );
              }
            },
          ),
          BlocListener<AccountValidationBloc, AccountValidationState>(
            listener: (context, state) {
              // Handle authentication error / session expired
              if (state.validationError &&
                  state.errorMessage.toLowerCase().contains('unauthorised')) {
                _handleSessionExpired();
                return;
              }

              // If validation error mentions no accounts available
              if (state.validationError &&
                  state.errorMessage.contains('No accounts available')) {
                // Try to fetch accounts again
                _accountsBloc.add(const FetchAccounts());
                return;
              }

              // Show error message when validation fails
              if (state.validationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Dismiss',
                      onPressed: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      textColor: Colors.white,
                    ),
                  ),
                );
              }

              // Handle successful validation but insufficient funds
              if (state.isValidated && !state.isSufficient) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.orange,
                    action: SnackBarAction(
                      label: 'Dismiss',
                      onPressed: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      textColor: Colors.white,
                    ),
                  ),
                );
              }

              // Handle successful validation with sufficient funds
              if (state.isValidated && state.isSufficient) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                  ),
                );

                // Navigate to confirmation screen after a short delay
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted && state.isValidated && state.isSufficient) {
                    _navigateToConfirmationScreen();
                  }
                });
              }
            },
          ),
        ],
        child: BlocBuilder<AccountValidationBloc, AccountValidationState>(
            builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'Enter Transfer Amount',
                style: GoogleFonts.outfit(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account verification section with Goh Betoch Bank branding
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_rounded,
                              color: Theme.of(context).colorScheme.primary,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Goh Betoch Bank Account',
                              style: GoogleFonts.outfit(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailRow('Account Number',
                            widget.transferData['accountNumber'].toString()),
                        SizedBox(height: 8.h),
                        _buildDetailRow(
                            'Account Holder',
                            widget.transferData['accountHolderName']
                                .toString()),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Amount input section
                  Text(
                    'Enter Amount',
                    style: GoogleFonts.outfit(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter the amount you want to transfer',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAmountInput(),

                  // Sample amounts section
                  SizedBox(height: 24.h),
                  Text(
                    'Quick Amounts',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickAmountButton('500'),
                      _buildQuickAmountButton('1,000'),
                      _buildQuickAmountButton('5,000'),
                      _buildQuickAmountButton('10,000'),
                    ],
                  ),

                  const Spacer(),

                  // Loading indicator for accounts
                  BlocBuilder<AccountsBloc, AccountsState>(
                    builder: (context, accountsState) {
                      if (accountsState.isLoading) {
                        return Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Loading your accounts...',
                                    style: GoogleFonts.outfit(
                                      fontSize: 16.sp,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  // Loading indicator when validating
                  if (state.isValidating) ...[
                    Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: 16.h),
                          Text(
                            'Validating transaction...',
                            style: GoogleFonts.outfit(
                              fontSize: 16.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],

                  // Continue button
                  if (!state.isValidating) ...[
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: _hasInput
                            ? (state.isValidated && state.isSufficient
                                ? _navigateToConfirmationScreen
                                : _validateBalance)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          disabledBackgroundColor: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                        ),
                        child: Text(
                          state.isValidated && state.isSufficient
                              ? 'Continue to Confirm'
                              : 'Validate Amount',
                          style: GoogleFonts.outfit(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return OutlinedButton(
      onPressed: () {
        _amountController.text = amount.replaceAll(',', '');
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      ),
      child: Text(
        amount,
        style: GoogleFonts.outfit(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            child: Text(
              'ETB',
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _amountController,
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                hintText: 'Enter amount',
                hintStyle: GoogleFonts.outfit(
                  fontSize: 16.sp,
                  color: Colors.grey[500],
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
