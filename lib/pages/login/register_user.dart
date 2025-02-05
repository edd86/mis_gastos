import 'package:flutter/material.dart';
import 'package:mis_gastos/model/user.dart';
import 'package:mis_gastos/pages/widgets/global_widgets.dart';
import 'package:mis_gastos/repository/user_repository.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Usuario'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * .05,
          horizontal: size.width * .15,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(width: 5),
                        const Text('Nombre'),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.isEmpty) {
                      return 'Ingrese nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(width: 5),
                        const Text('Correo electrónico'),
                      ],
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.isEmpty) {
                      return 'Ingrese su email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    label: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(width: 5),
                        const Text('Contraseña'),
                      ],
                    ),
                    suffixIcon: IconButton(
                      icon: _isObscure
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () => setState(() {
                        _isObscure = !_isObscure;
                      }),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.isEmpty) {
                      return 'Ingrese su contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      final userRepo = UserRepository();
      final userAdded = await userRepo.addUser(user);
      if (userAdded?.id != null) {
        _userAdded();
      } else {
        _userNotAdded();
      }
    }
  }

  void _userAdded() {
    GlobalWidgets().showSanckBar(context, 'Usuario Registrado');
    Navigator.pop(context);
  }

  void _userNotAdded() {
    GlobalWidgets().showSanckBar(context, 'Error al Registrar');
  }
}
