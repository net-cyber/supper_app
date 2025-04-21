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

// Helper function to show SnackBar at the top
void showTopSnackBar(
  BuildContext context, {
  required String message,
  Color backgroundColor = Colors.red,
  Duration duration = const Duration(seconds: 4),
  SnackBarAction? action,
}) {
  // Dismiss any previous overlays first
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  
  // Use OverlayEntry for fixed position notification
  final overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;
  
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).viewPadding.top + 10,
      left: 20.w,
      right: 20.w,
      child: Material(
        elevation: 6.0,
        borderRadius: BorderRadius.circular(8.r),
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              if (action != null)
                InkWell(
                  onTap: () {
                    overlayEntry?.remove();
                    action.onPressed.call();
                  },
                  child: Text(
                    action.label,
                    style: TextStyle(
                      color: action.textColor ?? Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                )
              else
                InkWell(
                  onTap: () => overlayEntry?.remove(),
                  child: Text(
                    'Dismiss',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
  
  // Insert the overlay and remove after duration
  overlayState.insert(overlayEntry);
  
  // Auto-remove after duration
  Future.delayed(duration, () {
    if (overlayEntry?.mounted ?? false) {
      overlayEntry?.remove();
    }
  });
}

class InternalBankAmountScreen extends StatelessWidget {
  final Map<String, dynamic> transferData;

  const InternalBankAmountScreen({
    super.key,
    required this.transferData,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AccountValidationBloc>()),
        BlocProvider(create: (context) => getIt<AccountsBloc>()),
      ],
      child: _InternalBankAmountScreenContent(transferData: transferData),
    );
  }
}

class _InternalBankAmountScreenContent extends StatefulWidget {
  final Map<String, dynamic> transferData;

  const _InternalBankAmountScreenContent({
    required this.transferData,
  });

  @override
  State<_InternalBankAmountScreenContent> createState() => _InternalBankAmountScreenContentState();
}

class _InternalBankAmountScreenContentState extends State<_InternalBankAmountScreenContent> with WidgetsBindingObserver {
  final TextEditingController _amountController = TextEditingController();
  bool _hasInput = false;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAccountsFetched = false;
  bool _isValidationLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
    _fetchAccountsIfNeeded();
    
    // Add observer to detect when the screen comes back into focus
    WidgetsBinding.instance.addObserver(this);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reset loading state when screen is rebuilt (like when coming back from navigation)
    if (_isLoading) {
      setState(() {
        _isLoading = false;
        _isValidationLoading = false;
      });
    }
  }

  void _fetchAccountsIfNeeded() {
    final accountsBloc = context.read<AccountsBloc>();
    final accountsState = accountsBloc.state;
    
    if (!accountsState.isLoading && accountsState.accounts.isNotEmpty) {
      setState(() {
        _isAccountsFetched = true;
      });
    } else if (accountsState.accounts.isEmpty && !accountsState.isLoading) {
      accountsBloc.add(const FetchAccounts());
    }
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Reset loading states when app comes back to foreground
    if (state == AppLifecycleState.resumed && (_isLoading || _isValidationLoading)) {
      setState(() {
        _isLoading = false;
        _isValidationLoading = false;
      });
    }
  }

  void _onAmountChanged() {
    final text = _amountController.text;
    final hasInput = text.isNotEmpty;

    if (hasInput != _hasInput) {
      setState(() {
        _hasInput = hasInput;
      });
    }
  }

  void _handleSessionExpired() async {
    await LocalStorage.instance.clearUserSession();

    if (mounted) {
      showTopSnackBar(
        context,
        message: 'Your session has expired. Please login again.',
        duration: const Duration(seconds: 3),
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.go('/login');
        }
      });
    }
  }

  void _validateBalance() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final accountsBloc = context.read<AccountsBloc>();
    final accountsState = accountsBloc.state;
    
    if (accountsState.accounts.isEmpty) {
      if (accountsState.isLoading) {
        return;
      }
      setState(() {
        _isValidationLoading = true;
      });
      accountsBloc.add(const FetchAccounts());
      return;
    }

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      showTopSnackBar(
        context,
        message: 'Please enter an amount',
      );
      return;
    }

    final double? amount = double.tryParse(amountText);
    if (amount == null) {
      showTopSnackBar(
        context,
        message: 'Please enter a valid number',
      );
      return;
    }

    if (amount <= 0) {
      showTopSnackBar(
        context,
        message: 'Amount must be greater than zero',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
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

    // Validate balance first
    final validationBloc = context.read<AccountValidationBloc>();
    validationBloc.add(
      AccountValidationEvent.accountDetailsChanged(
        accountId: recipientAccountId,
        amount: amount,
      ),
    );

    validationBloc.add(
      const AccountValidationEvent.validateAccountSubmitted(),
    );
  }

  void _navigateToConfirmationScreen() {
    final accountsBloc = context.read<AccountsBloc>();
    final accountsState = accountsBloc.state;
    
    if (accountsState.accounts.isEmpty) {
      showTopSnackBar(
        context,
        message: 'Please wait while we load your accounts',
      );
      return;
    }

    final senderAccount = accountsState.accounts.firstWhere(
      (account) =>
          account.currency.toLowerCase() == 'etb' ||
          account.currency.toLowerCase() == 'birr',
      orElse: () => accountsState.accounts.first,
    );
    
    final userData = LocalStorage.instance.getUserData();
    if (userData == null || !userData.containsKey('full_name')) {
      showTopSnackBar(
        context,
        message: 'Unable to load user data. Please try again.',
      );
      return;
    }

    final completeTransferData = {
      ...widget.transferData,
      'amount': double.parse(_amountController.text),
      'name': 'Goh Betoch Bank',
      'senderAccount': {
        'id': senderAccount.id,
        'balance': senderAccount.balance,
        'currency': senderAccount.currency,
      },
      'senderName': userData['full_name'],
      'preloaded': true,
    };

    // Navigate with result handling
    context.pushNamed(RouteName.internalConfirmTransfer, extra: completeTransferData).then((_) {
      // Reset loading state when we return from the confirmation screen
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isValidationLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
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
              showTopSnackBar(
                context,
                message: 'Failed to load your accounts. Please try again.',
                backgroundColor: Colors.orange,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    setState(() {
                      _isValidationLoading = true;
                    });
                    context.read<AccountsBloc>().add(const FetchAccounts());
                  },
                  textColor: Colors.white,
                ),
              );
            }
          },
        ),
        BlocListener<AccountValidationBloc, AccountValidationState>(
          listener: (context, state) {
            // Always reset loading states when validation completes or errors
            if (state.validationError || state.isValidated) {
              setState(() {
                _isValidationLoading = false;
                _isLoading = false;
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
                _isLoading = false;
              });
              context.read<AccountsBloc>().add(const FetchAccounts());
              return;
            }

            if (state.validationError &&
                state.errorMessage
                    .toLowerCase()
                    .contains('service is currently unavailable')) {
              showTopSnackBar(
                context,
                message: 'The balance validation service is temporarily unavailable. Please try again later.',
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
              );
              return;
            }

            if (state.validationError) {
              final errorMessage = state.errorMessage;

              showTopSnackBar(
                context,
                message: errorMessage,
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  textColor: Colors.white,
                ),
              );
            }

            if (state.isValidated && !state.isSufficient) {
              showTopSnackBar(
                context,
                message: state.message,
                backgroundColor: Colors.orange,
                action: SnackBarAction(
                  label: 'Try Different Amount',
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                  textColor: Colors.white,
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
          final isButtonLoading = validationState.isValidating || _isValidationLoading || _isLoading;
  
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
                  fontSize: 16.sp,
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
                  // Account verification section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.05),
                     
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
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
                              'Recipient Details',
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

                  SizedBox(height: 16.h),

                  Text(
                    'Enter Amount',
                    style: GoogleFonts.outfit(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter the amount you want to transfer',
                    style: GoogleFonts.outfit(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildAmountInput(),

                  const Spacer(),

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
          );
        },
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
            fontSize: 12.sp,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    // Get validation state to know if we're loading
    final validationState = context.watch<AccountValidationBloc>().state;
    final isLoading = validationState.isValidating || _isValidationLoading || _isLoading;
    
    return Container(
      decoration: BoxDecoration(
        color: isLoading ? Colors.grey[100] : Colors.grey[200],
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
              enabled: !isLoading, // Disable input when loading
              style: GoogleFonts.outfit(
                fontSize: 16.sp,
                color: isLoading ? Colors.grey[600] : Colors.black87,
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
