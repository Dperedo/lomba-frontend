import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/presentation/detailed_list/bloc/detailedList_bloc.dart';
import 'package:lomba_frontend/presentation/flow/bloc/flow_event.dart';
import 'package:lomba_frontend/presentation/stage/bloc/stage_event.dart';
import '../../addcontent/bloc/addcontent_bloc.dart';
import '../../addcontent/bloc/addcontent_event.dart';
import '../../approved/bloc/approved_bloc.dart';
import '../../approved/bloc/approved_event.dart';
import '../../demolist/bloc/demolist_bloc.dart';
import '../../demolist/bloc/demolist_event.dart';
import '../../detailed_list/bloc/detailed_list_event.dart';
import '../../flow/bloc/flow_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/bloc/home_event.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/bloc/login_event.dart';
import '../../orgas/bloc/orga_bloc.dart';
import '../../orgas/bloc/orga_event.dart';
import '../../popular/bloc/popular_bloc.dart';
import '../../popular/bloc/popular_event.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';
import '../../rejected/bloc/rejected_bloc.dart';
import '../../rejected/bloc/rejected_event.dart';
import '../../roles/bloc/role_bloc.dart';
import '../../roles/bloc/role_event.dart';
import '../../stage/bloc/stage_bloc.dart';
import '../../tobeapproved/bloc/tobeapproved_bloc.dart';
import '../../tobeapproved/bloc/tobeapproved_event.dart';
import '../../uploaded/bloc/uploaded_bloc.dart';
import '../../uploaded/bloc/uploaded_event.dart';
import '../../users/bloc/user_bloc.dart';
import '../../users/bloc/user_event.dart';
import '../../voted/bloc/voted_bloc.dart';
import '../../voted/bloc/voted_event.dart';
import 'nav_event.dart';
import 'nav_state.dart';

///BLOC de navegación para las pantallas de la aplicación.
///
///Considera sólo un evento [NavigateTo] que indica a qué página se
///desea navegar, con eso emite un estado con el destino a navegar.

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const NavState(NavItem.pageHome)) {
    on<NavigateTo>(
      (event, emit) async {
        if (event.destination != state.selectedItem) {
          switch (state.selectedItem) {
            case NavItem.pageVoted:
              {
                event.context.read<VotedBloc>().add(OnVotedStarter());
              }
              break;
            case NavItem.pageHome:
              {
                event.context.read<HomeBloc>().add(const OnHomeStarter(''));
              }
              break;
            case NavItem.pageLogin:
              {
                event.context.read<LoginBloc>().add(OnLoginStarter());
              }
              break;
            case NavItem.pageLogOff:
              {
                event.context.read<HomeBloc>().add(const OnHomeStarter(''));
              }
              break;
            case NavItem.pageOrgas:
              {
                event.context.read<OrgaBloc>().add(OnOrgaStarter());
              }
              break;
            case NavItem.pageRoles:
              {
                event.context.read<RoleBloc>().add(OnRoleStarter());
              }
              break;
            case NavItem.pageUsers:
              {
                event.context.read<UserBloc>().add(OnUserStarter());
              }
              break;
            case NavItem.pageAddContent:
              {
                event.context.read<AddContentBloc>().add(OnAddContentStarter());
              }
              break;
            case NavItem.pageApproved:
              {
                event.context.read<ApprovedBloc>().add(OnApprovedStarter());
              }
              break;
            case NavItem.pagePopular:
              {
                event.context.read<PopularBloc>().add(OnPopularStarter());
              }
              break;
            case NavItem.pageRejected:
              {
                event.context.read<RejectedBloc>().add(OnRejectedStarter());
              }
              break;
            case NavItem.pageToBeApproved:
              {
                event.context
                    .read<ToBeApprovedBloc>()
                    .add(OnToBeApprovedStarter());
              }
              break;
            case NavItem.pageUploaded:
              {
                event.context.read<UploadedBloc>().add(OnUploadedStarter());
              }
              break;
            case NavItem.pageProfile:
              {
                event.context.read<ProfileBloc>().add(OnProfileStarter());
              }
              break;
            case NavItem.pageDemoList:
              {
                event.context.read<DemoListBloc>().add(OnDemoListStarter());
              }
              break;
            case NavItem.pageDetailedList:
              {
                event.context.read<DetailedListBloc>().add(const OnDetailedListStarter(''));
              }
              break;
            case NavItem.pageFlow:
              {
                event.context.read<FlowBloc>().add(const OnFlowListStarter());
              }
              break;
            case NavItem.pageStage:
              {
                event.context.read<StageBloc>().add(const OnStageListStarter());
              }
              break;
          }
          emit(NavState(event.destination));
        }
      },
    );
  }
}
