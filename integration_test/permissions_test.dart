import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import "package:front_lomba/main.dart" as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Hacer login en Lomba', (tester) async {
      //Levanta la aplicación.
      app.main();

      //Este comando se repite mucho. La función que tiene es
      //hacer esperar al test hasta que las animaciones de
      //los objetos o sus transiciones terminen de ejecutarse.
      //Según la documentación dice que espera a que todos los frames
      //de animación programados terminen de mostrarse.
      await tester.pumpAndSettle();

      //Estamos en la página inicial que es el login.

      //Se especifican los input y el botón entrar.
      final login = find.byKey(const Key("input_login"));
      final pass = find.byKey(const Key("input_password"));
      final ingresar = find.byKey(const Key("button_enter"));

      //se ingresan los valores en cada input.
      await tester.enterText(login, "superadmin");
      await tester.enterText(pass, "superadmin");
      await tester.tap(ingresar);

      //Se la da tiempo el test para que espere mientras se cargan los cambios
      //en la pantalla.
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //Nos aseguramos de estar en la página de inicio. Tiene este ID (key)
      expect(find.byKey(const Key("page_inicio")), findsOneWidget);

      //Se abre el menú izquierdo. Este es el comando apropiado para abrir
      //el menú. Esto sólo opera pensando en el chrome restaurado y no
      //maximizado.
      await tester.dragFrom(const Offset(0, 0), const Offset(300, 0));

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //Se obtiene la opción de menú para Permisos.
      final moPermisos = find.byKey(const Key("menuopt_permisos"));
      await tester.tap(moPermisos);

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      /*
      Se comprueba que la página de permisos esté cargada
      */
      expect(find.text("Permisos"), findsWidgets);
      await Future<void>.delayed(const Duration(milliseconds: 5000));

      /*
      Se comprueba que los 3 permisos principales estén en pantalla.
      */
      expect(find.text("basic"), findsOneWidget);
      expect(find.text("superadmin"), findsOneWidget);
      expect(find.text("admin"), findsOneWidget);

      /*
      Se obtiene el primer objeto botón para deshabilitar un permiso.
      En este caso toma el permiso del administrador (admin) 
      */
      final rowadmin = find.byType(FloatingActionButton).first;
      await tester.tap(rowadmin);

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      /*Se comprueba que en pantalla esté disponible el botón Sí del
      diálogo que pregunta si está seguro o no de deshabilitar.
      */
      expect(find.text("Sí"), findsOneWidget);

      /*
      Ahora se obtiene el botón dle Sí para seleccionarlo.
       */
      final yes = find.byKey(const Key("button_yes"));
      await tester.tap(yes);

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      /*
      Se verifica que el mensaje de permiso desactivado esté en pantalla.
       */
      expect(find.text("Se ha desactivado el permiso"), findsOneWidget);

      //Ahora activación del permiso

      //se abre menú.
      await tester.dragFrom(const Offset(0, 0), const Offset(300, 0));

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //se selecciona la opción de menú de Permisos.
      await tester.tap(moPermisos);
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //verifica que en la pantalla diga Permisos.
      expect(find.text("Permisos"), findsWidgets);
      await Future<void>.delayed(const Duration(milliseconds: 5000));

      //se verifican los 3 permisos en pantalla.
      expect(find.text("basic"), findsOneWidget);
      expect(find.text("superadmin"), findsOneWidget);
      expect(find.text("admin"), findsOneWidget);

      //click o tap en el botón de activación (es el mismo que desactiva)
      await tester.tap(rowadmin);
      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //verifica que exista el botón Sí en pantalla.
      expect(find.text("Sí"), findsOneWidget);

      //tap en botón sí.
      await tester.tap(yes);

      await Future<void>.delayed(const Duration(milliseconds: 1000));
      await tester.pumpAndSettle();

      //Se verifica que aparezca el texto de confirmación en pantalla.
      expect(find.text("Se ha Activado el permiso"), findsOneWidget);
    });
  });
}
