part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateRequested extends ProfileEvent {
  final String fullName;
  final String? nickname;
  final String? dateOfBirth;
  final String email;
  final String? phoneNumber;
  final String? profileImagePath;

  const ProfileUpdateRequested({
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

class PinSetupRequested extends ProfileEvent {
  final String pin;

  const PinSetupRequested({required this.pin});

  @override
  List<Object> get props => [pin];
}

class FingerprintSetupRequested extends ProfileEvent {
  final bool enabled;

  const FingerprintSetupRequested({required this.enabled});

  @override
  List<Object> get props => [enabled];
}

class ProfileSetupCompleted extends ProfileEvent {}