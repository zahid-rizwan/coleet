import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<PinSetupRequested>(_onPinSetupRequested);
    on<FingerprintSetupRequested>(_onFingerprintSetupRequested);
    on<ProfileSetupCompleted>(_onProfileSetupCompleted);
  }

  Future<void> _onProfileUpdateRequested(
      ProfileUpdateRequested event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    try {
      // In a real app, this would save the profile data to a repository
      await Future.delayed(const Duration(milliseconds: 500));

      emit(ProfileUpdated(
        fullName: event.fullName,
        nickname: event.nickname,
        dateOfBirth: event.dateOfBirth,
        email: event.email,
        phoneNumber: event.phoneNumber,
        profileImagePath: event.profileImagePath,
      ));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onPinSetupRequested(
      PinSetupRequested event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    try {
      // In a real app, this would save the PIN securely
      await Future.delayed(const Duration(milliseconds: 500));

      emit(PinSetupCompleted(pin: event.pin));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onFingerprintSetupRequested(
      FingerprintSetupRequested event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    try {
      // In a real app, this would register the fingerprint
      await Future.delayed(const Duration(milliseconds: 500));

      emit(FingerprintSetupCompleted(enabled: event.enabled));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onProfileSetupCompleted(
      ProfileSetupCompleted event,
      Emitter<ProfileState> emit,
      ) async {
    emit(ProfileLoading());

    try {
      // In a real app, this would finalize the profile setup
      await Future.delayed(const Duration(milliseconds: 500));

      emit(SetupCompleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}