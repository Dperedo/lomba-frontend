// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/users/domain/usercases/user_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lomba_frontend/data/models/sort_model.dart' as _i7;
import 'package:lomba_frontend/core/failures.dart' as _i5;
import 'package:lomba_frontend/domain/entities/user.dart' as _i6;
import 'package:lomba_frontend/domain/repositories/user_repository.dart' as _i3;
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

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i3.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>> getUsers(
    String? orgaId,
    String? filter,
    String? fieldOrder,
    double? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [
            orgaId,
            filter,
            fieldOrder,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.User>>(
          this,
          Invocation.method(
            #getUsers,
            [
              orgaId,
              filter,
              fieldOrder,
              pageNumber,
              pageSize,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>> getUsersNotInOrga(
    String? orgaId,
    _i7.SortModel? sortFields,
    int? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsersNotInOrga,
          [
            orgaId,
            sortFields,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.User>>(
          this,
          Invocation.method(
            #getUsersNotInOrga,
            [
              orgaId,
              sortFields,
              pageNumber,
              pageSize,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.User>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> getUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #getUser,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> addUser(
    String? name,
    String? username,
    String? email,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [
            name,
            username,
            email,
            enabled,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #addUser,
            [
              name,
              username,
              email,
              enabled,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [userId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteUser,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> enableUser(
    String? userId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #enableUser,
          [
            userId,
            enableOrDisable,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #enableUser,
            [
              userId,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> updateUser(
    String? userId,
    _i6.User? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #updateUser,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User?>> existsUser(
    String? userId,
    String? username,
    String? email,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #existsUser,
          [
            userId,
            username,
            email,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>.value(
            _FakeEither_0<_i5.Failure, _i6.User?>(
          this,
          Invocation.method(
            #existsUser,
            [
              userId,
              username,
              email,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User?>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> updateUserPassword(
    String? userId,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserPassword,
          [
            userId,
            password,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #updateUserPassword,
            [
              userId,
              password,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}
