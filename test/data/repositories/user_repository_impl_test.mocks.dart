// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/features/users/data/repositories/user_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:lomba_frontend/data/datasources/user_data_source.dart' as _i3;
import 'package:lomba_frontend/data/models/user_model.dart' as _i2;
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

class _FakeUserModel_0 extends _i1.SmartFake implements _i2.UserModel {
  _FakeUserModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i3.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.UserModel>> getUsers(
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
        returnValue: _i4.Future<List<_i2.UserModel>>.value(<_i2.UserModel>[]),
      ) as _i4.Future<List<_i2.UserModel>>);
  @override
  _i4.Future<_i2.UserModel> getUser(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [userId],
        ),
        returnValue: _i4.Future<_i2.UserModel>.value(_FakeUserModel_0(
          this,
          Invocation.method(
            #getUser,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.UserModel>);
  @override
  _i4.Future<_i2.UserModel> addUser(_i2.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [user],
        ),
        returnValue: _i4.Future<_i2.UserModel>.value(_FakeUserModel_0(
          this,
          Invocation.method(
            #addUser,
            [user],
          ),
        )),
      ) as _i4.Future<_i2.UserModel>);
  @override
  _i4.Future<bool> deleteUser(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [userId],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> enableUser(
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
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.UserModel> updateUser(
    String? userId,
    _i2.UserModel? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i4.Future<_i2.UserModel>.value(_FakeUserModel_0(
          this,
          Invocation.method(
            #updateUser,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i4.Future<_i2.UserModel>);
  @override
  _i4.Future<_i2.UserModel?> existsUser(
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
        returnValue: _i4.Future<_i2.UserModel?>.value(),
      ) as _i4.Future<_i2.UserModel?>);
  @override
  _i4.Future<List<_i2.UserModel>> getUsersNotInOrga(
    String? orgaId,
    List<dynamic>? order,
    int? pageNumber,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsersNotInOrga,
          [
            orgaId,
            order,
            pageNumber,
            pageSize,
          ],
        ),
        returnValue: _i4.Future<List<_i2.UserModel>>.value(<_i2.UserModel>[]),
      ) as _i4.Future<List<_i2.UserModel>>);
  @override
  _i4.Future<bool> updateUserPassword(
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
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
