import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../../../../../core/modules/auth/screens/login/state.dart';
import '../../../../../../core/modules/auth/state.dart';
import '../../../../routes/route_name.dart';

class LoginScreen extends ConsumerWidget {
  final void Function()? onLoginSuccess;
  final Widget? logo;
  final ThemeData? theme;
  final String? title;
  final bool showAppBar;

  const LoginScreen({
    super.key,
    this.onLoginSuccess,
    this.logo,
    this.theme,
    this.title = '',
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    final authState = ref.watch(authProvider);

    // Başarılı giriş durumunu izle
    ref.listen(authProvider, (previous, current) {
      if (previous?.status != AuthStatus.authenticated &&
          current.status == AuthStatus.authenticated) {
        // Başarılı giriş
        if (onLoginSuccess != null) {
          // Login başarılı olduğunda callback fonksiyonunu çağır
          debugPrint("Login başarılı, home sayfasına yönlendiriliyor...");
          onLoginSuccess!();
        }
      }
    });

    final effectiveTheme = theme ?? Theme.of(context);

    return Theme(
      data: effectiveTheme,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: showAppBar
            ? AppBar(
                title: Text(
                  title!,
                  style: AppTextStyles.heading4.withColor(AppColors.black87),
                ),
                backgroundColor: AppColors.white,
                centerTitle: true,
                elevation: 0,
                iconTheme: const IconThemeData(color: AppColors.black87),
              )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Alanı
                  Container(
                    margin: const EdgeInsets.only(top: 35, bottom: 35),
                    child: logo ?? _buildLogo(),
                  ),

                  const SizedBox(height: 30),

                  // Form Alanı
                  LoginForm(
                    state: loginState,
                    notifier: loginNotifier,
                    authState: authState,
                    onRegisterTap: () {
                      context.push(registerPath);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        _buildLogoIcon(),
        const SizedBox(height: 10),
        Text(
          'CineMate',
          style: AppTextStyles.logo.withColor(AppColors.black87),
        ),
      ],
    );
  }

  Widget _buildLogoIcon() {
    return const Icon(
      Icons.movie_filter_outlined,
      size: 70,
      color: AppColors.primary,
    );
  }
}

// Form Widget'ı
class LoginForm extends StatefulWidget {
  final LoginState state;
  final LoginNotifier notifier;
  final AuthState authState;
  final VoidCallback? onRegisterTap;

  const LoginForm({
    super.key,
    required this.state,
    required this.notifier,
    required this.authState,
    this.onRegisterTap,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        widget.state.isLoading || widget.authState.status == AuthStatus.loading;

    return Form(
      key: widget.state.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // E-posta Alanı
          TextFormField(
            controller: _emailController,
            onChanged: widget.notifier.setEmail,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(labelText: 'E-posta Adresi'),
            style: AppTextStyles.inputText,
          ),
          const SizedBox(height: 20),

          // Şifre Alanı
          TextFormField(
            controller: _passwordController,
            onChanged: widget.notifier.setPassword,
            validator: _validatePassword,
            obscureText: true,
            decoration: _inputDecoration(labelText: 'Şifre'),
            style: AppTextStyles.inputText,
          ),
          const SizedBox(height: 50),

          // Hata Mesajı
          if (_hasError)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6F6),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFE0E0)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Color(0xFFE53935),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(_errorMessage, style: AppTextStyles.error),
                  ),
                ],
              ),
            ),
          if (_hasError) const SizedBox(height: 24),

          // Giriş Yap Butonu
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => widget.notifier.login(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey[400],
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'GİRİŞ YAP',
                      style: AppTextStyles.buttonLarge
                          .withWeight(FontWeight.bold)
                          .withLetterSpacing(0.5),
                    ),
            ),
          ),
          const SizedBox(height: 20),

          // Kayıt Butonu
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : widget.onRegisterTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 226, 226),
                foregroundColor: AppColors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                disabledBackgroundColor: Colors.grey[400],
              ),
              child: Text(
                'KAYIT OL',
                style: AppTextStyles.buttonLarge
                    .withColor(AppColors.black87)
                    .withWeight(FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: AppTextStyles.bodyMedium.withColor(AppColors.textGrey),
      floatingLabelStyle: AppTextStyles.bodySmall.withColor(AppColors.textGrey),
      filled: true,
      fillColor: const Color.fromARGB(255, 245, 245, 245),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.red, width: 1.5),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta alanı boş olamaz';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Geçerli bir e-posta adresi giriniz';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı boş olamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }

  bool get _hasError =>
      widget.state.errorMessage != null ||
      (widget.authState.status == AuthStatus.error &&
          widget.authState.errorMessage != null);

  String get _errorMessage =>
      widget.state.errorMessage ?? widget.authState.errorMessage!;
}
