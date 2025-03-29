import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
    required String password,
  }) async {
    return await repository.loginWithEmail(
      email: email,
      password: password,
    );
  }
}