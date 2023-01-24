
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/validators.dart';
import 'package:lomba_frontend/features/users/presentation/bloc/user_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/pages/sidedrawer_page.dart';

import '../../../../core/validators.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _variableAppBar(context, state),
          body: SingleChildScrollView(
              child: Column(
            children: [
              _bodyUsers(context, state),
            ],
          )),
          floatingActionButton: (state is UserListLoaded || state is UserStart)
              ? FloatingActionButton(
                  key: const ValueKey("btnAddOption"),
                  tooltip: 'Agregar usuario',
                  onPressed: () {
                    context.read<UserBloc>().add(OnUserPrepareForAdd());
                  },
                  child: const Icon(Icons.person_add)
              ): null,
          drawer: const SideDrawer(),
        );
      },
    );
  }

  Widget _bodyUsers(BuildContext context, UserState state) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController repeatPasswordController = TextEditingController();
    final GlobalKey<FormState> _key = GlobalKey<FormState>();

    if (state is UserStart) {
      context.read<UserBloc>().add(const OnUserListLoad("", "", "", 1));
    }
    if (state is UserLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is UserError) {
      return Center(child: Text(state.message));
    }
    if (state is UserListLoaded) {
      return Column(children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.switch_account),
                                      title: Text(
                                        state.users[index].name,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      subtitle: Text(
                                          '${state.users[index].username} / ${state.users[index].email}',
                                          style: const TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                )),
                            onPressed: () {
                              context
                                  .read<UserBloc>()
                                  .add(OnUserLoad(state.users[index].id));
                            })),
                    Icon(
                        state.users[index].enabled
                            ? Icons.toggle_on
                            : Icons.toggle_off_outlined,
                        size: 40)
                  ],
                ),
              ],
            );
          },
        ),
      ]);
    }

    if (state is UserLoaded) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.switch_account_rounded),
              title:
                  Text(state.user.name, style: const TextStyle(fontSize: 22)),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username: ${state.user.username}",
                      style: const TextStyle(fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email: ${state.user.email}",
                      style: const TextStyle(fontSize: 14))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      "Estado: ${(state.user.enabled ? 'Habilitado' : 'Deshabilitado')}")),
            ),
            const Divider(),
            Wrap(
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  key: const ValueKey("btnEditOption"),
                  label: const Text("Modificar"),
                  onPressed: () {
                    context.read<UserBloc>().add(OnUserPrepareForEdit(state.user));
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  key: const ValueKey("btnDeleteOption"),
                  label: const Text("Eliminar"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AlertDialog(
                                title:
                                    const Text('¿Desea eliminar el usuario?'),
                                content:
                                    const Text('La eliminación es permanente'),
                                actions: <Widget>[
                                  TextButton(
                                    key: const ValueKey("btnConfirmDelete"),
                                    child: const Text('Eliminar'),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  TextButton(
                                    key: const ValueKey("btnCancelDelete"),
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ],
                              ),
                            )).then((value) => {
                          if (value)
                            {
                              context
                                  .read<UserBloc>()
                                  .add(OnUserDelete(state.user.id))
                            }
                        });
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: Icon(!state.user.enabled
                      ? Icons.toggle_on
                      : Icons.toggle_off_outlined),
                  key: const ValueKey("btnEnableOption"),
                  label:
                      Text((state.user.enabled ? "Deshabilitar" : "Habilitar")),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: AlertDialog(
                                title: Text(
                                    '¿Desea ${(state.user.enabled ? "deshabilitar" : "habilitar")} el usuario?'),
                                content: const Text(
                                    'Esta acción afecta el acceso del usuario al sistema'),
                                actions: <Widget>[
                                  TextButton(
                                    key: const ValueKey("btnConfirmEnable"),
                                    child: Text((state.user.enabled
                                        ? "Deshabilitar"
                                        : "Habilitar")),
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                  ),
                                  TextButton(
                                    key: const ValueKey("btnCancelEnable"),
                                    child: const Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                  ),
                                ],
                              ),
                            )).then((value) => {
                          if (value)
                            {
                              context.read<UserBloc>().add(OnUserEnable(
                                  state.user.id, !state.user.enabled))
                            }
                        });
                  },
                ),
                const VerticalDivider(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.key),
                  key: const ValueKey("btnViewModifyPasswordFormOption"),
                  label: const Text("Cambiar password"),
                  onPressed: () {
                    context
                        .read<UserBloc>()
                        .add(OnUserShowPasswordModifyForm((state.user)));
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                ElevatedButton.icon(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context
                          .read<UserBloc>()
                          .add(const OnUserListLoad("", "", "", 1));
                    },
                    label: const Text("Volver")),
              ],
            ),
            const Divider(),
          ],
        ),
      );
    }

    if (state is UserUpdatePassword){
      return Padding(
       padding: const EdgeInsets.all(10),
       child: Form(
         key: _key,
         child: Column(
            children: [
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
                validator: (value) => Validators.validatePasswordEqual(value ?? "", _passwordController.text),
                decoration: const InputDecoration(
                  labelText: 'Repetir Contraseña',
                  hintText: 'Repita nueva contraseña',
                  suffixIcon: Icon(Icons.password),
                ),
                
                
                
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.cancel),
                    key: const ValueKey("btnViewCancelarCambios"),
                    label: const Text("Cancelar"),
                    onPressed: () {
                    context.read<UserBloc>().add(OnUserLoad(state.user.id));
                    _passwordController.clear();
                    _repeatPasswordController.clear();
                    },
                    
                  ),
                  const VerticalDivider(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    key: const ValueKey("btnViewSaveNewPassword"),
                    label: const Text("Guardar cambios"),
                    onPressed: () {
                      if (_key.currentState?.validate() == true) {
                          context.read<UserBloc>().add(OnUserSaveNewPassword(_passwordController.text,state.user));
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              //title: const Text('Result'),
                              content: const Text('Contraseña modificada'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                child: const Text('Ok')
                                )
                              ],
                            ),
                          );
                      }
                      _passwordController.clear();
                      _repeatPasswordController.clear();
                    },
                  ),
                ],
              ),
            ]
         ),
       ),
      );
    }    
    if (state is UserAdding) {
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
                    context.read<UserBloc>().add(OnUserValidate(
                        usernameController.text, emailController.text, state));
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
                    context.read<UserBloc>().add(OnUserValidate(
                        usernameController.text, emailController.text, state));
                  },
                  controller: emailController,
                  validator: (value) => state.validateEmail(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  //obscureText: true,

                  controller: passwordController,
                  validator: (value) =>
                      Validators.validatePassword(value ?? ""),
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    icon: Icon(Icons.password),
                  ),
                ),
                TextFormField(
                  //obscureText: true,
                  controller: repeatPasswordController,
                  validator: (value) => Validators.validatePasswordEqual(
                      value ?? "", passwordController.text),
                  decoration: const InputDecoration(
                    labelText: 'Repetir Contraseña',
                    icon: Icon(Icons.password_rounded),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            context
                                .read<UserBloc>()
                                .add(const OnUserListLoad("", "", "", 1));
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<UserBloc>().add(OnUserAdd(
                                  nameController.text,
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text));
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

    if (state is UserEditing) {
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
                    context.read<UserBloc>().add(OnUserValidateEdit(
                        state.user.id, usernameController.text, emailController.text, state));
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
                    context.read<UserBloc>().add(OnUserValidateEdit(
                        state.user.id, usernameController.text, emailController.text, state));
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
                                .read<UserBloc>()
                                .add(OnUserLoad(state.user.id));
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<UserBloc>().add(OnUserEdit(
                                  state.user.id,
                                  nameController.text,
                                  usernameController.text,
                                  emailController.text,
                                  state.user.enabled));
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

    return const SizedBox();
  }

  AppBar _variableAppBar(BuildContext context, UserState state) {
    if (state is UserLoaded || state is UserAdding) {
      return AppBar(
          title: const Text("Usuario"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.read<UserBloc>().add(const OnUserListLoad("", "", "", 1));
            },
          ));
    }
  

    return AppBar(title: const Text("Usuarios"));
  }
}
