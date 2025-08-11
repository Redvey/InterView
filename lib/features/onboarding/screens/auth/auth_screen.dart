import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interview/core/constants/strings.dart';
import 'package:interview/core/utils/extensions/responsive_extension.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/auth_login_form.dart';
import 'package:interview/features/onboarding/screens/auth/widgets/auth_signup_form.dart';
import '../../../../core/constants/colors.dart';
import '../../services/auth_service.dart';
import 'mixins/auth_validation_mixins.dart';



class AuthScreen extends StatefulWidget {
  final bool isLogin;

  const AuthScreen({super.key, this.isLogin = true});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with TickerProviderStateMixin, AuthValidationMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleObscureLoginPassword() {
    setState(() => _obscureLoginPassword = !_obscureLoginPassword);
  }

  void _toggleObscureSignupPassword() {
    setState(() => _obscureSignupPassword = !_obscureSignupPassword);
  }

  void _toggleObscureConfirmPassword() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  void _toggleAgreeToTerms(bool? value) {
    setState(() => _agreeToTerms = value ?? false);
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await AuthService.login(
        _loginEmailController.text,
        _loginPasswordController.text,
      );
      if (mounted) {
        _showSnackBar('Welcome back!', AppColors.backgroundGreen);
        context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Login failed: ${e.toString()}', AppColors.red);
        _animationController
          ..reset()
          ..forward();
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignup() async {
    if (!_signupFormKey.currentState!.validate()) return;
    if (!_agreeToTerms) {
      _showSnackBar(
        AppStrings.pleaseAgreeToTerms,
        AppColors.red,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final signupData = {
        'name': _signupNameController.text,
        'email': _signupEmailController.text,
        'password': _signupPasswordController.text,
      };
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        _showSnackBar('Account created successfully!', AppColors.backgroundGreen);
        context.push('/profile-setup', extra: signupData);
      }
    } catch (e) {
      if (mounted) _showSnackBar('Sign up failed: ${e.toString()}', AppColors.red);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.radiusLG)),
        margin: EdgeInsets.all(context.md),
      ),
    );
  }

  String? _validateLoginPassword(String? value) {
    return validatePassword(value);
  }

  String? _validateSignupPassword(String? value) {
    return validatePassword(value, isSignup: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.isLogin ? 0 : 1,
            length: 2,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  SizedBox(height: context.spaceBtwSections),
                  Container(
                    width: context.imageThumbSize,
                    height: context.imageThumbSize,
                    decoration: BoxDecoration(
                      color: AppColors.blackLight,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: context.iconSize),
                  ),
                  SizedBox(height: context.spaceBtwItems),
                  Text(
                    'Interview',
                    style: context.welcomeStyle,
                  ),
                  SizedBox(height: context.spaceBtwSections),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: context.md),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(context.radiusLG),
                    ),
                    child: TabBar(
                      labelStyle: context.buttonSmallStyle,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.radiusLG),
                        color: AppColors.blackLight,
                      ),
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.textGrey,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      tabs: const [
                        Tab(text: AppStrings.signIn,),
                        Tab(text: AppStrings.signUp),
                      ],
                    ),
                  ),
                  SizedBox(height: context.spaceBtwItems),
                  Expanded(
                    child: TabBarView(
                      children: [
                        AuthLoginForm(
                          formKey: _loginFormKey,
                          emailController: _loginEmailController,
                          passwordController: _loginPasswordController,
                          obscurePassword: _obscureLoginPassword,
                          onToggleObscure: _toggleObscureLoginPassword,
                          onLogin: _handleLogin,
                          isLoading: _isLoading,
                          validateEmail: validateEmail,
                          validatePassword: _validateLoginPassword,
                        ),
                        AuthSignupForm(
                          formKey: _signupFormKey,
                          nameController: _signupNameController,
                          emailController: _signupEmailController,
                          passwordController: _signupPasswordController,
                          confirmPasswordController: _confirmPasswordController,
                          obscurePassword: _obscureSignupPassword,
                          obscureConfirmPassword: _obscureConfirmPassword,
                          agreeToTerms: _agreeToTerms,
                          onToggleObscurePassword: _toggleObscureSignupPassword,
                          onToggleObscureConfirmPassword: _toggleObscureConfirmPassword,
                          onToggleAgreeToTerms: _toggleAgreeToTerms,
                          onSignup: _handleSignup,
                          isLoading: _isLoading,
                          validateEmail: validateEmail,
                          validatePassword: _validateSignupPassword,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}