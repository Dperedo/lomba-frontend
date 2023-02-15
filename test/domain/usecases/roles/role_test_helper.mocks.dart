// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/domain/usecases/roles/role_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lomba_frontend/core/failures.dart' as _i5;
import 'package:lomba_frontend/domain/entities/role.dart' as _i6;
import 'package:lomba_frontend/domain/repositories/role_repository.dart' as _i3;
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

/// A class which mocks [RoleRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRoleRepository extends _i1.Mock implements _i3.RoleRepository {
  MockRoleRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Role>>> getRoles() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRoles,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Role>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Role>>(
          this,
          Invocation.method(
            #getRoles,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Role>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Role>> getRole(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRole,
          [name],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Role>>.value(
            _FakeEither_0<_i5.Failure, _i6.Role>(
          this,
          Invocation.method(
            #getRole,
            [name],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Role>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Role>> enableRole(
    String? name,
    bool? enableOrDisable,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #enableRole,
          [
            name,
            enableOrDisable,
          ],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Role>>.value(
            _FakeEither_0<_i5.Failure, _i6.Role>(
          this,
          Invocation.method(
            #enableRole,
            [
              name,
              enableOrDisable,
            ],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Role>>);
}
