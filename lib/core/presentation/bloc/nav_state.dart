// this is the state the user is expected to see
class NavState {
  final NavItem selectedItem;
  const NavState(this.selectedItem);
}

// helpful navigation pages, you can change
// them to support your pages
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
  pageViewed,
  pageProfile
}
