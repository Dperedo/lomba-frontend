import 'package:flutter_test/flutter_test.dart';
import 'package:lomba_frontend/presentation/sidedrawer/bloc/sidedrawer_event.dart';

void main() {
  
  const tOnSideDrawerLoading = OnSideDrawerLoading();
  const t_OnSideDrawerLoading = OnSideDrawerLoading();
  const tOnSideDrawerChangeOrga = OnSideDrawerChangeOrga('');
  const t_OnSideDrawerChangeOrga = OnSideDrawerChangeOrga('');
  const tOnSideDrawerReady = OnSideDrawerReady();
  const t_OnSideDrawerReady = OnSideDrawerReady();
  const tOnSideDrawerLogOff = OnSideDrawerLogOff();
  const t_OnSideDrawerLogOff = OnSideDrawerLogOff();

  group('sidedrawer event', () {
    test('On SideDrawer Loading', () {
      //act
      final result = tOnSideDrawerLoading.props;
      final result2 = t_OnSideDrawerLoading.props;

      //assert
      expect(result, equals(result2));
    });

    test('On SideDrawer Change Orga', () {
      //act
      final result = tOnSideDrawerChangeOrga.props;
      final result2 = t_OnSideDrawerChangeOrga.props;

      //assert
      expect(result, equals(result2));
    });

    test('On SideDrawer Ready', () {
      //act
      final result = tOnSideDrawerReady.props;
      final result2 = t_OnSideDrawerReady.props;

      //assert
      expect(result, equals(result2));
    });

    test('On SideDrawer Log Off', () {
      //act
      final result = tOnSideDrawerLogOff.props;
      final result2 = t_OnSideDrawerLogOff.props;

      //assert
      expect(result, equals(result2));
    });
  });
}