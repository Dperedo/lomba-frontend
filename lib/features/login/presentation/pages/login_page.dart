import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/core/presentation/bloc/nav_state.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_bloc.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_event.dart';
import 'package:lomba_frontend/features/home/presentation/bloc/home_state.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';

import '../../../../core/presentation/bloc/nav_bloc.dart';
import '../../../../core/presentation/bloc/nav_event.dart';
import '../../../../core/validators.dart';
import '../bloc/login_state.dart';
import '../../../home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          key: ValueKey("title"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(children: [
            BlocBuilder<LoginBloc, LoginState>(
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
                    BlocProvider.of<NavBloc>(context)
                        .add(const NavigateTo(NavItem.page_home));
                    //Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePage()));

                    //  Navigator.of(context).pop(MaterialPageRoute(
                    //      builder: (context) => const HomePage()));
                  });
                } else if (state is LoginError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                } else if (state is LoginEmpty) {
                  return Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        key: const ValueKey("email_id"),
                        decoration:
                            const InputDecoration(hintText: "Enter Email Id"),
                        validator: (value) =>
                            Validators.validateEmail(value ?? ""),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        key: const ValueKey("password"),
                        decoration:
                            const InputDecoration(hintText: "Enter Password"),
                        validator: (value) =>
                            Validators.validatePassword(value ?? ""),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          key: const ValueKey("btn_login"),
                          onPressed: () {
                            if (_key.currentState?.validate() == true) {
                              context.read<LoginBloc>().add(OnLoginTriest(
                                  _emailController.text,
                                  _passwordController.text));
                            }
                          },
                          child: const Text("Login"))
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
