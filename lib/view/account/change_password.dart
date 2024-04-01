
import 'dart:convert';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/model/user_model.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/api_urls.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_field.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/provider/user_view_provider.dart';
import 'package:wingrandseven/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {


  bool hideSetPassword = true;
  bool hideConfirmPassword = true;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController oldPassCon = TextEditingController();
  TextEditingController newPassCon = TextEditingController();
  TextEditingController confirmPassCon = TextEditingController();


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Change Password',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: AppColors.containerMainGradient),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: height*0.01,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,

                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'Login Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: height*0.01,),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: oldPassCon,
                            maxLines: 1,
                            fillColor: Colors.white,
                            filled: true,
                            style: TextStyle(color: AppColors.secondaryTextColor),
                            hintText: 'Enter your old password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(hideSetPassword
                                    ? Assets.iconsEyeClose
                                    : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,

                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'New Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                               )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: newPassCon,
                            maxLines: 1,
                            fillColor: Colors.white,
                            filled: true,
                            style: TextStyle(color: AppColors.secondaryTextColor),
                            hintText: 'Please enter the new password',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(hideSetPassword
                                    ? Assets.iconsEyeClose
                                    : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.iconsPassword,
                              height: 30,

                            ),
                            const SizedBox(width: 20),
                            textWidget(
                                text: 'Confirm Password',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                               )
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                          child: CustomTextField(
                            obscureText: hideSetPassword,
                            controller: confirmPassCon,
                            maxLines: 1,
                            fillColor: Colors.white,
                            filled: true,
                            style: TextStyle(color: AppColors.secondaryTextColor),
                            hintText: 'Please re-enterpassword',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideSetPassword = !hideSetPassword;
                                  });
                                },
                                icon: Image.asset(hideSetPassword
                                    ? Assets.iconsEyeClose
                                    : Assets.iconsEyeOpen,color: AppColors.goldencolortwo,)),
                          )),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: AppBtn(
                          title: 'U p d a t e',
                          fontSize: 20,
                          gradient: AppColors.redButtonDoubleGradient,
                          hideBorder: true,
                          onTap: () {
                            changePass(oldPassCon.text,newPassCon.text,confirmPassCon.text,context);
                          },
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      )
    );
  }
  UserViewProvider userProvider = UserViewProvider();

  changePass(String oldpass, String newpass,String confirmpass,context) async {
    if (kDebugMode) {
      print("guycyg");
    }
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(token);
    }
    final response = await http.post(Uri.parse(ApiUrl.changepasswordapi),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic >{
          "userid":token,
          "old_password":oldpass,
          "new_password":newpass,
          "confirm_password":confirmpass
        })
    );
    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      if (kDebugMode) {
        print(data);
        print("👍👍👍👍updatee");
      }
      if(data["status"]=="200"){
        Utils.flushBarSuccessMessage(data["msg"], context, Colors.white);
      }
      else {
        Utils.flushBarErrorMessage(data["msg"], context, Colors.white);
      }
    }
    else{
      throw Exception("error");
    }

  }









}
