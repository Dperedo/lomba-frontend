import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_bloc.dart';
import 'package:lomba_frontend/features/login/presentation/bloc/login_event.dart';

import '../../../../core/validators.dart';
import '../bloc/login_state.dart';
import 'home_page.dart';

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
                if (state is LoginGetting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoginGot) {
                  Future.delayed(Duration.zero, () {
                    Navigator.of(context).push<void>(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  });
                  //   Navigator.push(
                  //     context,
                  //   MaterialPageRoute(
                  //   builder: (context) => const HomePage(),
                  //  ));
                } else if (state is LoginError) {
                  return const Center(
                    child: Text('Something went wrong!'),
                  );
                }
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
              },
            ),
          ]),
        ),
      ),
    );
  }
}
