import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/widgets/snackbar_notification.dart';
import '../../users/bloc/user_bloc.dart';
import '../../users/bloc/user_event.dart';
import '../../users/bloc/user_state.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError && state.message != "") {
            snackBarNotify(context, state.message, Icons.cancel_outlined);
          }
        },
        child: ScaffoldManager(
          title: _variableAppBar(context, state),
          child: SingleChildScrollView(
              child: Center(
                  child: BodyFormatter(
            screenWidth: MediaQuery.of(context).size.width,
            child: _bodyProfile(context, state),
          ))),
        ),
      );
    });
  }

  AppBar _variableAppBar(BuildContext context, ProfileState state) {
    if (state is UserLoaded) {
      return AppBar(
          title: const Text("Perfil"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<UserBloc>().add(const OnUserListLoad("", "", "", 1));
            },
          ));
    }

    return AppBar(title: const Text("Perfil"));
  }

  Widget _bodyProfile(BuildContext context, ProfileState state) {
    if (state is ProfileStart) {
      context.read<ProfileBloc>().add(const OnProfileLoad(null));
    }
    if (state is ProfileLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is ProfileLoaded) {
      return SizedBox(
        width: 600,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Icon(
                      Icons.person,
                      size: 70,
                    ) //Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
                    ),
              ),
            ),
            //const SizedBox(height: 15,),
            ListTile(
                leading: const Icon(Icons.person),
                title: Text(state.user.name)),
            //const SizedBox(height: 10,),
            ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(state.user.username)),
            //const SizedBox(height: 10,),
            ListTile(
                leading: const Icon(Icons.mail), title: Text(state.user.email)),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                  onPressed: (() {}), child: const Text('Editar Perfil')),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                  onPressed: (() {
                    //context.read<NavBloc>().add(const NavigateTo(NavItem.page));
                  }),
                  child: const Text('Cambiar contraseña')),
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
