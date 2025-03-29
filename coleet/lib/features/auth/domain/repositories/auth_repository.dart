import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

enum SocialLoginType { facebook, google, apple }

abstract class AuthRepository {
  Future<Either<Failure, User>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> registerWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> loginWithSocial(SocialLoginType type);
}