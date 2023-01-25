import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:lomba_frontend/core/presentation/bloc/nav_state.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';
import 'package:lomba_frontend/features/sidedrawer/presentation/bloc/sidedrawer_event.dart';

import '../../../../core/presentation/bloc/nav_bloc.dart';
import '../../../../core/presentation/bloc/nav_event.dart';
import '../../../../core/validators.dart';
import '../../../sidedrawer/presentation/bloc/sidedrawer_bloc.dart';
import '../bloc/login_state.dart';

///Página de login con los campos de inicio de sesión
///
///Es necesario darle una revisión de diseño.
///Ya aplica validaciones de correo y password según los validators.
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<NavBloc>().add(const NavigateTo(NavItem.pageHome));
          },
        ),
        title: const Text(
          "Login",
          key: ValueKey("title"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            children: [
              Form(
                key: _key,
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    //envolver y entregar el content predeterminado

                    if (state is LoginGetting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoginGoted) {
                      Future.delayed(Duration.zero, () {
                        context.read<HomeBloc>().add(OnRestartHome());
                        context.read<LoginBloc>().add(OnRestartLogin());
                        context
                            .read<SideDrawerBloc>()
                            .add(const OnSideDrawerLoading());

                        BlocProvider.of<NavBloc>(context)
                            .add(const NavigateTo(NavItem.pageHome));
                      });
                    } else if (state is LoginError) {
                      return Center(
                        child: Text('Something went wrong! ${state.message}'),
                      );
                    } else if (state is LoginEmpty) {
                      return Center(
                        child: SizedBox(
                          height: 400,
                          width: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: _emailController,
                                key: const ValueKey("email_id"),
                                decoration: const InputDecoration(
                                    labelText: ' Usuario',
                                    hintText: " Ingrese usuario o email",
                                    suffixIcon: Icon(Icons.person)),
                                validator: (value) =>
                                    Validators.validateUsername(value ?? ""),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                key: const ValueKey("password"),
                                obscureText: true,
                                obscuringCharacter: '*',
                                decoration: const InputDecoration(
                                  labelText: ' Contraseña',
                                  hintText: " Ingrese contraseña",
                                  suffixIcon: Icon(Icons.key_sharp),
                                ),
                                validator: (value) =>
                                    Validators.validatePassword(value ?? ""),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              ElevatedButton.icon(
                                key: const ValueKey("btn_login"),
                                onPressed: () {
                                  if (_key.currentState?.validate() == true) {
                                    context.read<LoginBloc>().add(OnLoginTriest(
                                        _emailController.text,
                                        _passwordController.text));
                                  }
                                },
                                label: const SizedBox(
                                  width: double.infinity,
                                  height: 35,
                                  child: Center(
                                      child: Text('Login',
                                          style: TextStyle(fontSize: 18))),
                                ),
                                icon: const Icon(Icons.login_outlined),
                              ),
                              const Divider(),
                              SignInButton(
                                Buttons.GoogleDark,
                                text: "Inicia sesión con Google",
                                onPressed: () async {
                                  context
                                      .read<LoginBloc>()
                                      .add(OnLoginWithGoogle());
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
