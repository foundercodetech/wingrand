import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/fontstyle.dart';
import 'package:wingrandseven/res/components/text_field.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/provider/auth_provider.dart';
import 'package:wingrandseven/utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  bool selectedButton = true;
  bool hidePassword = true;
  bool rememberPass = false;
  TextEditingController phoneCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController passwordConn = TextEditingController();



  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<UserAuthProvider>(context);

    return Scaffold(
          appBar: GradientAppBar(
              title: Image.asset(Assets.imagesLogoredmeta, height: 40),
              leading: const AppBackBtn(),
              gradient: AppColors.primaryappbargrey),
          body:
          ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      gradient: AppColors.containerMainGradient),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.iconsPhoneTabColor),
                              SizedBox(width:width*0.01),
                              Text("Log in with phone",style: BahnschriftBlack.copyWith(fontSize: 16),),

                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Divider(thickness: 0.7, color: AppColors.dividerColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(Assets.iconsPhone),
                            const SizedBox(width: 20),
                            Text('Phone Number',style: BahnschriftMedium.copyWith(fontSize: 18),)

                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child:
                          Row(
                            children: [
                               SizedBox(
                                width: 100,
                                child: CustomTextField(
                                  enabled: false,
                                  hintText: '+91',
                                  fillColor: Colors.white,
                                  filled: true,
                                  style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor ),
                                  suffixIcon: RotatedBox(
                                      quarterTurns: 45,
                                      child: Icon(Icons.arrow_forward_ios_outlined,
                                          size: 20)),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                  child: CustomTextField(
                                    onChanged: (value) {
                                      if (phoneCon.text.length == 10) {
                                        // setState(() {
                                        //   activeButton = !activeButton;
                                        // });
                                      }
                                    },
                                    fillColor: Colors.white,
                                    filled: true,
                                    style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor ),                                    keyboardType: TextInputType.number,
                                    controller: phoneCon,
                                    maxLength: 10,
                                    hintText: 'Please enter the phone number',
                                  )),
                            ],
                          )

                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(Assets.iconsPassword),
                            const SizedBox(width: 20),
                            Text('Password',style: BahnschriftMedium.copyWith(fontSize: 18),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: CustomTextField(
                          obscureText: hidePassword,
                          controller: passwordCon,
                          maxLines: 1,
                          fillColor: Colors.white,
                          filled: true,
                          style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor ),
                          hintText: 'Please enterPassword',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              icon: Image.asset(hidePassword
                                  ? Assets.iconsEyeClose
                                  : Assets.iconsEyeOpen)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  rememberPass = !rememberPass;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                decoration: rememberPass ?BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          Assets.iconsCorrect)),
                                  border: Border.all(
                                      color: Colors.transparent
                                  ),
                                  borderRadius: BorderRadiusDirectional.circular(50),
                                ):BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.secondaryTextColor),
                                  borderRadius: BorderRadiusDirectional.circular(50),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Text('Remember password',style: BahnschriftMedium.copyWith(fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: AppBtn(
                            title: 'Log in',
                            fontSize: 20,
                            onTap: () {
                              // if (selectedButton==true) {
                              //   print("object");
                              //   authProvider.userLogin(context, phoneCon.text, passwordCon.text);
                              // } else {
                              //   authProvider.userLogin(context, emailCon.text, passwordCon.text);
                              // }

                              authProvider.userLogin(context, phoneCon.text, passwordCon.text);

                            },
                            hideBorder: true,
                            gradient: AppColors.redButtonDoubleGradient

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: AppBtn(
                          title: 'R e g i s t e r',
                          fontSize: 20,
                          titleColor: AppColors.gradientFirstColor,
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.registerScreen,arguments: '1');
                          },

                          gradient: AppColors.secondaryGradient,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          )
      );
  }




}

