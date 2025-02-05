import 'package:flutter/material.dart';
import 'package:mis_gastos/pages/widgets/background_painter.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/repository/user_repository.dart';
import 'package:mis_gastos/routes/app_routes.dart';
import 'package:mis_gastos/variables/global_variables.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: size.width * .6,
                ),
              ),
              SizedBox(
                height: size.height * .65,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * .15,
                      vertical: size.height * .02,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || value.isEmpty) {
                              return 'Ingrese su email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: Colors.deepPurpleAccent,
                                ),
                                Text(
                                  'Correo Electronico',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .04,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _isObscure,
                          validator: (value) {
                            if (value!.isEmpty || value.isEmpty) {
                              return 'Ingrese su contraseña';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            label: Row(
                              children: [
                                Icon(
                                  Icons.lock_person,
                                  color: Colors.deepPurpleAccent,
                                ),
                                Text(
                                  'Contraseña',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.deepPurple,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .08,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.deepPurple),
                          ),
                          onPressed: _submitForm,
                          child: Text('Iniciar Sesión'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.registerUser);
                          },
                          child: Text('Registrarse'),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Olvidé mi contraseña',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final isUserFound =
          await UserRepository().findUserByEmail(email, password);
      if (isUserFound != null) {
        userLogged = isUserFound;
        _userFound();
      } else {
        _userNull();
      }
    }
  }

  void _userFound() {
    Navigator.pushNamed(context, AppRoutes.home);
  }

  void _userNull() {
    GlobalWidgets().showSanckBar(context, 'Error al Iniciar Sesión');
  }
}
