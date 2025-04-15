import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

class CheckDigitView extends ConsumerStatefulWidget {
  const CheckDigitView({super.key});

  @override
  ConsumerState<CheckDigitView> createState() => _CheckDigitViewState();
}

class _CheckDigitViewState extends ConsumerState<CheckDigitView> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;
    final checkDigitState = ref.watch(checkDigitProvider);
    final checkDigitNotifier = ref.read(checkDigitProvider.notifier);

    checkDigitNotifier.updateEmail(email);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doğrulama Kodu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'E-posta adresinize gönderilen doğrulama kodunu girin',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _codeController,
                onChanged: checkDigitNotifier.updateCode,
                decoration: const InputDecoration(
                  labelText: 'Doğrulama Kodu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Doğrulama kodu boş olamaz';
                  }
                  if (value.length != 6) {
                    return 'Doğrulama kodu 6 haneli olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (checkDigitState.errorMessage != null)
                Text(
                  checkDigitState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: checkDigitState.isLoading
                    ? null
                    : () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await checkDigitNotifier.verifyCode();
                            if (context.mounted) {
                              Navigator.of(context).pushNamed(
                                '/new-password',
                                arguments: {
                                  'email': email,
                                  'code': checkDigitState.code,
                                },
                              );
                            }
                          } catch (e) {
                            // Hata zaten state'de tutuluyor
                          }
                        }
                      },
                child: checkDigitState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Doğrula'),
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
