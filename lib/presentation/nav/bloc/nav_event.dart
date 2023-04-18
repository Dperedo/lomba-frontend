// this import is needed to import NavItem,
// which we'll use to represent the item the user has selected
import 'package:flutter/widgets.dart';

import 'nav_state.dart';

// it's important to use an abstract class, even if you have one
// event, so that you can use it later in your BLoC and or tests

///Clase abstracta para el evento. Todos los eventos deben heredar de ella.
abstract class NavEvent {
  const NavEvent();
}

// this is the event that's triggered when the user
// wants to change pages
/// Evento de navegación, considera el atributo de destino.
///
/// Al momento de invocar el evento se le debe informar el destino o página de
/// destino
class NavigateTo extends NavEvent {
  final NavItem destination;
  final BuildContext context;
  final Map<String, dynamic>? args;
  const NavigateTo(this.destination, this.context, this.args);
}
