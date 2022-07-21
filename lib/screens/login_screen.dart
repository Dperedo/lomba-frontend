import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:front_lomba/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:front_lomba/helpers/route_animation.dart';
import 'package:front_lomba/providers/login_form_provider.dart';
import 'package:front_lomba/services/auth_service.dart';
import 'package:get/get.dart';

import '../helpers/snackbars.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
      builder: (context, orientation) => orientation == Orientation.portrait
          ? buildPortrait()
          : buildLandscape(),
    ));
  }
}

Widget buildPortrait() => AuthBackground(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 250),

          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Login',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize:
                          45)), //Theme.of(context).textTheme.headline4,  ),
              SizedBox(height: 30),

              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          )),

          SizedBox(height: 50),
          //Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          SizedBox(height: 50),
        ],
      ),
    ));

Widget buildLandscape() => AuthBackground(
        child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 250),

          CardContainerLandscape(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Login',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize:
                          45)), //Theme.of(context).textTheme.headline4,  ),
              SizedBox(height: 30),

              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LoginForm())
            ],
          )),

          SizedBox(height: 50),
          //Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
          SizedBox(height: 50),
        ],
      ),
    ));

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              key: const Key("input_login"),
              style: TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              initialValue: 'superadmin',
              decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                loginForm.email = value!;
                /*String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = new RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
                  */
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              key: const Key("input_password"),
              style: TextStyle(color: Colors.black),
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              initialValue: 'superadmin',
              decoration: InputDecorations.authInputDecoration(
                  hintText: '',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                loginForm.password = value!;
                return (value != null && value.length >= 4)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 30),
            MaterialButton(
                key: const Key("button_enter"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: const Color.fromARGB(255, 94, 97, 255),
                // ignore: sort_child_properties_last
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: const TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;

                        //await Future.delayed(Duration(seconds: 2 ));

                        // TODO: validar si el login es correcto
                        final String? errorMessage = await authService.login(
                            loginForm.email, loginForm.password);

                        //print(errorMessage);
                        if (errorMessage == null) {
                          Navigator.of(context)
                              .push(RouteAnimation.animatedTransition(Home()));
                        } else {
                          // TODO: mostrar error en pantalla
                          // print( errorMessage );
                          //NotificationsService.showSnackbar(errorMessage);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBarGenerator.getNotificationMessage(
                                  errorMessage));
                          loginForm.isLoading = false;
                        }
                      })
          ],
        ),
      ),
    );
  }
}

//----------------------------------------------------------------------------

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 90, left: 30),
          Positioned(child: _Bubble(), top: -40, left: -30),
          Positioned(child: _Bubble(), top: -50, right: -20),
          Positioned(child: _Bubble(), bottom: -50, left: 10),
          Positioned(child: _Bubble(), bottom: 120, right: 20),
        ],
      ),
    );
  }

  // ignore: prefer_const_constructors
  BoxDecoration _purpleBackground() => BoxDecoration(
          // ignore: prefer_const_constructors
          gradient: LinearGradient(colors: const [
        Color.fromARGB(255, 5, 5, 170),
        Color.fromARGB(255, 53, 98, 243)
      ]));
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}

//--------------------------------------------------------------------------

class CardContainer extends StatelessWidget {
  final Widget child;

  const CardContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}

class CardContainerLandscape extends StatelessWidget {
  final Widget child;

  const CardContainerLandscape({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Container(
          width: 400, //double.infinity,
          padding: EdgeInsets.all(20),
          decoration: _createCardShape(),
          child: this.child,
        ),
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}

//-----------------------------------------------------------------

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
  }
}

//----------------------------------------------------------------------------

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.blue) : null);
  }
}

//----------------------------------------------------------------------------
/*return AuthBackground(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 250),

                    CardContainer(
                        child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text('Login',
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize:
                                    45)), //Theme.of(context).textTheme.headline4,  ),
                        SizedBox(height: 30),

                        ChangeNotifierProvider(
                            create: (_) => LoginFormProvider(), child: _LoginForm())
                      ],
                    )),

                    SizedBox(height: 50),
                    //Text('Crear una nueva cuenta', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
                    SizedBox(height: 50),
                  ],
                ),
            ));*/
