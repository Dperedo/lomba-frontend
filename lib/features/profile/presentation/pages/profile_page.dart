import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';
import '../../../users/presentation/bloc/user_bloc.dart';
import '../../../users/presentation/bloc/user_event.dart';
import '../../../users/presentation/bloc/user_state.dart';
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state){
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: SingleChildScrollView(
            child: Center(
              child: _bodyProfile(context, state)
            )
          ),
          //body: const Center(child: Text("Página de perfil del usuario")),
          drawer: const SideDrawer(),
        );
      }
    );
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

  Widget _bodyProfile(BuildContext context, ProfileState state){
          if (state is ProfileStart) {
             context.read<ProfileBloc>().add(const OnProfileLoad(null));
          }
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // if (state is UserListLoaded) {
          //   return ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: state.users.length,
          //     itemBuilder: (context, index) {
          //       return Column(
          //         children: [
          //           Row(
          //             children: [
          //               Expanded(
          //                   child: TextButton(
          //                       child: Align(
          //                           alignment: Alignment.centerLeft,
          //                           child: Column(
          //                             children: [
          //                               ListTile(
          //                                 leading: const Icon(Icons.switch_account),
          //                                 title: Text(
          //                                   state.users[index].name,
          //                                   style: const TextStyle(fontSize: 18),
          //                                 ),
          //                                 subtitle: Text(
          //                                     '${state.users[index].username} / ${state.users[index].email}',
          //                                     style: const TextStyle(fontSize: 12)),
          //                               ),
          //                             ],
          //                           )),
          //                       onPressed: () {
          //                         context
          //                             .read<UserBloc>()
          //                             .add(OnUserLoad(state.users[index].id));
          //                       })),
          //               Icon(
          //                   state.users[index].enabled
          //                       ? Icons.toggle_on
          //                       : Icons.toggle_off_outlined,
          //                   size: 40)
          //             ],
          //           ),
          //           const Divider()
          //         ],
          //       );
          //     },
          //   );
          // }

          if (state is ProfileLoaded) {
          return
          SizedBox(
            height: 600,
            width: 400,
            
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: 120, height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png')
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(state.user.name)
                ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(state.user.username)
                  ),
                const SizedBox(height: 10,),
                ListTile(
                  leading: const Icon(Icons.mail),
                  title: Text(state.user.email)
                  ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: const Text('Editar Perfil')
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 200,
                  height: 30,
                  child: ElevatedButton(
                    onPressed: (() {}),
                    child: const Text('Cambiar contraseña')
                  ),
                ),
              ],
            ),
          );
          }
    return const SizedBox();
  }
}
