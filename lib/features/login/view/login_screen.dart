import 'package:infinity_box_task/features/login/bloc/login_bloc.dart';
import 'package:infinity_box_task/features/login/login_repository.dart';
import 'package:infinity_box_task/features/product_list.dart/view/product_list_screen.dart';
import 'package:infinity_box_task/utils/generics.dart';
import 'package:infinity_box_task/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinity_box_task/widgets/input_field.dart';
import 'package:infinity_box_task/widgets/loading_overlay.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';

  LoginScreen({
    Key? key,
  }) : super(key: key);

  String userName = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (_) => LoginBloc(LoginRepository()),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              showSuccessSnackBar('Logged in successfully!');
              Navigator.pushNamed(context, ProductListScreen.id,
                  arguments: {'token': state.token});
            } else if (state is LoginFailure) {
              showErrorSnackBar('Logged Falied! Please try again');
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state is LoginLoading,
              child: Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(15),
                    children: [
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      const SizedBox(height: 30),
                      InputField(
                        title: 'Username',
                        keyboardType: TextInputType.name,
                        validator: (v) {
                          if (isNullOrBlank(v)) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                        onChanged: (v) => userName = v!.trim(),
                      ),
                      const SizedBox(height: 15),
                      InputField(
                        title: 'Password',
                        isSensitive: true,
                        validator: (v) {
                          if (isNullOrBlank(v)) {
                            return 'Please enter a valid password!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (v) => password = v!,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(
                              context,
                              listen: false,
                            ).add(
                              LoginRequested(
                                userName: userName,
                                password: password,
                              ),
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
