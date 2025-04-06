import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    String? routeName,
  }) = _SplashState;

  const SplashState._();
} 