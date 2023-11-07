import 'package:flutter/material.dart';
import 'package:movieapp/Login%20Register/viewmodel.dart';
import 'package:provider/provider.dart';
import '../Buttons/button.dart';
import '../TextField/text_field.dart';
import '../const/export.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: formKey,
                child: Column(
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
                      text: AppStrings.email,
                      controller: viewModel.emailController,
                      hinttext: AppStrings.emailhint,
                      isEmail: true,
                    ),
                    TextFields(
                      controller: viewModel.passController,
                      isLoginPassword: true,
                      hinttext: AppStrings.passwordhint,
                      text: AppStrings.password,
                    ),
                    Buttons(
                        btnname: AppStrings.loginbtn,
                        size: 20,
                        onPressed: () async {
                            if (formKey.currentState!.validate()) {
                        await viewModel.loginUser(context);

                      }
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
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
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                        ),
                      ],
                    )
                 
            ],
          ),
        ),
      ),
    );
  }
}
