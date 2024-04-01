// ignore_for_file: use_build_context_synchronously

import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/provider/services/splash_service.dart';
import 'package:wingrandseven/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

SplashServices splashServices = SplashServices();


class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 270,
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Container(
              height: 80,
              width: width*0.50,
              decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(Assets.iconsLogOut))
              ),

            ),
            SizedBox(height: height / 30),
            textWidget(text:"Do you want to logout?",
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold
            ),
            SizedBox(height: height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red)
                    ),
                    child: Center(
                      child: textWidget(
                          text: "Cancel",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');

                    Navigator.pushNamed(context,RoutesName.loginScreen);
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: AppColors.redButtonDoubleGradient
                    ),
                    child: Center(
                      child: textWidget(
                        text: "Confirm",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),],
            )
          ],
        ),
      ),
    );
  }
}
