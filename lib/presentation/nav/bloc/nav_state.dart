// this is the state the user is expected to see

import 'package:equatable/equatable.dart';

///El estado de navegación considera el item seleccionado para navegar.
///
///El [selectedItem] indica cuál es la página donde deberíamos estar parados.

class NavState extends Equatable {
  final NavItem selectedItem;
  const NavState(this.selectedItem, this.args);
  final Map<String, dynamic>? args;
  @override
  List<Object> get props => [selectedItem];
}

// helpful navigation pages, you can change
// them to support your pages

///Enumeración con todas las páginas disponibles o posibles.
enum NavItem {
  pageRecent,
  pageLogin,
  pageLogOff,
  pageOrgas,
  pageRoles,
  pageUsers,
  pageAddContent,
  pageApproved,
  pagePopular,
  pageRejected,
  pageToBeApproved,
  pageUploaded,
  pageVoted,
  pageProfile,
  pageDemoList,
  pageDetailedList,
  pageFlow,
  pageStage,
  pageSettingSuper,
  pageSettingAdmin,
  pagePost,
}
