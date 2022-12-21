// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/users/presentation/bloc/user_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lomba_frontend/core/failures.dart' as _i6;
import 'package:lomba_frontend/features/users/domain/entities/user.dart' as _i7;
import 'package:lomba_frontend/features/users/domain/repositories/user_repository.dart'
    as _i2;
import 'package:lomba_frontend/features/users/domain/usecases/add_user.dart'
    as _i4;
import 'package:lomba_frontend/features/users/domain/usecases/delete_user.dart'
    as _i8;
import 'package:lomba_frontend/features/users/domain/usecases/enable_user.dart'
    as _i9;
import 'package:lomba_frontend/features/users/domain/usecases/get_user.dart'
    as _i10;
import 'package:lomba_frontend/features/users/domain/usecases/get_users.dart'
    as _i11;
import 'package:lomba_frontend/features/users/domain/usecases/update_user.dart'
    as _i12;
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

class _FakeUserRepository_0 extends _i1.SmartFake
    implements _i2.UserRepository {
  _FakeUserRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddUser extends _i1.Mock implements _i4.AddUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.User>> execute(
    String? name,
    String? username,
    String? email,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            name,
            username,
            email,
            enabled,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
            _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              enabled,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
                _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              username,
              email,
              enabled,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.User>>);
}

/// A class which mocks [DeleteUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteUser extends _i1.Mock implements _i8.DeleteUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> execute(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [userId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);
}

/// A class which mocks [EnableUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnableUser extends _i1.Mock implements _i9.EnableUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.User>> execute(
    String? userId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            enableOrDisable,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
            _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              enableOrDisable,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
                _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.User>>);
}

/// A class which mocks [GetUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUser extends _i1.Mock implements _i10.GetUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.User>> execute(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [userId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
            _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
                _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.User>>);
}

/// A class which mocks [GetUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsers extends _i1.Mock implements _i11.GetUsers {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.User>>> execute(
    String? orgaId,
    String? filter,
    String? fieldOrder,
    double? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            filter,
            fieldOrder,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.User>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.User>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              filter,
              fieldOrder,
              pageNumber,
              pageSize,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.User>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.User>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              filter,
              fieldOrder,
              pageNumber,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.User>>>);
}

/// A class which mocks [UpdateUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateUser extends _i1.Mock implements _i12.UpdateUser {
  @override
  _i2.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.UserRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.User>> execute(
    String? userId,
    _i7.User? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
            _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              user,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.User>>.value(
                _FakeEither_1<_i6.Failure, _i7.User>(
          this,
          Invocation.method(
            #execute,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.User>>);
}