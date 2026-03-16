import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:sneakers_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:sneakers_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:sneakers_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:sneakers_app/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = NotifierProvider<AuthViewModel, AuthState>(() => AuthViewModel());

class AuthViewModel extends Notifier<AuthState> {
  late final RegisterUsecase _registerUsecase;
  late final LoginUsecase _loginUsecase;
  late final LogoutUsecase _logoutUsecase;
  late final GetCurrentUserUsecase _getCurrentUserUsecase;

  @override
  AuthState build() {
    _registerUsecase = ref.read(registerUsecaseProvider);
    _loginUsecase = ref.read(loginUsecaseProvider);
    _logoutUsecase = ref.read(logoutUsecaseProvider);
    _getCurrentUserUsecase = ref.read(getCurrentUserUsecaseProvider);
    return AuthState.initial();
  }

  Future<void> register({
    required String email,
    required String fullName,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    
    final params = RegisterUsecaseParams(
      email: email,
      fullName: fullName,
      username: username,
      password: password,
    );
    
    final result = await _registerUsecase(params);
    
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (isRegistered) => state = state.copyWith(status: AuthStatus.registered),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    
    final params = LoginUseCaseParams(email: email, password: password);
    
    final result = await _loginUsecase(params);
    
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (authEntity) => state = state.copyWith(
        status: AuthStatus.authenticated,
        authEntity: authEntity,
      ),
    );
  }

  Future<void> logout() async {
    state = state.copyWith(status: AuthStatus.loading);
    
    final result = await _logoutUsecase();
    
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: failure.message,
      ),
      (success) => state = AuthState.initial(),
    );
  }

  Future<void> getCurrentUser() async {
    state = state.copyWith(status: AuthStatus.loading);
    
    final result = await _getCurrentUserUsecase();
    
    result.fold(
      (failure) => state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: failure.message,
      ),
      (user) => state = state.copyWith(
        status: AuthStatus.authenticated,
        authEntity: user,
      ),
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
