import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginWithSocial {
  final AuthRepository repository;

  LoginWithSocial(this.repository);

  Future<Either<Failure, User>> call(SocialLoginType type) async {
    return await repository.loginWithSocial(type);
  }
}