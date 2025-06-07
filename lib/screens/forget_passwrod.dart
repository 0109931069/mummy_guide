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
// import 'package:google_fonts/google_fonts.dart';
import 'package:mummy_guide/widgets/title_widget.dart';
import 'package:provider/provider.dart';

class ForgetPasswrod extends StatefulWidget {

  ForgetPasswrod({super.key});

  @override
  State<ForgetPasswrod> createState() => _ForgetPasswrodState();
}

class _ForgetPasswrodState extends State<ForgetPasswrod> {
  final TextEditingController emailController = TextEditingController();

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
    
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: (MediaQuery.sizeOf(context).width - 40) * 0.5,
                        height:
                            (MediaQuery.sizeOf(context).height - 40) * 0.065,
                        child: FilledButton(
                          onPressed: () async {
                            var res = await AuthController.forgetPassword(emailController.text);
                            if(res["result"] == true){
                              Fluttertoast.showToast(
                                msg: res["message"].toString(),
                              );

                              Navigator.of(context).pop();

                            }else{
                                Fluttertoast.showToast(
                                msg: res["message"].toString(),
                              );
                            }
                          },
                           
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Globals.btncolor,
                            ),
                          ),
                          child: Text(
                            AppLocale.reset_password_label.getString(
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