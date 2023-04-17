import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/user.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_event.dart';
import 'package:lomba_frontend/presentation/users/bloc/user_state.dart';

void main() {
  const tUser = User(
      id: '1',
      name: 'Test User',
      username: 'test',
      email: 'te@mp.com',
      enabled: true,
      builtIn: false);

  const tOnUserLoad = OnUserLoad('');
  const t_OnUserLoad = OnUserLoad('');
  const tOnUserListLoad = OnUserListLoad('', '', <String, int>{}, 1, 10);
  const t_OnUserListLoad = OnUserListLoad('', '', <String, int>{}, 1, 10);
  const tOnUserAdd = OnUserAdd('', '', '', '');
  const t_OnUserAdd = OnUserAdd('', '', '', '');
  const tOnUserPrepareForAdd = OnUserPrepareForAdd();
  const t_OnUserPrepareForAdd = OnUserPrepareForAdd();
  const tOnUserPrepareForEdit = OnUserPrepareForEdit(tUser);
  const t_OnUserPrepareForEdit = OnUserPrepareForEdit(tUser);
  final tOnUserValidate = OnUserValidate('', '', UserAdding(true, true));
  final t_OnUserValidate = OnUserValidate('', '', UserAdding(true, true));
  final tOnUserValidateEdit =
      OnUserValidateEdit('', '', '', UserEditing(true, true, tUser));
  final t_OnUserValidateEdit =
      OnUserValidateEdit('', '', '', UserEditing(true, true, tUser));
  const tOnUserEdit = OnUserEdit('', '', '', '', true);
  const t_OnUserEdit = OnUserEdit('', '', '', '', true);
  const tOnUserEnable = OnUserEnable('', true, '');
  const t_OnUserEnable = OnUserEnable('', true, '');
  const tOnUserDelete = OnUserDelete('', '');
  const t_OnUserDelete = OnUserDelete('', '');
  const tOnUserShowPasswordModifyForm = OnUserShowPasswordModifyForm(tUser);
  const t_OnUserShowPasswordModifyForm = OnUserShowPasswordModifyForm(tUser);
  const tOnUserSaveNewPassword = OnUserSaveNewPassword('', tUser);
  const t_OnUserSaveNewPassword = OnUserSaveNewPassword('', tUser);

  group('user event', () {
    test('On User Load', () {
      //act
      final result = tOnUserLoad.props;
      final result2 = t_OnUserLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User List Load', () {
      //act
      final result = tOnUserListLoad.props;
      final result2 = t_OnUserListLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Add', () {
      //act
      final result = tOnUserAdd.props;
      final result2 = t_OnUserAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Prepare For Add', () {
      //act
      final result = tOnUserPrepareForAdd.props;
      final result2 = t_OnUserPrepareForAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Prepare For Edit', () {
      //act
      final result = tOnUserPrepareForEdit.props;
      final result2 = t_OnUserPrepareForEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Validate', () {
      //act
      final result = tOnUserValidate.props;
      final result2 = t_OnUserValidate.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Validate Edit', () {
      //act
      final result = tOnUserValidateEdit.props;
      final result2 = t_OnUserValidateEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Edit', () {
      //act
      final result = tOnUserEdit.props;
      final result2 = t_OnUserEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Enable', () {
      //act
      final result = tOnUserEnable.props;
      final result2 = t_OnUserEnable.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Delete', () {
      //act
      final result = tOnUserDelete.props;
      final result2 = t_OnUserDelete.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Show Password Modify Form', () {
      //act
      final result = tOnUserShowPasswordModifyForm.props;
      final result2 = t_OnUserShowPasswordModifyForm.props;

      //assert
      expect(result, equals(result2));
    });

    test('On User Save New Password', () {
      //act
      final result = tOnUserSaveNewPassword.props;
      final result2 = t_OnUserSaveNewPassword.props;

      //assert
      expect(result, equals(result2));
    });
  });
}
