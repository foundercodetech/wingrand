// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wingrandseven/main.dart';
import 'package:flutter/foundation.dart';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/api_urls.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/helper/api_helper.dart';
import 'package:wingrandseven/view/home/notification.dart';
import 'package:wingrandseven/view/home/widgets/category_elements.dart';
import 'package:wingrandseven/view/home/widgets/category_widgets.dart';
import 'package:wingrandseven/view/home/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    versionCheck();
    // TODO: implement initState
    super.initState();
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;

  bool verssionview = false;

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () => showAlert(context));
    // Future.delayed(Duration(seconds: 3), () {
    //   showDialog(context: context, builder: (context)=>OffersScreen());
    // });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.secondaryappbar
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(Assets.imagesLogoredmeta,height: height*0.05),
            Center(child: textWidget(text: "Welcome to WG7 Game",color: AppColors.goldencolor,fontWeight: FontWeight.bold,fontSize: width*0.036)),
          ],
        ),
        actions: [
          kIsWeb==true?
          IconButton(
            onPressed: () {
              _launchURL2();
            },
            icon: const Icon(Icons.download_for_offline,color:AppColors.goldencolor),
          ):
          Container()

        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                gradient: AppColors.rednewDoubleGradient),
            child: Column(
              children: [
                const SliderWidget(),
                Container(
                  height: height*0.06,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration( color: const Color(0xff656565),borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up, color: AppColors.goldencolor),
                      SizedBox(width: width*0.01),
                      _rotate()
                    ],
                  ),
                ),
                CategoryWidget(
                  onCategorySelected: (index) {
                    setState(() {
                      selectedCategoryIndex = index;
                    });
                  },
                ),
                CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _rotate(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children:[
        DefaultTextStyle(
          style: const TextStyle(
              fontSize: 12,
              color: Colors.white
          ),
          child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                RotateAnimatedText('Please Fill In The Correct Bank Card Information.'),
                RotateAnimatedText('Been Approved By The Platform. The Bank'),
                RotateAnimatedText('Will Complete The Transfer Within 1-7 Working Days,'),
                RotateAnimatedText('But Delays May Occur, Especially During Holidays.But'),
                RotateAnimatedText('You Are Guaranteed To Receive Your Funds.'),
              ]),
        ),
      ],
    );


  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Image(image: AssetImage(Assets.imagesLogoredmeta),fit: BoxFit.fill,),
                ),
                const Text('new version are available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Text(
                    'Update your app  ${ApiUrl.version}  to  $map',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _launchURL();
              if (kDebugMode) {
                print(versionlink);
                print("versionlink");
              }
            }, child: const Text("UPDATE"))

          ],
        ))
        : Container();
  }

  var map;
  var versionlink;

  Future<void> versionCheck() async {
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
   if (kDebugMode) {
     print(jsonDecode(response.body));
    }
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');

      }
      if (responseData['version'] != ApiUrl.version) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview=true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }

  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    var url = "https://bigbossmall.live/bigbossmall.apk";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}