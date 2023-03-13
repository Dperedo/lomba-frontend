// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/presentation/stage/bloc/stage_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:lomba_frontend/core/failures.dart' as _i6;
import 'package:lomba_frontend/domain/entities/workflow/stage.dart' as _i7;
import 'package:lomba_frontend/domain/repositories/stage_repository.dart'
    as _i2;
import 'package:lomba_frontend/domain/usecases/stage/get_stage.dart' as _i4;
import 'package:lomba_frontend/domain/usecases/stage/get_stages.dart' as _i8;
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

class _FakeStageRepository_0 extends _i1.SmartFake
    implements _i2.StageRepository {
  _FakeStageRepository_0(
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

/// A class which mocks [GetStage].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetStage extends _i1.Mock implements _i4.GetStage {
  @override
  _i2.StageRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeStageRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeStageRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.StageRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.Stage>> execute(String? stageId) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [stageId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.Stage>>.value(
            _FakeEither_1<_i6.Failure, _i7.Stage>(
          this,
          Invocation.method(
            #execute,
            [stageId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.Stage>>.value(
                _FakeEither_1<_i6.Failure, _i7.Stage>(
          this,
          Invocation.method(
            #execute,
            [stageId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.Stage>>);
}

/// A class which mocks [GetStages].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetStages extends _i1.Mock implements _i8.GetStages {
  @override
  _i2.StageRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeStageRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeStageRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.StageRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Stage>>> execute() =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, List<_i7.Stage>>>.value(
            _FakeEither_1<_i6.Failure, List<_i7.Stage>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.Stage>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.Stage>>(
          this,
          Invocation.method(
            #execute,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.Stage>>>);
}