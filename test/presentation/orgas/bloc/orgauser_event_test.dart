import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/data/models/sort_model.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_event.dart';

void main() {
  
  const tOnOrgaUserStarter = OnOrgaUserStarter();
  const t_OnOrgaUserStarter = OnOrgaUserStarter();
  const tOnOrgaUserListLoad = OnOrgaUserListLoad('');
  const t_OnOrgaUserListLoad = OnOrgaUserListLoad('');
  const tOnOrgaUserAdd = OnOrgaUserAdd('','',[],true,'');
  const t_OnOrgaUserAdd = OnOrgaUserAdd('','',[],true,'');
  const tOnOrgaUserEdit = OnOrgaUserEdit('','',[],true);
  const t_OnOrgaUserEdit = OnOrgaUserEdit('','',[],true);
  const tOnOrgaUserListUserNotInOrgaForAdd = OnOrgaUserListUserNotInOrgaForAdd('',SortModel(<String, int>{'created': 1}),1,10);
  const t_OnOrgaUserListUserNotInOrgaForAdd = OnOrgaUserListUserNotInOrgaForAdd('',SortModel(<String, int>{'created': 1}),1,10);
  const tOnOrgaUserEnable = OnOrgaUserEnable('','',false);
  const t_OnOrgaUserEnable = OnOrgaUserEnable('','',false);
  const tOnOrgaUserDelete = OnOrgaUserDelete('','','');
  const t_OnOrgaUserDelete = OnOrgaUserDelete('','','');

  group('orga user event', () {
    test('On Orga User Starter', () {
      //act
      final result = tOnOrgaUserStarter.props;
      final result2 = t_OnOrgaUserStarter.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User List Load', () {
      //act
      final result = tOnOrgaUserListLoad.props;
      final result2 = t_OnOrgaUserListLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User Add', () {
      //act
      final result = tOnOrgaUserAdd.props;
      final result2 = t_OnOrgaUserAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User Edit', () {
      //act
      final result = tOnOrgaUserEdit.props;
      final result2 = t_OnOrgaUserEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User List User Not In Orga For Add', () {
      //act
      final result = tOnOrgaUserListUserNotInOrgaForAdd.props;
      final result2 = t_OnOrgaUserListUserNotInOrgaForAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User Enable', () {
      //act
      final result = tOnOrgaUserEnable.props;
      final result2 = t_OnOrgaUserEnable.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga User Delete', () {
      //act
      final result = tOnOrgaUserDelete.props;
      final result2 = t_OnOrgaUserDelete.props;

      //assert
      expect(result, equals(result2));
    });
  });
}