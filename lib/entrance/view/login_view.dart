import 'package:cats/entrance/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginView')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return TextField(
                  onChanged: (value) => viewModel.setEmail(value),
                  decoration: const InputDecoration(labelText: 'Email'),
                );
              },
            ),
            Consumer<LoginViewModel>(
              builder: (context, viewModel, _) {
                return TextField(
                  onChanged: (value) => viewModel.setPassword(value),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                // ViewModel의 login 메서드를 호출하여 로그인을 수행합니다.
                Provider.of<LoginViewModel>(context, listen: false)
                    .login(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
