import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/orga.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_event.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orga_state.dart';

void main() {
  const tOrga = Orga(
      id: '1', name: 'Test Orga', code: 'test', enabled: true, builtIn: false);

  const tOnOrgaLoad = OnOrgaLoad('');
  const t_OnOrgaLoad = OnOrgaLoad('');
  const tOnOrgaListLoad = OnOrgaListLoad('', '', 1.0);
  const t_OnOrgaListLoad = OnOrgaListLoad('', '', 1.0);
  const tOnOrgaAdd = OnOrgaAdd('', '', true);
  const t_OnOrgaAdd = OnOrgaAdd('', '', true);
  final tOnOrgaValidate = OnOrgaValidate('', '', OrgaAdding(true, true));
  final t_OnOrgaValidate = OnOrgaValidate('', '', OrgaAdding(true, true));
  const tOnOrgaPrepareForAdd = OnOrgaPrepareForAdd();
  const t_OnOrgaPrepareForAdd = OnOrgaPrepareForAdd();
  const tOnOrgaEdit = OnOrgaEdit('', '', '', true);
  const t_OnOrgaEdit = OnOrgaEdit('', '', '', true);
  const tOnOrgaSaveNewOrga = OnOrgaSaveNewOrga('', '');
  const t_OnOrgaSaveNewOrga = OnOrgaSaveNewOrga('', '');
  const tOnOrgaPrepareForEdit = OnOrgaPrepareForEdit(tOrga);
  const t_OnOrgaPrepareForEdit = OnOrgaPrepareForEdit(tOrga);
  final tOnOrgaValidateEdit = OnOrgaValidateEdit('', OrgaEditing(tOrga, true));
  final t_OnOrgaValidateEdit = OnOrgaValidateEdit('', OrgaEditing(tOrga, true));

  final tOnOrgaShowAddOrgaForm = OnOrgaShowAddOrgaForm();
  final t_OnOrgaShowAddOrgaForm = OnOrgaShowAddOrgaForm();

  group('orga event', () {
    test('On Orga Load', () {
      //act
      final result = tOnOrgaLoad.props;
      final result2 = t_OnOrgaLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga List Load', () {
      //act
      final result = tOnOrgaListLoad.props;
      final result2 = t_OnOrgaListLoad.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Add', () {
      //act
      final result = tOnOrgaAdd.props;
      final result2 = t_OnOrgaAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Validate', () {
      //act
      final result = tOnOrgaValidate.props;
      final result2 = t_OnOrgaValidate.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Prepare For Add', () {
      //act
      final result = tOnOrgaPrepareForAdd.props;
      final result2 = t_OnOrgaPrepareForAdd.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Edit', () {
      //act
      final result = tOnOrgaEdit.props;
      final result2 = t_OnOrgaEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Save New Orga', () {
      //act
      final result = tOnOrgaSaveNewOrga.props;
      final result2 = t_OnOrgaSaveNewOrga.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Prepare For Edit', () {
      //act
      final result = tOnOrgaPrepareForEdit.props;
      final result2 = t_OnOrgaPrepareForEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Prepare For Edit', () {
      //act
      final result = tOnOrgaPrepareForEdit.props;
      final result2 = t_OnOrgaPrepareForEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Validate Edit', () {
      //act
      final result = tOnOrgaValidateEdit.props;
      final result2 = t_OnOrgaValidateEdit.props;

      //assert
      expect(result, equals(result2));
    });

    test('On Orga Show Add Orga Form', () {
      //act
      final result = tOnOrgaShowAddOrgaForm.props;
      final result2 = t_OnOrgaShowAddOrgaForm.props;

      //assert
      expect(result, equals(result2));
    });
  });
}
