import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/domain/entities/orgauser.dart';
import 'package:lomba_frontend/presentation/orgas/bloc/orgauser_cubit.dart';

main() {
  const tOrgaUser = OrgaUser(
      userId: '', orgaId: '', roles: [], enabled: false, builtIn: false);

  late OrgaUserDialogEditState testStateChangeValue =
      OrgaUserDialogEditState('clave', true);
  setUp(() {
    testStateChangeValue.checks
        .addEntries(<String, bool>{"clave": true}.entries);
  });

  blocTest<OrgaUserDialogEditCubit, OrgaUserDialogEditState>(
    'OrgaUserDialogEditCubit change check value',
    build: () => OrgaUserDialogEditCubit(tOrgaUser),
    act: (cubit) => cubit.changeValue('clave', true),
    wait: const Duration(milliseconds: 500),
    expect: () => [testStateChangeValue],
  );
}
