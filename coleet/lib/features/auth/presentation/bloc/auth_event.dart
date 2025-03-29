part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EmailLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class EmailRegisterRequested extends AuthEvent {
  final String email;
  final String password;

  const EmailRegisterRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SocialLoginRequested extends AuthEvent {
  final SocialLoginType type;

  const SocialLoginRequested(this.type);

  @override
  List<Object> get props => [type];
}

class AuthLogoutRequested extends AuthEvent {}