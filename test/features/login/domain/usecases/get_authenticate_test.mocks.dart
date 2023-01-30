// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/login/domain/usecases/get_authenticate_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lomba_frontend/core/domain/entities/session.dart' as _i6;
import 'package:lomba_frontend/core/failures.dart' as _i5;
import 'package:lomba_frontend/features/login/domain/repositories/login_repository.dart'
    as _i3;
import 'package:lomba_frontend/features/users/domain/entities/user.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginRepository extends _i1.Mock implements _i3.LoginRepository {
  MockLoginRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Session>> getAuthenticate(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuthenticate,
          [
            username,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Session>>.value(
            _FakeEither_0<_i5.Failure, _i6.Session>(
          this,
          Invocation.method(
            #getAuthenticate,
            [
              username,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Session>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> registerUser(
    String? name,
    String? username,
    String? email,
    String? orgaId,
    String? password,
    String? role,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #registerUser,
          [
            name,
            username,
            email,
            orgaId,
            password,
            role,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #registerUser,
            [
              name,
              username,
              email,
              orgaId,
              password,
              role,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Session>> changeOrga(
    String? username,
    String? orgaId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeOrga,
          [
            username,
            orgaId,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Session>>.value(
            _FakeEither_0<_i5.Failure, _i6.Session>(
          this,
          Invocation.method(
            #changeOrga,
            [
              username,
              orgaId,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Session>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> getAuthenticateGoogle(
    _i7.User? user,
    String? googleToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAuthenticateGoogle,
          [
            user,
            googleToken,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #getAuthenticateGoogle,
            [
              user,
              googleToken,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}
