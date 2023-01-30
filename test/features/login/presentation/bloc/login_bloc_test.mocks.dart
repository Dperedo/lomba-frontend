// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/login/presentation/bloc/login_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lomba_frontend/core/domain/entities/session.dart' as _i8;
import 'package:lomba_frontend/core/failures.dart' as _i7;
import 'package:lomba_frontend/features/login/domain/repositories/login_repository.dart'
    as _i2;
import 'package:lomba_frontend/features/login/domain/usecases/change_orga.dart'
    as _i11;
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate.dart'
    as _i5;
import 'package:lomba_frontend/features/login/domain/usecases/get_authenticate_google.dart'
    as _i12;
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart'
    as _i10;
import 'package:lomba_frontend/features/orgas/domain/repositories/orga_repository.dart'
    as _i4;
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgasbyuser.dart'
    as _i9;
import 'package:lomba_frontend/features/users/domain/entities/user.dart'
    as _i13;
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

class _FakeLoginRepository_0 extends _i1.SmartFake
    implements _i2.LoginRepository {
  _FakeLoginRepository_0(
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

class _FakeOrgaRepository_2 extends _i1.SmartFake
    implements _i4.OrgaRepository {
  _FakeOrgaRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetAuthenticate].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAuthenticate extends _i1.Mock implements _i5.GetAuthenticate {
  MockGetAuthenticate() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.LoginRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.Session>> execute(
    String? username,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            username,
            password,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.Session>>.value(
            _FakeEither_1<_i7.Failure, _i8.Session>(
          this,
          Invocation.method(
            #execute,
            [
              username,
              password,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.Session>>);
}

/// A class which mocks [GetOrgasByUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOrgasByUser extends _i1.Mock implements _i9.GetOrgasByUser {
  MockGetOrgasByUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i10.Orga>>> execute(
          String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [userId],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<_i10.Orga>>>.value(
            _FakeEither_1<_i7.Failure, List<_i10.Orga>>(
          this,
          Invocation.method(
            #execute,
            [userId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i10.Orga>>>);
}

/// A class which mocks [ChangeOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockChangeOrga extends _i1.Mock implements _i11.ChangeOrga {
  MockChangeOrga() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.LoginRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.Session>> execute(
    String? username,
    String? orgaId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            username,
            orgaId,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.Session>>.value(
            _FakeEither_1<_i7.Failure, _i8.Session>(
          this,
          Invocation.method(
            #execute,
            [
              username,
              orgaId,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.Session>>);
}

/// A class which mocks [GetAuthenticateGoogle].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetAuthenticateGoogle extends _i1.Mock
    implements _i12.GetAuthenticateGoogle {
  MockGetAuthenticateGoogle() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeLoginRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.LoginRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> execute(
    _i13.User? user,
    String? googleToken,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            user,
            googleToken,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              user,
              googleToken,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);
}
