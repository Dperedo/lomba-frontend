import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_network/image_network.dart';
import 'package:lomba_frontend/core/widgets/body_formatter.dart';
import 'package:lomba_frontend/core/widgets/scaffold_manager.dart';

import '../../../core/validators.dart';
import '../../../core/widgets/snackbar_notification.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../injection.dart' as di;

///Página con el perfil del usuario
///
///La página es sólo para usuarios con sesión activa.
///Se deberían indicar aquí datos personales, contraseña, foto y demás
///cosas del usuario.
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _keyUpdatePassword = GlobalKey<FormState>();
  final GlobalKey<FormState> _keyProfileEditing = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is ProfileError && state.message != "") {
        snackBarNotify(context, state.message, Icons.cancel_outlined);
      } else if (state is ProfileStart && state.message != "") {
        snackBarNotify(context, state.message, Icons.account_circle);
      }
    }, child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return ScaffoldManager(
        title: _variableAppBar(context, state),
        child: SingleChildScrollView(
            child: Center(
                child: BodyFormatter(
          screenWidth: MediaQuery.of(context).size.width,
          child: _bodyProfile(context, state),
        ))),
      );
    }));
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
    final TextEditingController _repeatPasswordController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    if (state is ProfileStart) {
      context.read<ProfileBloc>().add(const OnProfileLoad(null, null));
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
      return BlocProvider<ProfileLiveCubit>(
        create: (context) =>
            ProfileLiveCubit(di.locator(), di.locator(), di.locator()),
        child: SizedBox(
          width: 600,
          child: BlocBuilder<ProfileLiveCubit, ProfileLiveState>(
            builder: (context, statecubit) {
              return Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Stack(
                        children: [
                          statecubit.fileId != "" ||
                                  state.user.pictureUrl != null
                              ? state.user.pictureUrl != null &&
                                      statecubit.fileId == ""
                                  ? ClipOval(
                                      child: ImageNetwork(
                                        image: state.user.pictureUrl!,
                                        height: 200,
                                        width: 200,
                                      ),
                                    )
                                  : Container(
                                      width: 200.0,
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                            statecubit.mediafile,
                                          ),
                                        ),
                                      ),
                                    )
                              : statecubit.showLocalProgress
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator())
                                  : const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 100,
                                      ),
                                    ),
                          statecubit.fileId != ""
                              ? Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    alignment: Alignment.topRight,
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () {
                                      context
                                          .read<ProfileLiveCubit>()
                                          .stopRemoteProgressIndicators();
                                      context
                                          .read<ProfileLiveCubit>()
                                          .removeMedia();
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: [
                                  'jpg',
                                  'png',
                                  'gif',
                                  'jpeg',
                                ],
                              );
                              if (result != null) {
                                context
                                    .read<ProfileLiveCubit>()
                                    .startProgressIndicators();
                                PlatformFile file = result.files.first;
                                if (file.size != 0) {
                                  Uint8List? fileBytes;
                                  if (!kIsWeb) {
                                    fileBytes =
                                        File(file.path!).readAsBytesSync();
                                  } else
                                    fileBytes = file.bytes;
                                  context.read<ProfileLiveCubit>().showImage(
                                        context,
                                        fileBytes!,
                                        state.user.id,
                                        state.orgaId,
                                      );
                                } else {
                                  snackBarNotify(
                                      context,
                                      "El archivo no puede estar vacío",
                                      Icons.error);
                                }
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  statecubit.cloudFile?.id != null ||
                          statecubit.showLocalProgress
                      ? SizedBox(
                          width: 110,
                          height: 30,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            key: const ValueKey("btnSavedUp"),
                            label: const Text("Guardar"),
                            onPressed: statecubit.showRemoteProgress
                                ? null
                                : () {
                                    context
                                        .read<ProfileBloc>()
                                        .add(OnProfileSaveImagen(
                                          state.user,
                                          statecubit.mediafile,
                                          statecubit.cloudFile!.url,
                                          statecubit.cloudFile!.id,
                                        ));
                                  },
                          ),
                        )
                      : const SizedBox(
                          height: 30,
                        ),
                  const SizedBox(
                    height: 10,
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
                      leading: const Icon(Icons.mail),
                      title: Text(state.user.email)),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: (() {
                          context
                              .read<ProfileBloc>()
                              .add(OnProfileEditPrepare(state.user));
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
                          context
                              .read<ProfileBloc>()
                              .add(OnProfileShowPasswordModifyForm(state.user));
                        }),
                        child: const Text('Cambiar contraseña')),
                  ),
                ],
              );
            },
          ),
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
            key: _keyProfileEditing,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validators.validateName(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    icon: Icon(Icons.account_box),
                  ),
                ),
                TextFormField(
                  onChanged: (value) {
                    if (value != state.user.username) {
                      context.read<ProfileBloc>().add(OnProfileValidate(
                          state.user.id,
                          usernameController.text,
                          emailController.text,
                          state));
                    }
                  },
                  textInputAction: TextInputAction.next,
                  controller: usernameController,
                  validator: (value) => state.validateUsername(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ),
                TextFormField(
                  textInputAction: TextInputAction.none,
                  onChanged: (value) {
                    if (value != state.user.email) {
                      context.read<ProfileBloc>().add(OnProfileValidate(
                          state.user.id,
                          usernameController.text,
                          emailController.text,
                          state));
                    }
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
                            showDialog(
                                context: context,
                                builder: (context) => GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: AlertDialog(
                                        title: const Text(
                                            '¿Desea salir de la edición del usuario?'),
                                        content: const Text(
                                            'Los cambios no han sido guardados'),
                                        actions: <Widget>[
                                          TextButton(
                                            key: const ValueKey("btnYesExit"),
                                            child: const Text('Sí, salir'),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          TextButton(
                                            key: const ValueKey(
                                                "btnKeepEditing"),
                                            child:
                                                const Text('Seguir editando'),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                        ],
                                      ),
                                    )).then((value) => {
                                  if (value)
                                    {
                                      context.read<ProfileBloc>().add(
                                          OnProfileLoad(state.user.id, null))
                                    }
                                });
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_keyProfileEditing.currentState?.validate() ==
                                true) {
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
          key: _keyUpdatePassword,
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
              obscureText: true,
              obscuringCharacter: '*',
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
              obscureText: true,
              obscuringCharacter: '*',
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
                    context
                        .read<ProfileBloc>()
                        .add(OnProfileLoad(state.user.id, null));
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  key: const ValueKey("btnViewSaveNewPassword"),
                  label: const Text("Guardar cambios"),
                  onPressed: () {
                    if (_keyUpdatePassword.currentState?.validate() == true) {
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
