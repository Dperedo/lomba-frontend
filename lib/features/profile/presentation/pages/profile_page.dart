import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../sidedrawer/presentation/pages/sidedrawer_page.dart';
import '../../../users/presentation/bloc/user_bloc.dart';
import '../../../users/presentation/bloc/user_event.dart';
import '../../../users/presentation/bloc/user_state.dart';

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state){
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: _bodyProfile(context, state),
          //body: const Center(child: Text("Página de perfil del usuario")),
          drawer: const SideDrawer(),
        );
      }
    );
  }

  AppBar _variableAppBar(BuildContext context, UserState state) {
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

  Widget _bodyProfile(BuildContext conext, state){
    SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: 600,
            width: 400,
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
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
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Nombre')
                ),
                const SizedBox(height: 10,),
                const ListTile(
                  leading: Icon(Icons.person_outline),
                  title: Text('Username')
                  ),
                const SizedBox(height: 10,),
                const ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('Email')
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
          ),
        )
      );
    return const SizedBox();
  }
}
