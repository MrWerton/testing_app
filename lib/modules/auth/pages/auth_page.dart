import 'package:flutter/material.dart';
import 'package:testing_app/modules/auth/controllers/AuthController.dart';
import 'package:testing_app/modules/auth/dtos/login_credentials.dart';

class AuthPage extends StatefulWidget {
  final AuthController authController;
  const AuthPage({super.key, required this.authController});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
 late final TextEditingController emailController;
 late final TextEditingController passwordController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginSubmit()async{
    if(formKey.currentState!.validate()){
      final credentials = LoginCredentials.create(email: emailController.text, password: passwordController.text);
     await widget.authController.login(loginCredentials: credentials);
    }
  }
  @override
  Widget build(BuildContext context) {
    final controller = widget.authController;
    return Scaffold(
      body: Form(
        key: formKey ,
        child: Column(children: [
          TextFormField(
            controller: emailController,
          ),
          TextFormField(
            controller: passwordController,
          ),
         ValueListenableBuilder(valueListenable: controller.isLoading, builder: (context, value, child) {
           return ( ElevatedButton(onPressed: loginSubmit, child:value?
           CircularProgressIndicator():  Text("login")));
         },)
        ],),
      ),
    );
  }
}
