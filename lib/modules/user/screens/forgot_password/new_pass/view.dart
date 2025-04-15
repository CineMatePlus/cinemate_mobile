import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

class NewPasswordView extends ConsumerStatefulWidget {
  const NewPasswordView({super.key});

  @override
  ConsumerState<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends ConsumerState<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final email = args['email']!;
    final code = args['code']!;
    final newPasswordState = ref.watch(newPasswordProvider);
    final newPasswordNotifier = ref.read(newPasswordProvider.notifier);

    newPasswordNotifier.updateEmail(email);
    newPasswordNotifier.updateCode(code);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Şifre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Yeni şifrenizi belirleyin',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                onChanged: newPasswordNotifier.updatePassword,
                obscureText: newPasswordState.isObscure,
                decoration: InputDecoration(
                  labelText: 'Yeni Şifre',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      newPasswordState.isObscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: newPasswordNotifier.toggleObscure,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş olamaz';
                  }
                  if (value.length < 6) {
                    return 'Şifre en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                onChanged: newPasswordNotifier.updateConfirmPassword,
                obscureText: newPasswordState.isObscure,
                decoration: const InputDecoration(
                  labelText: 'Şifre Tekrar',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre tekrarı boş olamaz';
                  }
                  if (value != _passwordController.text) {
                    return 'Şifreler eşleşmiyor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (newPasswordState.errorMessage != null)
                Text(
                  newPasswordState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: newPasswordState.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await newPasswordNotifier.resetPassword();
                            if (context.mounted) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            }
                          } catch (e) {
                            // Hata zaten state'de tutuluyor
                          }
                        }
                      },
                child: newPasswordState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Şifreyi Güncelle'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Geri dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
