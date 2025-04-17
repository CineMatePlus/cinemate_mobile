import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/theme_constants.dart';
import 'state.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../auth/screens/login/view.dart';

class NewPasswordView extends ConsumerStatefulWidget {
  final String email;
  final String code;

  const NewPasswordView({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  ConsumerState<NewPasswordView> createState() => _NewPasswordViewState();
}

class _NewPasswordViewState extends ConsumerState<NewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newPasswordProvider.notifier).updateEmail(widget.email);
      ref.read(newPasswordProvider.notifier).updateCode(widget.code);
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newPasswordProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Şifre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Lütfen yeni şifrenizi girin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Şifre',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: ThemeConstants.primaryColor,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi girin';
                  }
                  if (value.length < 6) {
                    return 'Şifreniz en az 6 karakter olmalıdır';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                labelText: 'Şifreyi Onayla',
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: ThemeConstants.primaryColor,
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen şifrenizi tekrar girin';
                  }
                  if (value != _passwordController.text) {
                    return 'Şifreler eşleşmiyor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: ThemeConstants.errorColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              AppButton(
                text: 'Şifreyi Sıfırla',
                isLoading: state.isLoading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ref
                        .read(newPasswordProvider.notifier)
                        .updatePassword(_passwordController.text);

                    try {
                      await ref
                          .read(newPasswordProvider.notifier)
                          .resetPassword();
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Şifreniz başarıyla güncellendi'),
                          backgroundColor: ThemeConstants.successColor,
                        ),
                      );

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                        (route) => false,
                      );
                    } catch (e) {
                      // Hata state içinde işleniyor
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
