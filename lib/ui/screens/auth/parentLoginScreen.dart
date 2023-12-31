import 'package:exschool/app/routes.dart';
import 'package:exschool/cubits/authCubit.dart';
import 'package:exschool/cubits/forgotPasswordRequestCubit.dart';
import 'package:exschool/cubits/signInCubit.dart';
import 'package:exschool/data/repositories/authRepository.dart';
import 'package:exschool/ui/screens/auth/widgets/forgotPasswordRequestBottomsheet.dart';
import 'package:exschool/ui/screens/auth/widgets/termsAndConditionAndPrivacyPolicyContainer.dart';
import 'package:exschool/ui/widgets/customCircularProgressIndicator.dart';
import 'package:exschool/ui/widgets/customRoundedButton.dart';
import 'package:exschool/ui/widgets/customTextFieldContainer.dart';
import 'package:exschool/ui/widgets/passwordHideShowButton.dart';
import 'package:exschool/utils/labelKeys.dart';
import 'package:exschool/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParentLoginScreen extends StatefulWidget {
  ParentLoginScreen({Key? key}) : super(key: key);

  @override
  State<ParentLoginScreen> createState() => _ParentLoginScreenState();

  static Route route(RouteSettings routeSettings) {
    return CupertinoPageRoute(
        builder: (_) => BlocProvider<SignInCubit>(
            child: ParentLoginScreen(),
            create: (_) => SignInCubit(AuthRepository())));
  }
}

class _ParentLoginScreenState extends State<ParentLoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

  late Animation<double> _patterntAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.0, 0.5, curve: Curves.easeInOut)));

  late Animation<double> _formAnimation = Tween<double>(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));

  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  void _signInParent() {
    if (_emailTextEditingController.text.trim().isEmpty) {
      UiUtils.showCustomSnackBar(
          context: context,
          errorMessage:
              UiUtils.getTranslatedLabel(context, pleaseEnterEmailKey),
          backgroundColor: Theme.of(context).colorScheme.error);
      return;
    }

    if (_passwordTextEditingController.text.trim().isEmpty) {
      UiUtils.showCustomSnackBar(
          context: context,
          errorMessage:
              UiUtils.getTranslatedLabel(context, pleaseEnterPasswordKey),
          backgroundColor: Theme.of(context).colorScheme.error);
      return;
    }

    context.read<SignInCubit>().signInUser(
        userId: _emailTextEditingController.text.trim(),
        password: _passwordTextEditingController.text.trim(),
        isStudentLogin: false);
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: GestureDetector(
          onTap: () {
            if (UiUtils.isDemoVersionEnable()) {
              UiUtils.showFeatureDisableInDemoVersion(context);
              return;
            }
            UiUtils.showBottomSheet(
              child: BlocProvider(
                create: (_) => ForgotPasswordRequestCubit(AuthRepository()),
                child: ForgotPasswordRequestBottomsheet(),
              ),
              context: context,
            ).then((value) {
              if (value != null && !value['error']) {
                UiUtils.showCustomSnackBar(
                    context: context,
                    errorMessage: UiUtils.getTranslatedLabel(
                            context, passwordUpdateLinkSentKey) +
                        " ${value['email']}",
                    backgroundColor: Theme.of(context).colorScheme.onPrimary);
              }
            });
          },
          child: Text(
            "${UiUtils.getTranslatedLabel(context, forgotPasswordKey)}?",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildUpperPattern() {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
            position: _patterntAnimation.drive(
                Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset.zero)),
            child: Image.asset(UiUtils.getImagePath("upper_pattern.png"))),
      ),
    );
  }

  Widget _buildLowerPattern() {
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
            position: _patterntAnimation.drive(
                Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero)),
            child: Image.asset(UiUtils.getImagePath("lower_pattern.png"))),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: FadeTransition(
        opacity: _formAnimation,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * (0.075),
                  right: MediaQuery.of(context).size.width * (0.075),
                  top: MediaQuery.of(context).size.height * (0.25)),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      UiUtils.getTranslatedLabel(context, letsSignInKey),
                      style: TextStyle(
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                          color: UiUtils.getColorScheme(context).secondary),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${UiUtils.getTranslatedLabel(context, welcomeBackKey)}, \n${UiUtils.getTranslatedLabel(context, youHaveBeenMissedKey)}",
                      style: TextStyle(
                          fontSize: 24.0,
                          height: 1.5,
                          color: UiUtils.getColorScheme(context).secondary),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFieldContainer(
                      hideText: false,
                      hintTextKey: emailKey,
                      bottomPadding: 0,
                      textEditingController: _emailTextEditingController,
                      suffixWidget: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          UiUtils.getImagePath("mail_icon.svg"),
                          color: UiUtils.getColorScheme(context).secondary,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    CustomTextFieldContainer(
                      hideText: _hidePassword,
                      hintTextKey: passwordKey,
                      bottomPadding: 0,
                      textEditingController: _passwordTextEditingController,
                      suffixWidget: PasswordHideShowButton(
                          hidePassword: _hidePassword,
                          onTap: () {
                            _hidePassword = !_hidePassword;
                            setState(() {});
                          }),
                    ),
                    _buildForgotPassword(),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: BlocConsumer<SignInCubit, SignInState>(
                        listener: (context, state) {
                          if (state is SignInSuccess) {
                            //
                            context.read<AuthCubit>().authenticateUser(
                                jwtToken: state.jwtToken,
                                isStudent: state.isStudentLogIn,
                                parent: state.parent,
                                student: state.student);

                            Navigator.of(context)
                                .pushReplacementNamed(Routes.parentHome);
                          } else if (state is SignInFailure) {
                            UiUtils.showCustomSnackBar(
                                context: context,
                                errorMessage:
                                    UiUtils.getErrorMessageFromErrorCode(
                                        context, state.errorMessage),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error);
                          }
                        },
                        builder: (context, state) {
                          return CustomRoundedButton(
                            onTap: () {
                              if (state is SignInInProgress) {
                                return;
                              }

                              FocusScope.of(context).unfocus();

                              _signInParent();
                            },
                            widthPercentage: 0.8,
                            backgroundColor:
                                UiUtils.getColorScheme(context).primary,
                            child: state is SignInInProgress
                                ? CustomCircularProgressIndicator(
                                    strokeWidth: 2,
                                    widthAndHeight: 20,
                                  )
                                : null,
                            buttonTitle:
                                UiUtils.getTranslatedLabel(context, signInKey),
                            titleColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            showBorder: false,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    BlocBuilder<SignInCubit, SignInState>(
                      builder: (context, state) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              if (state is SignInInProgress) {
                                return;
                              }

                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.studentLogin);
                            },
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: UiUtils.getColorScheme(context)
                                          .primary,
                                    ),
                                    text: UiUtils.getTranslatedLabel(
                                        context, loginAsKey)),
                                TextSpan(text: " "),
                                TextSpan(
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: UiUtils.getColorScheme(context)
                                          .secondary,
                                    ),
                                    text:
                                        "${UiUtils.getTranslatedLabel(context, studentKey)}?"),
                              ]),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TermsAndConditionAndPrivacyPolicyContainer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.025),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildUpperPattern(),
          _buildLowerPattern(),
          _buildLoginForm(),
        ],
      ),
    );
  }
}
