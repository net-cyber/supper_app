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
import 'package:super_app/features/transf/presentation/widget/continue_button.dart';

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
  bool _isValidationLoading = false;

  @override
  void initState() {
    super.initState();
    _validationBloc = getIt<AccountValidationBloc>();
    _accountsBloc = getIt<AccountsBloc>();
    _amountController.addListener(_onAmountChanged);
    _fetchAccountsIfNeeded();
  }

  void _fetchAccountsIfNeeded() {
    final accountsState = _accountsBloc.state;
    if (!accountsState.isLoading && accountsState.accounts.isNotEmpty) {
      setState(() {
        _isAccountsFetched = true;
      });
    } else if (accountsState.accounts.isEmpty && !accountsState.isLoading) {
      _accountsBloc.add(const FetchAccounts());
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final hasText = _amountController.text.trim().isNotEmpty;
    if (hasText != _hasInput) {
      setState(() {
        _hasInput = hasText;
      });
    }
  }

  void _validateBalance() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final accountsState = _accountsBloc.state;
    if (accountsState.accounts.isEmpty) {
      if (accountsState.isLoading) {
        return;
      }
      setState(() {
        _isValidationLoading = true;
      });
      _accountsBloc.add(const FetchAccounts());
      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an amount'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final double? amount = double.tryParse(amountText);
    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid number'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Amount must be greater than zero'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isValidationLoading = true;
    });

    final etbAccount = accountsState.accounts.firstWhere(
      (account) =>
          account.currency.toLowerCase() == 'etb' ||
          account.currency.toLowerCase() == 'birr',
      orElse: () => accountsState.accounts.first,
    );

    final recipientAccountId =
        int.tryParse(widget.transferData['accountNumber']?.toString() ?? '') ??
            0;

    _validationBloc.add(
      AccountValidationEvent.accountDetailsChanged(
        accountId: recipientAccountId,
        amount: amount,
      ),
    );

    _validationBloc.add(
      const AccountValidationEvent.validateAccountSubmitted(),
    );
  }

  void _handleSessionExpired() async {
    await LocalStorage.instance.clearUserSession();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your session has expired. Please login again.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.go('/login');
        }
      });
    }
  }

  void _navigateToConfirmationScreen() {
    final completeTransferData = {
      ...widget.transferData,
      'amount': double.parse(_amountController.text),
      'name': 'Goh Betoch Bank',
      'preloaded': true,
    };

    final accountsState = _accountsBloc.state;
    if (accountsState.accounts.isNotEmpty) {
      final senderAccount = accountsState.accounts.firstWhere(
        (account) =>
            account.currency.toLowerCase() == 'etb' ||
            account.currency.toLowerCase() == 'birr',
        orElse: () => accountsState.accounts.first,
      );
      
      completeTransferData['senderAccount'] = {
        'id': senderAccount.id,
        'balance': senderAccount.balance,
        'currency': senderAccount.currency,
      };
      
      final userData = LocalStorage.instance.getUserData();
      if (userData != null && userData.containsKey('full_name')) {
        completeTransferData['senderName'] = userData['full_name'];
      }
    }

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
              if (!accountsState.isLoading &&
                  !accountsState.hasError &&
                  accountsState.accounts.isNotEmpty) {
                setState(() {
                  _isAccountsFetched = true;
                  if (_isValidationLoading) {
                    _isValidationLoading = false;
                  }
                });
              }

              if (accountsState.hasError && _hasInput) {
                setState(() {
                  _isValidationLoading = false;
                });
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
                        setState(() {
                          _isValidationLoading = true;
                        });
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
              if (state.validationError || state.isValidated) {
                setState(() {
                  _isValidationLoading = false;
                });
              }
              
              if (state.validationError &&
                      state.errorMessage
                          .toLowerCase()
                          .contains('unauthorised') ||
                  state.errorMessage
                      .toLowerCase()
                      .contains('session has expired')) {
                _handleSessionExpired();
                return;
              }

              if (state.validationError &&
                  state.errorMessage.contains('No accounts available')) {
                setState(() {
                  _isValidationLoading = true;
                });
                _accountsBloc.add(const FetchAccounts());
                return;
              }

              if (state.validationError &&
                  state.errorMessage
                      .toLowerCase()
                      .contains('service is currently unavailable')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'The balance validation service is temporarily unavailable. Please try again later.',
                    ),
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.orange,
                    action: SnackBarAction(
                      label: 'Retry',
                      onPressed: () {
                        if (_hasInput) {
                          _validateBalance();
                        }
                      },
                      textColor: Colors.white,
                    ),
                  ),
                );
                return;
              }

              if (state.validationError) {
                final errorMessage = state.errorMessage;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
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

              if (state.isValidated && !state.isSufficient) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    duration: const Duration(seconds: 4),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.orange,
                    action: SnackBarAction(
                      label: 'Try Different Amount',
                      onPressed: () =>
                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                      textColor: Colors.white,
                    ),
                  ),
                );
              }

              if (state.isValidated && state.isSufficient) {
                _navigateToConfirmationScreen();
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            final validationState = context.watch<AccountValidationBloc>().state;
            
            final isButtonLoading = validationState.isValidating || _isValidationLoading;
            
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
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  color:
                                      Theme.of(context).colorScheme.primary,
                                  size: 24.sp,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Recipient Account',
                                  style: GoogleFonts.outfit(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            _buildDetailRow(
                                'Account Number',
                                widget.transferData['accountNumber']
                                    .toString()),
                            SizedBox(height: 8.h),
                            _buildDetailRow(
                                'Account Holder',
                                widget.transferData['accountHolderName']
                                    .toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
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
                      
                      Spacer(),
                      
                      ContinueButton(
                        onPressed: _validateBalance,
                        isEnabled: _hasInput,
                        isLoading: isButtonLoading,
                        text: 'Continue',
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            );
          }
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
