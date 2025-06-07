import 'package:mummy_guide/providers/timeline_provider.dart';
import 'package:mummy_guide/utils/globals.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mummy_guide/controllers/auth_controller.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/providers/login_provider.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:mummy_guide/widgets/form_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(
      context,
    );

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.white,
        body: loginProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 150,
                    child: Image.asset(
                      AssetsUtils.logo,
                      // width: (MediaQuery.sizeOf(context).width - 60) * 0.5,
                    ),
                  ),
                  TitleWidget(text: "MummyGuide"),
                  const SizedBox(
                    height: 40,
                  ),
                  FormWidget(
                    controller: emailController,
                    text: AppLocale.enter_your_email_label.getString(context),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormWidget(
                    // TextField for password input

                    controller: passController,
                    obsecure: true, // Hides the text input for password

                    text: AppLocale.enter_your_password_label.getString(context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/forget_password");
                          },
                          child: const Text("Forget the password ?")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 40) * 0.5,
                        height:
                            (MediaQuery.sizeOf(context).height - 40) * 0.065,
                        child: FilledButton(
                          onPressed: () async {
                            if (emailController.text == "") {
                              Fluttertoast.showToast(
                                msg: "Please enter your email!!",
                              );
                              return;
                            }

                            if (passController.text == "") {
                              Fluttertoast.showToast(
                                msg: "Please enter your password!!",
                              );
                              return;
                            }

                            loginProvider.toggleLoading();

                            try {
                              var res = await AuthController.login(
                                emailController.text,
                                passController.text,
                              );

                              if (res["result"] == true) {
                                final timelineProvider =
                                    Provider.of<TimelineProvider>(
                                  context,
                                  listen: false,
                                );

                                timelineProvider.getData();

                                Navigator.of(context).pushNamed("/home");
                              } else {
                                Fluttertoast.showToast(
                                  msg: res["message"].toString(),
                                );
                              }
                            } catch (e) {
                              print(e.toString());
                            }

                            loginProvider.toggleLoading();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Globals.btncolor,
                            ),
                          ),
                          child: Text(
                            AppLocale.login_label.getString(
                              context,
                            ),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/create_account");
                        },
                        child: Text(
                          AppLocale.create_account_label.getString(
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
