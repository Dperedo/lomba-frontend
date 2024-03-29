// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/sidedrawer/domain/usecases/get_side_options_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lomba_frontend/data/models/session_model.dart' as _i6;
import 'package:lomba_frontend/domain/repositories/local_repository.dart'
    as _i3;
import 'package:lomba_frontend/core/failures.dart' as _i5;
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

/// A class which mocks [LocalRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalRepository extends _i1.Mock implements _i3.LocalRepository {
  MockLocalRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.SessionModel>> getSession() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSession,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.SessionModel>>.value(
                _FakeEither_0<_i5.Failure, _i6.SessionModel>(
          this,
          Invocation.method(
            #getSession,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.SessionModel>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> saveSession(
          _i6.SessionModel? session) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSession,
          [session],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #saveSession,
            [session],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> hasLogIn() => (super.noSuchMethod(
        Invocation.method(
          #hasLogIn,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #hasLogIn,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<String>>> getSideMenuListOptions() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSideMenuListOptions,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
            _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #getSideMenuListOptions,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<String>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> doLogOff() => (super.noSuchMethod(
        Invocation.method(
          #doLogOff,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #doLogOff,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, List<String>>> getSessionRoles() =>
      (super.noSuchMethod(
        Invocation.method(
          #getSessionRoles,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<String>>>.value(
            _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #getSessionRoles,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<String>>>);
}
