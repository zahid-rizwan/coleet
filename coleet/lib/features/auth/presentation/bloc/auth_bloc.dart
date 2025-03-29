import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_with_email.dart';
import '../../domain/usecases/login_with_social.dart';
import '../../domain/usecases/register_with_email.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithEmail loginWithEmail;
  final LoginWithSocial loginWithSocial;
  final RegisterWithEmail registerWithEmail;

  AuthBloc({
    required this.loginWithEmail,
    required this.loginWithSocial,
    required this.registerWithEmail,
  }) : super(AuthInitial()) {
    on<EmailLoginRequested>(_onEmailLoginRequested);
    on<EmailRegisterRequested>(_onEmailRegisterRequested);
    on<SocialLoginRequested>(_onSocialLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onEmailLoginRequested(
      EmailLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await loginWithEmail(
      email: event.email,
      password: event.password,
    );

    result.fold(
          (failure) => emit(AuthError("failure.message")),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onEmailRegisterRequested(
      EmailRegisterRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await registerWithEmail(
      email: event.email,
      password: event.password,
    );

    result.fold(
          (failure) => emit(AuthError("failure.message")),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSocialLoginRequested(
      SocialLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await loginWithSocial(event.type);

    result.fold(
          (failure) => emit(AuthError("failure?.message")),
          (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthInitial());
  }
}