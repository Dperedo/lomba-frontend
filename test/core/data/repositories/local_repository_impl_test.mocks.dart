// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/core/data/repositories/local_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:lomba_frontend/core/data/datasources/local_data_source.dart'
    as _i3;
import 'package:lomba_frontend/core/data/models/session_model.dart' as _i2;
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

class _FakeSessionModel_0 extends _i1.SmartFake implements _i2.SessionModel {
  _FakeSessionModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i3.LocalDataSource {
  MockLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.SessionModel> getSavedSession() => (super.noSuchMethod(
        Invocation.method(
          #getSavedSession,
          [],
        ),
        returnValue: _i4.Future<_i2.SessionModel>.value(_FakeSessionModel_0(
          this,
          Invocation.method(
            #getSavedSession,
            [],
          ),
        )),
      ) as _i4.Future<_i2.SessionModel>);
  @override
  _i4.Future<bool> saveSession(_i2.SessionModel? session) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveSession,
          [session],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> hasSession() => (super.noSuchMethod(
        Invocation.method(
          #hasSession,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
