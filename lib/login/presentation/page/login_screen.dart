import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.emailError != current.emailError,
              builder: (context, state) {
                return TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: state.emailError.isNotEmpty ? state.emailError : null,
                  ),
                  onChanged: (value) {
                    context.read<LoginBloc>().add(EmailChanged(value));
                  },
                );
              },
            ),
            BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.pwdError!=current.pwdError,
              builder: (context, state) {
                return TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: state.pwdError.isNotEmpty ? state.pwdError : null,
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(PasswordChanged(value));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Login Successful'),
                      backgroundColor: Colors.green,
                    ));
                  } else if (state.isFailure && !state.isSubmitting) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Login Failed'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
              buildWhen: (previous, current) => previous.isSubmitting != current.isSubmitting ,
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: state.isSubmitting ? null : () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  },
                  child: state.isSubmitting
                      ? CircularProgressIndicator()
                      : Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
