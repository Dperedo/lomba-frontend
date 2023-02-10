// this is the state the user is expected to see

///El estado de navegación considera el item seleccionado para navegar.
///
///El [selectedItem] indica cuál es la página donde deberíamos estar parados.
class NavState {
  final NavItem selectedItem;
  const NavState(this.selectedItem);
}

// helpful navigation pages, you can change
// them to support your pages

///Enumeración con todas las páginas disponibles o posibles.
enum NavItem {
  pageHome,
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
  pageDemoList
}
