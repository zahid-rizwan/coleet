part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final String fullName;
  final String? nickname;
  final String? dateOfBirth;
  final String email;
  final String? phoneNumber;
  final String? profileImagePath;

  const ProfileUpdated({
    required this.fullName,
    this.nickname,
    this.dateOfBirth,
    required this.email,
    this.phoneNumber,
    this.profileImagePath,
  });

  @override
  List<Object?> get props => [
    fullName,
    nickname,
    dateOfBirth,
    email,
    phoneNumber,
    profileImagePath,
  ];
}

class PinSetupCompleted extends ProfileState {
  final String pin;

  const PinSetupCompleted({required this.pin});

  @override
  List<Object> get props => [pin];
}

class FingerprintSetupCompleted extends ProfileState {
  final bool enabled;

  const FingerprintSetupCompleted({required this.enabled});

  @override
  List<Object> get props => [enabled];
}

class SetupCompleted extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}