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
import 'package:wingrandseven/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/components/rich_text.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  bool readAndAgreePolicy = false;

  String phoneNumber = '';
  bool showContainer = false;
  bool show = false;



  TextEditingController phoneCon = TextEditingController();
  TextEditingController setPasswordCon = TextEditingController();
  TextEditingController confirmPasswordCon = TextEditingController();
  // TextEditingController refercodee = TextEditingController(text:"971752563938");
  TextEditingController refercodee = TextEditingController();
  TextEditingController emailCon = TextEditingController();

  final _formKey = GlobalKey<FormState>();

 
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserAuthProvider>(context);

    String argument = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: GradientAppBar(
          title: Image.asset(Assets.imagesLogoredmeta, height: 40),
          leading: const AppBackBtn(),
          gradient: AppColors.primaryappbargrey),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              gradient: AppColors.containerMainGradient),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration:
                const BoxDecoration(gradient: AppColors.primaryappbargrey),
                child: ListTile(
                  title:  Text("Register",style: BahnschriftMedium.copyWith(fontSize: 22,color: AppColors.primaryTextColor),),
                  subtitle:  Text('Please register by phone number or email',style: BahnschriftBlack.copyWith(fontSize: 13,color: AppColors.primaryTextColor))
                ),
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.iconsPhoneTabColor,
                    height: 28,
                  ),
                  const SizedBox(width: 2),
                  Text("Register your phone",style: BahnschriftMedium.copyWith(fontWeight: FontWeight.w600,
                    fontSize: 16,),),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Divider(thickness: 0.7, color: AppColors.dividerColor),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsInvitionCode,
                      height: 30,
                    ),
                    const SizedBox(width: 20),
                    Text('Invite Code',style: BahnschriftMedium.copyWith(fontWeight: FontWeight.w400,
                      fontSize: 18,),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: CustomTextField(
                  controller: refercodee,
                  maxLines: 1,
                  hintText: 'Please Enter Invite code',
                  fillColor: Colors.white,
                  filled: true,
                  style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsPhone,
                      height: 30,
                    ),
                    const SizedBox(width: 20),
                    Text('Phone Number',style: BahnschriftMedium.copyWith(fontWeight: FontWeight.w400,
                      fontSize: 18,),),

                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    children: [
                       SizedBox(
                        width: 100,
                        child: CustomTextField(
                          enabled: false,
                          fillColor: Colors.white,
                          filled: true,
                          style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                          hintText: '+91',
                          suffixIcon: RotatedBox(
                              quarterTurns: 45,
                              child: Icon(Icons.arrow_forward_ios_outlined,
                                  size: 20)),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: CustomTextField(
                            keyboardType: TextInputType.phone,
                            controller: phoneCon,
                            maxLength: 10,
                            fillColor: Colors.white,
                            filled: true,
                            style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                            hintText: 'Please enter the phone number',
                          )),
                    ],
                  )),
              // if (showContainer==true)
              //   Column(
              //     children: [
              //       Padding(
              //           padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              //           child: Row(
              //             children: [
              //               Icon(
              //                 Icons.verified_user,
              //                 color: Colors.red,
              //               ),
              //               const SizedBox(width: 20),
              //               textWidget(
              //                   text: 'OTP',
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 18,
              //                   color: AppColors.secondaryTextColor)
              //             ],
              //           )),
              //       Padding(
              //         padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              //         child: CustomTextField(
              //           controller: otp,
              //           prefixIcon: const Icon(
              //             Icons.verified_user,
              //             color: Colors.red,
              //           ),
              //           maxLines: 1,
              //           hintText: 'Verification code',
              //           onChanged: (v) async {
              //             if(v.length==4){
              //               otpMatch(otp.text,phoneCon.text);
              //
              //             }else{
              //               print("not done");
              //             }
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              //
              // SizedBox(height: 10,),
              // if (showContainer==false)
              // CustomButton(
              //   onTap: () {
              //     setState(() {
              //       showContainer = phoneCon.text.isNotEmpty;
              //
              //     });
              //     otpurl(phoneCon.text);
              //   //  otpMatch(myControllers.map((e) => e.text).join(),phoneCon.text);
              //   },
              //   text: 'Send OTP',
              //   textColor: Colors.white,
              // ),
              // // CustomButton(
              // //   onTap: () {
              // //    // otpurl(phoneCon.text);
              // //       otpMatch(myControllers.map((e) => e.text).join(),phoneCon.text);
              // //   },
              // //   text: 'match OTP',
              // //   textColor: Colors.white,
              // // ),


              // if(show==true)
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Row(
                    children: [
                      Image.asset(Assets.iconsEmailTabColor,height: 30,),
                      const SizedBox(width: 20),
                      Text('Email',style: BahnschriftMedium.copyWith(fontWeight: FontWeight.w400,
                        fontSize: 18,),),

                    ],
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: CustomTextField(
                  onChanged: (value) {
                    if (emailCon.text.isNotEmpty) {}
                  },
                  controller: emailCon,
                  maxLines: 1,
                  fillColor: Colors.white,
                  filled: true,
                  style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                  hintText: 'Please input your email',
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsPassword,
                      height: 30,
                    ),
                    const SizedBox(width: 20),
                    Text('Set Password',style: BahnschriftMedium.copyWith(fontWeight: FontWeight.w400,
                      fontSize: 18,),),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: CustomTextField(
                  obscureText: hideSetPassword,
                  controller: setPasswordCon,
                  maxLines: 1,
                  fillColor: Colors.white,
                  filled: true,
                  style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                  hintText: 'Please enter set password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideSetPassword = !hideSetPassword;
                        });
                      },
                      icon: Image.asset(hideSetPassword
                          ? Assets.iconsEyeClose
                          : Assets.iconsEyeOpen)),

                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.iconsPassword,
                      height: 30,
                    ),
                    const SizedBox(width: 20),
                    Text('Confirm password',style: BahnschriftMedium.copyWith( fontWeight: FontWeight.w400,
                        fontSize: 18,),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: CustomTextField(
                  // validator: (value) {
                  //   if (confirmPasswordCon.text.isEmpty) {
                  //     return 'Please enter your password';
                  //   }
                  //   return null;
                  // },
                  obscureText: hideConfirmPassword,
                  controller: confirmPasswordCon,
                  maxLines: 1,
                  fillColor: Colors.white,
                  filled: true,
                  style: BahnschriftMedium.copyWith(color:AppColors.secondaryTextColor),
                  hintText: 'Please EnterConfirm password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hideConfirmPassword = !hideConfirmPassword;
                        });
                      },
                      icon: Image.asset(hideConfirmPassword
                          ? Assets.iconsEyeClose
                          : Assets.iconsEyeOpen)),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          readAndAgreePolicy = !readAndAgreePolicy;
                        });
                      },
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: readAndAgreePolicy
                            ? BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(Assets.iconsCorrect)),
                          border: Border.all(
                              color: AppColors.secondaryTextColor),
                          borderRadius:
                          BorderRadiusDirectional.circular(50),
                        )
                            : BoxDecoration(
                          border: Border.all(
                              color: AppColors.secondaryTextColor),
                          borderRadius:
                          BorderRadiusDirectional.circular(50),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomRichText(
                      textSpans: [
                        CustomTextSpan(
                          text: "I have read and agree",
                          textColor: Colors.black,
                          fontSize: 13,
                          spanTap: () {
                            setState(() {
                              readAndAgreePolicy = !readAndAgreePolicy;
                            });
                          },
                        ),
                        CustomTextSpan(
                          text: "【Privacy Agreement】",
                          textColor: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          spanTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: AppBtn(
                    title: 'Register',
                    fontSize: 20,
                    loading: authProvider.regLoading,
                    onTap: () {

                      if(phoneCon.text.isEmpty || phoneCon.text.length!=10){
                        Utils.flushBarSuccessMessage("Enter phone number", context, Colors.red);
                      }else if(setPasswordCon.text.isEmpty){
                        Utils.flushBarSuccessMessage("Set your password", context, Colors.red);
                      } else if(confirmPasswordCon.text.isEmpty){
                        Utils.flushBarSuccessMessage("Confirm your password", context, Colors.red);
                      } else if(emailCon.text.isEmpty){
                        Utils.flushBarSuccessMessage("Confirm your email", context, Colors.red);
                      }
                      else {
                        authProvider.userRegister(
                            context,
                            phoneCon.text,
                            setPasswordCon.text,
                            confirmPasswordCon.text,
                            refercodee.text,
                            emailCon.text
                        );
                      }},
                    hideBorder: true,
                    gradient: AppColors.primaryGradient
                  // gradient: activeButton
                  //     ? AppColors.primaryGradient
                  //     : AppColors.inactiveGradient,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: AppBtn(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.loginScreen);
                  },
                  gradient: AppColors.secondaryGradient,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textWidget(
                          text: 'I have an account',
                          fontSize: 16,
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.w600),
                      const SizedBox(width: 15),
                      textWidget(
                          text: 'Login',
                          fontSize: 22,
                          color: AppColors.gradientFirstColor,
                          fontWeight: FontWeight.w600)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}