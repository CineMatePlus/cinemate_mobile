import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/text_styles.dart';
import '../../../../../../core/modules/auth/state.dart';
import '../../../../../../core/modules/auth/screens/register/state.dart';
import '../../../../routes/route_name.dart';

class RegisterScreen extends ConsumerWidget {
  final void Function()? onRegisterSuccess;
  final Widget? logo;
  final ThemeData? theme;
  final String? title;
  final bool showAppBar;

  const RegisterScreen({
    super.key,
    this.onRegisterSuccess,
    this.logo,
    this.theme,
    this.title = '',
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerProvider);
    final registerNotifier = ref.read(registerProvider.notifier);
    final authState = ref.watch(authProvider);

    // Başarılı kayıt durumunu izle
    ref.listen(authProvider, (previous, current) {
      if (previous?.status != AuthStatus.authenticated &&
          current.status == AuthStatus.authenticated) {
        // Başarılı kayıt sonrası authProvider state'i authenticated olacak.
        // go_router redirect bunu algılayıp homePath'e yönlendirecek.
        // Bu yüzden burada ek bir Navigator.pushReplacement veya onRegisterSuccess callback'i çağırmaya gerek yok.
        if (onRegisterSuccess != null) {
          // Geriye uyumluluk için veya özel bir durum varsa çağrılabilir ama genellikle gereksiz.
          debugPrint("Register başarılı, go_router yönlendirecek...");
          // onRegisterSuccess!(); // Bu satır kaldırılabilir
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
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    child: logo ?? _buildLogo(),
                  ),

                  // Form Alanı - Kart olmadan direkt form
                  RegisterForm(
                    state: registerState,
                    notifier: registerNotifier,
                    authState: authState,
                    onLoginTap: () {
                      context.go(loginPath);
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
class RegisterForm extends StatefulWidget {
  final RegisterState state;
  final RegisterNotifier notifier;
  final AuthState authState;
  final VoidCallback? onLoginTap;

  const RegisterForm({
    super.key,
    required this.state,
    required this.notifier,
    required this.authState,
    this.onLoginTap,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.state.name);
    _emailController = TextEditingController(text: widget.state.email);
    _phoneController = TextEditingController(text: widget.state.phone);
    _passwordController = TextEditingController(text: widget.state.password);
    _confirmPasswordController =
        TextEditingController(text: widget.state.confirmPassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          // Ad Soyad Alanı
          _buildTextField(
            controller: _nameController,
            label: 'Ad Soyad',
            icon: Icons.person_outline,
            onChanged: widget.notifier.setName,
            validator: _validateName,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 10),

          // E-posta Alanı
          _buildTextField(
            controller: _emailController,
            label: 'E-posta Adresi',
            icon: Icons.email_outlined,
            onChanged: widget.notifier.setEmail,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),

          // Telefon Alanı - Core olmadığı için kullanıcı girişini kaydedemiyor, tasarım bütünlüğü için bırakıyoruz
          _buildTextField(
            controller: _phoneController,
            label: 'Telefon Numarası ',
            icon: Icons.phone_outlined,
            onChanged: widget.notifier.setPhone,
            keyboardType: TextInputType.phone,
            prefixText: '+90 ',
          ),
          const SizedBox(height: 10),
          // Şifre Alanı
          _buildTextField(
            controller: _passwordController,
            label: 'Şifre',
            icon: Icons.lock_outline,
            onChanged: widget.notifier.setPassword,
            validator: _validatePassword,
            obscureText: true,
          ),
          const SizedBox(height: 10),

          // Şifre Tekrar Alanı
          _buildTextField(
            controller: _confirmPasswordController,
            label: 'Şifre Tekrar',
            icon: Icons.lock_outline,
            onChanged: widget.notifier.setConfirmPassword,
            validator: _validateConfirmPassword,
            obscureText: true,
          ),
          const SizedBox(height: 30),

          // Kullanım Koşulları Checkbox - Core'da bulunmadığı için kullanmıyoruz,
          // ancak tasarım bütünlüğü için bırakıyoruz
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: true, // Her zaman işaretli varsayıyoruz
                  onChanged: (value) {},
                  activeColor: AppColors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.caption.withColor(AppColors.black54),
                    children: [
                      const TextSpan(
                        text: 'Kullanım koşullarını ve gizlilik politikasını ',
                      ),
                      TextSpan(
                        text: 'kabul ediyorum',
                        style: AppTextStyles.caption
                            .withColor(AppColors.black87)
                            .withWeight(FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Kullanım koşulları sayfasına yönlendirme
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

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
                  const Icon(Icons.error_outline,
                      color: Color(0xFFE53935), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage,
                      style: AppTextStyles.error,
                    ),
                  ),
                ],
              ),
            ),
          if (_hasError) const SizedBox(height: 24),

          // Kayıt Ol Butonu
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: isLoading ? null : () => widget.notifier.register(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.greyShade900,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: AppColors.greyShade400,
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
                      'HESAP OLUŞTUR',
                      style: AppTextStyles.buttonLarge.withLetterSpacing(0.5),
                    ),
            ),
          ),
          const SizedBox(height: 20),

          // Giriş Yapma Yönlendirmesi
          Center(
            child: TextButton(
              onPressed: isLoading ? null : widget.onLoginTap,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.black87,
              ),
              child: Text(
                'Zaten bir hesabın var mı? Giriş yap',
                style: AppTextStyles.buttonMedium.withColor(AppColors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController? controller,
    required String label,
    required IconData icon,
    required void Function(String) onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? prefixText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.darkTextGrey),
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE53935)),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: AppTextStyles.inputLabel,
      ),
      style: AppTextStyles.inputText,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ad Soyad alanı boş olamaz';
    }
    return null;
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrar alanı boş olamaz';
    }
    if (value != widget.state.password) {
      return 'Şifreler eşleşmiyor';
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
