import 'package:mummy_guide/utils/globals.dart';
// import 'package:mummy_guide/utils/size_conf.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mummy_guide/controllers/auth_controller.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:mummy_guide/providers/create_account_provider.dart';
import 'package:mummy_guide/utils/assets_utils.dart';
import 'package:mummy_guide/widgets/form_widget.dart';
import 'package:mummy_guide/widgets/title_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';

class CreateAccountScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final createAccountProvider = Provider.of<CreateAccountProvider>(
      context,
    );

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.white,
        body: createAccountProvider.isLoading
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
                    height: 50,
                  ),
                  SizedBox(
                    height: 130,
                    child: Image.asset(
                      AssetsUtils.logo,
                      // width: (MediaQuery.sizeOf(context).width - 60) * 0.5,
                    ),
                  ),
                  TitleWidget(text: "MummyGuide"),
                  const SizedBox(
                    height: 30,
                  ),
                  FormWidget(
                    controller: emailController,
                    text: AppLocale.enter_your_email_label.getString(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormWidget(
                    controller: fullNameController,
                    text:
                        AppLocale.enter_your_fullname_label.getString(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormWidget(
                    controller: phoneController,
                    keyboard: TextInputType
                        .phone, // Set keyboard type for phone input

                    text: AppLocale.enter_your_phone_label.getString(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormWidget(
                    controller: passController,
                    obsecure: true, // Hides the text input for password

                    text:
                        AppLocale.enter_your_password_label.getString(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  FormWidget(
                    // TextField for confirming password input

                    controller: confirmPassController,
                    obsecure:
                        true, // Hides the text input for password confirmation

                    text: AppLocale.confirm_your_password_label
                        .getString(context),
                  ),
                  const SizedBox(
                    height: 30,
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

                            if (confirmPassController.text == "") {
                              Fluttertoast.showToast(
                                msg: "Please confirm your password!!",
                              );
                              return;
                            }

                            if (confirmPassController.text !=
                                passController.text) {
                              Fluttertoast.showToast(
                                msg: "Passwords don't match!!",
                              );
                              return;
                            }

                            if (fullNameController.text == "") {
                              Fluttertoast.showToast(
                                msg: "Please enter your full name!!",
                              );
                              return;
                            }

                            createAccountProvider.toggleLoading();

                            try {
                              var res = await AuthController.createAccount(
                                {
                                  "email":
                                      emailController.text.toLowerCase().trim(),
                                  "password": passController.text,
                                  "fullName": fullNameController.text,
                                  "phone": phoneController.text,
                                },
                              );
                              print("create account status $res");
                              if (res["result"] == true) {
                                Navigator.of(context).pop();
                              } else {
                                Fluttertoast.showToast(
                                  msg: res["message"].toString(),
                                );
                              }
                            } catch (e) {
                              print(e.toString());
                            }

                            createAccountProvider.toggleLoading();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Globals.btncolor,
                            ),
                          ),
                          child: Text(
                            AppLocale.signup_label.getString(
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
                ],
              ),
      ),
    );
  }
}
