import 'package:mummy_guide/providers/timeline_provider.dart';
import 'package:mummy_guide/utils/globals.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mummy_guide/controllers/auth_controller.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/providers/login_provider.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Mummy Guide',
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.agbalumo(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          const Color(0xFFED2E7C),
                          const Color(0xFFFF8EA2),
                          const Color(0xFFED2E7C),
                        ],
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label for the email input
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppLocale.enter_your_email_label.getString(context),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // TextField for email input
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: AppLocale.email_label.getString(context),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label for the password input
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppLocale.enter_your_password_label
                              .getString(context),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // TextField for password input
                      TextField(
                        controller: passController,
                        obscureText: true, // Hides the text input for password
                        decoration: InputDecoration(
                          hintText: AppLocale.password_label.getString(context),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed("/forget_password");
                        },
                        child: const Text("Forget the password ?")
                        
                          
                        
                      ),
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
