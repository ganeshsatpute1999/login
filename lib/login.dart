import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_validator_state.dart';
import 'form_validator_cubit.dart';
import 'password_strength_checker.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider(
          create: (_) => FormValidatorCubit(),
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _forgotPassword(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credentials to login"),
      ],
    );
  }

  _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Username Field
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10),

        BlocBuilder<FormValidatorCubit, FormValidatorState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: passwordController,
                  onChanged: (password) {
                    context.read<FormValidatorCubit>().updatePassword(password);
                    context
                        .read<FormValidatorCubit>()
                        .validatePassword(password);
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: state.error == null
                        ? const Icon(Icons.check, color: Colors.green)
                        : const Icon(Icons.close,
                            color: Colors.red), // Red X for invalid
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                PasswordStrengthChecker(
                  password: passwordController.text,
                  onStrengthChanged: (isStrong) {
                    print('Password strength is strong: $isStrong');
                  },
                ),
                if (state.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {
            if (_validateInputs(context)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login successful")),
              );
            }
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  bool _validateInputs(BuildContext context) {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (!username.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username must contain '@'")),
      );
      return false;
    }

    return true;
  }

  _forgotPassword(BuildContext context) {
    return TextButton(onPressed: () {}, child: Text("Forgot password?"));
  }
}
