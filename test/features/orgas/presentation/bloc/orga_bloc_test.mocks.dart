// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/orgas/presentation/bloc/orga_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lomba_frontend/core/failures.dart' as _i6;
import 'package:lomba_frontend/features/orgas/domain/entities/orga.dart' as _i7;
import 'package:lomba_frontend/features/orgas/domain/repositories/orga_repository.dart'
    as _i2;
import 'package:lomba_frontend/features/orgas/domain/usecases/add_orga.dart'
    as _i4;
import 'package:lomba_frontend/features/orgas/domain/usecases/delete_orga.dart'
    as _i8;
import 'package:lomba_frontend/features/orgas/domain/usecases/enable_orga.dart'
    as _i9;
import 'package:lomba_frontend/features/orgas/domain/usecases/exists_orga.dart'
    as _i13;
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orga.dart'
    as _i10;
import 'package:lomba_frontend/features/orgas/domain/usecases/get_orgas.dart'
    as _i11;
import 'package:lomba_frontend/features/orgas/domain/usecases/update_orga.dart'
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

/// A class which mocks [AddOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockAddOrga extends _i1.Mock implements _i4.AddOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>> execute(
    String? name,
    String? code,
    bool? enabled,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            name,
            code,
            enabled,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
            _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              code,
              enabled,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
                _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              name,
              code,
              enabled,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>);
}

/// A class which mocks [DeleteOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockDeleteOrga extends _i1.Mock implements _i8.DeleteOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, bool>> execute(String? orgaId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [orgaId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);
}

/// A class which mocks [EnableOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockEnableOrga extends _i1.Mock implements _i9.EnableOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>> execute(
    String? orgaId,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            enableOrDisable,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
            _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              enableOrDisable,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
                _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>);
}

/// A class which mocks [GetOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOrga extends _i1.Mock implements _i10.GetOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>> execute(String? orgaId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [orgaId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
            _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
                _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [orgaId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>);
}

/// A class which mocks [GetOrgas].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOrgas extends _i1.Mock implements _i11.GetOrgas {
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
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Orga>>> execute(
    String? filter,
    String? fieldOrder,
    double? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            filter,
            fieldOrder,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Orga>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Orga>>(
          this,
          Invocation.method(
            #execute,
            [
              filter,
              fieldOrder,
              pageNumber,
              pageSize,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Orga>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Orga>>(
          this,
          Invocation.method(
            #execute,
            [
              filter,
              fieldOrder,
              pageNumber,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Orga>>>);
}

/// A class which mocks [UpdateOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdateOrga extends _i1.Mock implements _i12.UpdateOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>> execute(
    String? orgaId,
    _i7.Orga? orga,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            orga,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
            _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              orga,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>.value(
                _FakeEither_1<_i6.Failure, _i7.Orga>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              orga,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Orga>>);
}

/// A class which mocks [ExistsOrga].
///
/// See the documentation for Mockito's code generation for more information.
class MockExistsOrga extends _i1.Mock implements _i13.ExistsOrga {
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
  _i5.Future<_i3.Either<_i6.Failure, _i7.Orga?>> execute(
    String? orgaId,
    String? code,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [
            orgaId,
            code,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Orga?>>.value(
            _FakeEither_1<_i6.Failure, _i7.Orga?>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              code,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Orga?>>.value(
                _FakeEither_1<_i6.Failure, _i7.Orga?>(
          this,
          Invocation.method(
            #execute,
            [
              orgaId,
              code,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Orga?>>);
}
