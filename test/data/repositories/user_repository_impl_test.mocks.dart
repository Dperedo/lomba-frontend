// Mocks generated by Mockito 5.3.2 from annotations
// in lomba_frontend/test/data/repositories/user_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:lomba_frontend/core/model_container.dart' as _i2;
import 'package:lomba_frontend/data/datasources/user_data_source.dart' as _i4;
import 'package:lomba_frontend/data/models/user_model.dart' as _i3;
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

class _FakeModelContainer_0<T> extends _i1.SmartFake
    implements _i2.ModelContainer<T> {
  _FakeModelContainer_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUserModel_1 extends _i1.SmartFake implements _i3.UserModel {
  _FakeUserModel_1(
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
    implements _i4.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.ModelContainer<_i3.UserModel>> getUsers(
    String? searchText,
    String? orgaId,
    List<dynamic>? order,
    int? pageIndex,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsers,
          [
            searchText,
            orgaId,
            order,
            pageIndex,
            pageSize,
          ],
        ),
        returnValue: _i5.Future<_i2.ModelContainer<_i3.UserModel>>.value(
            _FakeModelContainer_0<_i3.UserModel>(
          this,
          Invocation.method(
            #getUsers,
            [
              searchText,
              orgaId,
              order,
              pageIndex,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i2.ModelContainer<_i3.UserModel>>);
  @override
  _i5.Future<_i3.UserModel> getUser(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #getUser,
          [userId],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_1(
          this,
          Invocation.method(
            #getUser,
            [userId],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<_i3.UserModel> addUser(_i3.UserModel? user) => (super.noSuchMethod(
        Invocation.method(
          #addUser,
          [user],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_1(
          this,
          Invocation.method(
            #addUser,
            [user],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<bool> deleteUser(String? userId) => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [userId],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> enableUser(
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
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<_i3.UserModel> updateUser(
    String? userId,
    _i3.UserModel? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_1(
          this,
          Invocation.method(
            #updateUser,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<_i3.UserModel> updateProfile(
    String? userId,
    _i3.UserModel? user,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProfile,
          [
            userId,
            user,
          ],
        ),
        returnValue: _i5.Future<_i3.UserModel>.value(_FakeUserModel_1(
          this,
          Invocation.method(
            #updateProfile,
            [
              userId,
              user,
            ],
          ),
        )),
      ) as _i5.Future<_i3.UserModel>);
  @override
  _i5.Future<_i3.UserModel?> existsUser(
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
        returnValue: _i5.Future<_i3.UserModel?>.value(),
      ) as _i5.Future<_i3.UserModel?>);
  @override
  _i5.Future<_i3.UserModel?> existsProfile(
    String? userId,
    String? username,
    String? email,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #existsProfile,
          [
            userId,
            username,
            email,
          ],
        ),
        returnValue: _i5.Future<_i3.UserModel?>.value(),
      ) as _i5.Future<_i3.UserModel?>);
  @override
  _i5.Future<_i2.ModelContainer<_i3.UserModel>> getUsersNotInOrga(
    String? searchText,
    String? orgaId,
    List<dynamic>? order,
    int? pageIndex,
    int? pageSize,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUsersNotInOrga,
          [
            searchText,
            orgaId,
            order,
            pageIndex,
            pageSize,
          ],
        ),
        returnValue: _i5.Future<_i2.ModelContainer<_i3.UserModel>>.value(
            _FakeModelContainer_0<_i3.UserModel>(
          this,
          Invocation.method(
            #getUsersNotInOrga,
            [
              searchText,
              orgaId,
              order,
              pageIndex,
              pageSize,
            ],
          ),
        )),
      ) as _i5.Future<_i2.ModelContainer<_i3.UserModel>>);
  @override
  _i5.Future<bool> updateUserPassword(
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
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> updateProfilePassword(
    String? userId,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProfilePassword,
          [
            userId,
            password,
          ],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}
