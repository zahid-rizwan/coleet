import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithSocial(SocialLoginType type);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful login
    return UserModel(
      id: 'user_123',
      email: email,
      name: email.split('@').first,
    );
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
  }) async {
    // In a real app, this would make an API call
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful registration
    return UserModel(
      id: 'user_123',
      email: email,
      name: email.split('@').first,
    );
  }

  @override
  Future<UserModel> loginWithSocial(SocialLoginType type) async {
    // In a real app, this would integrate with social SDKs
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful social login
    return UserModel(
      id: 'user_123',
      email: 'user@example.com',
      name: 'Social User',
      photoUrl: 'https://example.com/avatar.jpg',
    );
  }
}