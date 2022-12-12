// this is the state the user is expected to see
class NavState {
  final NavItem selectedItem;
  const NavState(this.selectedItem);
}

// helpful navigation pages, you can change
// them to support your pages
enum NavItem {
  page_home,
  page_login,
  page_logoff,
  page_orgas,
  page_roles,
  page_users,
}
