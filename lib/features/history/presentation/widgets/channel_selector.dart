import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChannelSelector extends StatelessWidget {
  final List<String> channels;
  final String selectedChannel;
  final Function(String) onChannelSelected;

  const ChannelSelector({
    super.key,
    required this.channels,
    required this.selectedChannel,
    required this.onChannelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Row(
          children: channels.map((channel) {
            final isSelected = channel == selectedChannel;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChannelSelected(channel),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(22.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    channel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? theme.primaryColor : Colors.grey[600],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
} 