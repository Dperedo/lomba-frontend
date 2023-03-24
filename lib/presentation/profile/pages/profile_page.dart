import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/validators.dart';
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
          } else if (state is ProfileStart && state.message != "") {
            snackBarNotify(context, state.message, Icons.account_circle);
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
    if (state is ProfileEditing) {
      return AppBar(
          title: const Text("Editando Perfil"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<ProfileBloc>().add(OnProfileStarter());
            },
          ));
    }

    return AppBar(title: const Text("Perfil"));
  }

  Widget _bodyProfile(BuildContext context, ProfileState state) {
    final TextEditingController _repeatPasswordController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    if (state is ProfileStart) {
      context.read<ProfileBloc>().add(const OnProfileLoad(null));
    }
    if (state is ProfileLoading) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.3,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
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
                  onPressed: (() {
                    context.read<ProfileBloc>().add(OnProfileEditPrepare(state.user));
                  }),
                  child: const Text('Editar Perfil')),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: ElevatedButton(
                  onPressed: (() {
                    context.read<ProfileBloc>().add(OnProfileShowPasswordModifyForm(state.user));
                  }),
                  child: const Text('Cambiar contraseña')),
            ),
          ],
        ),
      );
    }

    if (state is ProfileEditing) {
      nameController.text = state.user.name;
      usernameController.text = state.user.username;
      emailController.text = state.user.email;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) => Validators.validateName(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    icon: Icon(Icons.account_box),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(OnProfileValidate(
                        state.user.id,
                        usernameController.text,
                        emailController.text,
                        state));
                  },
                  controller: usernameController,
                  validator: (value) => state.validateUsername(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(OnProfileValidate(
                        state.user.id,
                        usernameController.text,
                        emailController.text,
                        state));
                  },
                  controller: emailController,
                  validator: (value) => state.validateEmail(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<ProfileBloc>()
                                .add(OnProfileLoad(state.user.id));
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<ProfileBloc>().add(OnProfileEdit(
                                  state.user.id,
                                  nameController.text,
                                  usernameController.text,
                                  emailController.text));
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Guardar')),
                    ),
                  ],
                )
              ],
            )),
      );
    }
    if (state is ProfileUpdatePassword) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _key,
          child: Column(children: [
            ListTile(
              leading: const Icon(Icons.switch_account_rounded),
              title:
                  Text(state.user.name, style: const TextStyle(fontSize: 22)),
            ),
            //const Divider(),
            TextFormField(
              controller: _passwordController,
              key: const ValueKey("password"),
              validator: (value) => Validators.validatePassword(value ?? ""),
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Ingrese nueva contraseña',
                suffixIcon: Icon(Icons.password),
              ),
            ),
            TextFormField(
              controller: _repeatPasswordController,
              key: const ValueKey("repeatPassword"),
              validator: (value) => Validators.validatePasswordEqual(
                  value ?? "", _passwordController.text),
              decoration: const InputDecoration(
                labelText: 'Repetir Contraseña',
                hintText: 'Repita nueva contraseña',
                suffixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.cancel),
                  key: const ValueKey("btnViewCancelarCambios"),
                  label: const Text("Cancelar"),
                  onPressed: () {
                    context.read<ProfileBloc>().add(OnProfileLoad(state.user.id));
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  key: const ValueKey("btnViewSaveNewPassword"),
                  label: const Text("Guardar cambios"),
                  onPressed: () {
                    if (_key.currentState?.validate() == true) {
                      context.read<ProfileBloc>().add(OnProfileSaveNewPassword(
                          _passwordController.text, state.user));
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text('Contraseña modificada'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Ok'))
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ]),
        ),
      );
    }

    return const SizedBox();
  }
}
