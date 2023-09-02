import 'package:flutter/material.dart';
import 'package:movieapp/Login%20Register/viewmodel.dart';
import 'package:provider/provider.dart';
import '../Buttons/button.dart';
import '../Home Page/home.dart';
import '../TextField/text_field.dart';
import '../const/export.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.login),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.15,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    TextFields(
                      controller: viewModel.emailController,
                      hinttext: AppStrings.email,
                      isEmail: true,
                    ),
                    TextFields(
                      controller: viewModel.passController,
                      isPassword: true,
                      hinttext: AppStrings.password,
                    ),
                    Buttons(
                        btnname: AppStrings.loginbtn,
                        size: 20,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final loginSuccess = await viewModel.performLogin();
                            if (loginSuccess) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          }
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      AppStrings.noAccount,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      child: Text(
                        AppStrings.registerNow,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue[200],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
