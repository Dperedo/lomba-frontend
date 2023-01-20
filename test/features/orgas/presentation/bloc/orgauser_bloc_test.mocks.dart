// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/orgas/presentation/bloc/orgauser_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lomba_frontend/core/data/models/sort_model.dart' as _i16;
import 'package:lomba_frontend/core/failures.dart' as _i7;
import 'package:lomba_frontend/features/orgas/domain/entities/orgauser.dart'
    as _i8;
import 'package:lomba_frontend/features/orgas/domain/repositories/orga_repository.dart'
    as _i2;
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orgauser.dart'
    as _i5;
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orgauser.dart'
    as _i9;
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orgauser.dart'
    as _i10;
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgausers.dart'
    as _i11;
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orgauser.dart'
    as _i12;
import 'package:lomba_frontend/features/users/domain/entities/user.dart'
    as _i14;
import 'package:lomba_frontend/features/users/domain/repositories/user_repository.dart'
    as _i4;
import 'package:lomba_frontend/features/users/domain/usecases/get_users.dart'
    as _i13;
import 'package:lomba_frontend/features/users/domain/usecases/get_users_notin_orga.dart'
    as _i15;
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

class _FakeOrgaRepository_0 extends _i1.SmartFake
    implements _i2.OrgaRepository {
  _FakeOrgaRepository_0(
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

class _FakeUserRepository_2 extends _i1.SmartFake
    implements _i4.UserRepository {
  _FakeUserRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AddOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddOrgaUser extends _i1.Mock implements _i5.AddOrgaUser {
  @override
  _i2.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>> execute(
    String? orgaId,
    String? userId,
    List<String>? roles,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
            roles,
            enabled,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
            _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              roles,
              enabled,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
                _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              roles,
              enabled,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>);
}

/// A class which mocks [DeleteOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteOrgaUser extends _i1.Mock implements _i9.DeleteOrgaUser {
  @override
  _i2.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, bool>> execute(
    String? orgaId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
            _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, bool>>.value(
                _FakeEither_1<_i7.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, bool>>);
}

/// A class which mocks [EnableOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnableOrgaUser extends _i1.Mock implements _i10.EnableOrgaUser {
  @override
  _i2.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>> execute(
    String? orgaId,
    String? userId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
            enableOrDisable,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
            _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              enableOrDisable,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
                _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>);
}

/// A class which mocks [GetOrgaUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOrgaUsers extends _i1.Mock implements _i11.GetOrgaUsers {
  @override
  _i2.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i8.OrgaUser>>> execute(
          String? orgaId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [orgaId],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.OrgaUser>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.OrgaUser>>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, List<_i8.OrgaUser>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.OrgaUser>>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i8.OrgaUser>>>);
}

/// A class which mocks [UpdateOrgaUser].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateOrgaUser extends _i1.Mock implements _i12.UpdateOrgaUser {
  @override
  _i2.OrgaRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeOrgaRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.OrgaRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>> execute(
    String? orgaId,
    String? userId,
    _i8.OrgaUser? orgaUser,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            userId,
            orgaUser,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
            _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              orgaUser,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>.value(
                _FakeEither_1<_i7.Failure, _i8.OrgaUser>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              userId,
              orgaUser,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, _i8.OrgaUser>>);
}

/// A class which mocks [GetUsers].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsers extends _i1.Mock implements _i13.GetUsers {
  @override
  _i4.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.UserRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>> execute(
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
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>.value(
            _FakeEither_1<_i7.Failure, List<_i14.User>>(
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
            _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>.value(
                _FakeEither_1<_i7.Failure, List<_i14.User>>(
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
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>);
}

/// A class which mocks [GetUsersNotInOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUsersNotInOrga extends _i1.Mock implements _i15.GetUsersNotInOrga {
  @override
  _i4.UserRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeUserRepository_2(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeUserRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.UserRepository);
  @override
  _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>> execute(
    String? orgaId,
    _i16.SortModel? sortFields,
    int? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            sortFields,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>.value(
            _FakeEither_1<_i7.Failure, List<_i14.User>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              sortFields,
              pageNumber,
              pageSize,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>.value(
                _FakeEither_1<_i7.Failure, List<_i14.User>>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              sortFields,
              pageNumber,
              pageSize,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.Failure, List<_i14.User>>>);
}
