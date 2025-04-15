import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    final forgotPasswordNotifier = ref.read(forgotPasswordProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifremi Unuttum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Şifrenizi sıfırlamak için e-posta adresinizi girin',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                onChanged: forgotPasswordNotifier.updateEmail,
                decoration: const InputDecoration(
                  labelText: 'E-posta',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'E-posta adresi boş olamaz';
                  }
                  if (!value.contains('@')) {
                    return 'Geçerli bir e-posta adresi girin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (forgotPasswordState.errorMessage != null)
                Text(
                  forgotPasswordState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: forgotPasswordState.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await forgotPasswordNotifier.sendResetEmail();
                            if (context.mounted) {
                              Navigator.of(context).pushNamed(
                                '/check-digit',
                                arguments: forgotPasswordState.email,
                              );
                            }
                          } catch (e) {
                            // Hata zaten state'de tutuluyor
                          }
                        }
                      },
                child: forgotPasswordState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Kodu Gönder'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Giriş ekranına dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
