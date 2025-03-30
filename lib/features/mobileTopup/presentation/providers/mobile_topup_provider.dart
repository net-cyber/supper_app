import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/features/mobileTopup/application/mobile_topup/bloc/mobile_topup.dart';

class MobileTopupProvider extends StatelessWidget {
  final Widget child;

  const MobileTopupProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileTopupBloc(),
      child: child,
    );
  }
}
