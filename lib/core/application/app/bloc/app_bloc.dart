import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_app/core/application/app/bloc/app_event.dart';
import 'package:super_app/core/application/app/bloc/app_state.dart';
import 'package:super_app/core/utils/local_storage.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<GetThemeMode>(_onGetThemeMode);
    on<ChangeTheme>(_onChangeTheme);
    
    // Initialize theme mode when bloc is created
    add(const AppEvent.getThemeMode());
  }

  Future<void> _onGetThemeMode(GetThemeMode event, Emitter<AppState> emit) async {
    final isDarkMode = LocalStorage.instance.getAppThemeMode();
    emit(state.copyWith(isDarkMode: isDarkMode));
  }

  Future<void> _onChangeTheme(ChangeTheme event, Emitter<AppState> emit) async {
    await LocalStorage.instance.setAppThemeMode(event.isDarkMode);
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }
} 