// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/domain/usecases/flow/flow_test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:lomba_frontend/core/failures.dart' as _i5;
import 'package:lomba_frontend/domain/entities/workflow/flow.dart' as _i6;
import 'package:lomba_frontend/domain/repositories/flow_repository.dart' as _i3;
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

/// A class which mocks [FlowRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFlowRepository extends _i1.Mock implements _i3.FlowRepository {
  MockFlowRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Flow>>> getFlows() =>
      (super.noSuchMethod(
        Invocation.method(
          #getFlows,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, List<_i6.Flow>>>.value(
            _FakeEither_0<_i5.Failure, List<_i6.Flow>>(
          this,
          Invocation.method(
            #getFlows,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.Flow>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Flow>> getFlow(String? flowId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFlow,
          [flowId],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.Flow>>.value(
            _FakeEither_0<_i5.Failure, _i6.Flow>(
          this,
          Invocation.method(
            #getFlow,
            [flowId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.Flow>>);
}
