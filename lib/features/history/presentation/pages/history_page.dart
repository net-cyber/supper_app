import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:super_app/core/di/dependancy_manager.dart';
import 'package:super_app/core/presentation/widgets/app_error_widget.dart';
import 'package:super_app/core/presentation/widgets/app_loading_indicator.dart';
import 'package:super_app/features/history/application/list/bloc/transaction_history_bloc.dart';
import 'package:super_app/features/history/domain/entities/transaction.dart';
import 'package:super_app/features/history/domain/entities/transaction_extensions.dart';
import 'package:super_app/features/history/domain/entities/transaction_filter.dart';
import 'package:super_app/features/history/presentation/widgets/filter_button.dart';
import 'package:super_app/features/history/presentation/widgets/transaction_item.dart';
import 'package:super_app/features/history/presentation/widgets/channel_selector.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionHistoryBloc>()..add(const TransactionHistoryFetched()),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String _selectedChannel = 'Super App';
  final List<String> _channels = ['All Channels', 'Super App'];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<TransactionHistoryBloc>().add(const TransactionHistoryLoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onChannelSelected(String channel) {
    setState(() {
      _selectedChannel = channel;
    });

    if (channel == 'All Channels') {
      context.read<TransactionHistoryBloc>().add(const TransactionHistoryFiltered(
        filter: TransactionFilter(),
      ));
    } else {
      context.read<TransactionHistoryBloc>().add(const TransactionHistoryFetched());
    }
  }

  void _onRefresh() {
    context.read<TransactionHistoryBloc>().add(const TransactionHistoryRefreshed());
  }

  void _onFilterByDate() {
    // Show date range picker dialog
  }

  void _onFilterByAccount() {
    // Show account selection dialog
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Transactions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        actions: [
          FilterButton(
            icon: Icons.account_balance,
            onPressed: _onFilterByAccount,
          ),
          SizedBox(width: 8.w),
          FilterButton(
            icon: Icons.calendar_today,
            onPressed: _onFilterByDate,
          ),
          SizedBox(width: 16.w),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          ChannelSelector(
            channels: _channels,
            selectedChannel: _selectedChannel,
            onChannelSelected: _onChannelSelected,
          ),
          SizedBox(height: 16.h),
          
          Expanded(
            child: BlocConsumer<TransactionHistoryBloc, TransactionHistoryState>(
              listenWhen: (previous, current) => 
                previous.status != current.status || 
                previous.errorMessage != current.errorMessage,
              listener: (context, state) {
                if (state.status == TransactionHistoryStatus.failure && state.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage)),
                  );
                }
              },
              builder: (context, state) {
                if (state.status == TransactionHistoryStatus.initial) {
                  return const Center(child: AppLoadingIndicator());
                }
                
                if (state.status == TransactionHistoryStatus.loading && 
                   (state.paginatedTransactions == null || state.paginatedTransactions!.isEmpty)) {
                  return const Center(child: AppLoadingIndicator());
                }
                
                if (state.status == TransactionHistoryStatus.failure && 
                   (state.paginatedTransactions == null || state.paginatedTransactions!.isEmpty)) {
                  return Center(
                    child: AppErrorWidget(
                      message: state.errorMessage,
                      onRetry: _onRefresh,
                    ),
                  );
                }
                
                final transactions = state.paginatedTransactions?.transactions ?? [];
                
                if (transactions.isEmpty) {
                  return Center(
                    child: Text(
                      'No transactions found',
                      style: theme.textTheme.bodyLarge,
                    ),
                  );
                }
                
                return RefreshIndicator(
                  onRefresh: () async => _onRefresh(),
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: transactions.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index >= transactions.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      
                      final transaction = transactions[index];
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: TransactionItem(
                          transaction: transaction,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 