import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/theme_constants.dart';
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

    // Tema renklerini doğrudan almak
    final backgroundColor = ThemeConstants.getBackgroundColor(ref);
    final primaryColor = ThemeConstants.getPrimaryColor(ref);
    final textColor = ThemeConstants.getTextColor(ref);
    final surfaceColor = ThemeConstants.getSurfaceColor(ref);

    checkDigitNotifier.updateEmail(email);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Doğrulama Kodu',
          style: TextStyle(color: primaryColor),
        ),
        iconTheme: IconThemeData(color: primaryColor),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'E-posta adresinize gönderilen doğrulama kodunu girin',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _codeController,
                onChanged: checkDigitNotifier.updateCode,
                style: TextStyle(color: textColor),
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  labelText: 'Doğrulama Kodu',
                  labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: primaryColor.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade300),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade400),
                  ),
                  filled: true,
                  fillColor: surfaceColor,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: checkDigitState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Doğrula', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: primaryColor,
                ),
                child: const Text('Geri dön'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
