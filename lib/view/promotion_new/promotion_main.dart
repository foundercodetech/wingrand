import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/clipboard.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/helper/api_helper.dart';
import 'package:wingrandseven/res/provider/profile_provider.dart';
import 'package:wingrandseven/res/provider/user_view_provider.dart';
import 'package:wingrandseven/view/promotion/promotion_screen.dart';
import 'package:wingrandseven/view/promotion_new/commission_screen.dart';
import 'package:wingrandseven/view/promotion_new/subordinate_data.dart';

class Selection{
  String title;
  String images;
  final void Function()? onTap;
  Selection(this.title, this.images, this.onTap);

}

class PromotionMain extends StatefulWidget {
  const PromotionMain({super.key});

  @override
  State<PromotionMain> createState() => _PromotionMainState();
}

class _PromotionMainState extends State<PromotionMain> {

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();





  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<ProfileProvider>(context).userData;
    List<Selection> list = [
      Selection("Copy Invitation Code", Assets.imagesCopy, () {
        copyToClipboard(userData!.referralCode.toString(), context);
      }),
      Selection("Subordinate Data", Assets.imagesSubordinate, () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubordinateScreen()));}
      ),
      Selection("Commission Details", Assets.imagesCommission, () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CommissionScreen()));
      }),
      Selection("Join us On Telegram", Assets.imagesAgent, () {
        _launchURL3();
     }),
      Selection("Youtube Link", Assets.imagesAgent, () {
        _launchURL4();
      }),
    ];


    return Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Agency',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
            gradient: AppColors.containerMainGradient
        ),
        child: userData != null?ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: height*0.03,),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    height: height * 0.22,
                    width: width*0.90,
                    decoration:   BoxDecoration(
                        gradient:AppColors.redPromotionGradient,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft:Radius.circular(10) )),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          textWidget(
                            text: "₹0.00",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25
                          ),
                          Container(
                            width: width*0.60,
                            height: height*0.04,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffffa43f)
                            ),
                            child: Center(
                              child: textWidget(
                                  text: "Yesterday's total commission",
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                          textWidget(
                              text: "Upgrade the level to increase commission income",
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w400
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: height*0.20) ,
                      child: Container(
                        height: height*0.38,
                        width: width * 0.90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: height*0.05,
                              decoration: const BoxDecoration(
                                color: Color(0xfff6f6f6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.group,color: Colors.red),
                                      textWidget(
                                          text: "Direct subordinates",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                      )
                                    ],
                                  ),
                                  textWidget(
                                      text: "Team subordinates",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14
                                  )

                                ],
                              ),
                            ),
                            SizedBox(height: height*0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height*0.28,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      textWidget(
                                          text: "0",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400
                                      ),

                                      textWidget(
                                          text: "number of register",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                        color: Colors.grey
                                      ),
                                      textWidget(
                                          text: "0",
                                      fontSize: 15,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w400
                                      ),

                                      textWidget(
                                          text: "Deposit number",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),
                                      textWidget(
                                          text: "₹0.00",
                                      fontSize: 15,
                                      color: Colors.red.shade900,
                                      fontWeight: FontWeight.w400
                                      ),
                                      textWidget(
                                          text: "Deposit amount",
                                      fontSize: 15,
                                          color: Colors.grey,
                                      fontWeight: FontWeight.w400),
                                      textWidget(
                                          text: "0",
                                          fontSize: 15,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400
                                      ),
                                      textWidget(
                                          text: "No. of people making \nfirst deposit",
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ],
                                  ),
                                ),
                                 Container(
                                   height: height*0.25,
                                     child: const VerticalDivider(color: Colors.grey,)),
                                Container(
                                  height: height*0.28,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      textWidget(
                                          text: "0",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400
                                      ),

                                      textWidget(
                                          text: "number of register",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),
                                      textWidget(
                                          text: "0",
                                          fontSize: 15,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400
                                      ),

                                      textWidget(
                                          text: "Deposit number",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),
                                      textWidget(
                                          text: "₹0.00",
                                          fontSize: 15,
                                          color: Colors.red.shade900,
                                          fontWeight: FontWeight.w400
                                      ),
                                      textWidget(
                                          text: "Deposit amount",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey
                                      ),
                                      textWidget(
                                          text: "0",
                                          fontSize: 15,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400
                                      ),
                                      textWidget(
                                          text: "No. of people making \nfirst deposit",
                                          fontSize: 14,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )

                          ],
                        ),

                      )),
                )
              ],
            ),
            SizedBox(height: height*0.03,),
            Center(
              child: AppBtn(
                height: height*0.06,
                width: width*0.80,
                titleColor: Colors.white,
                gradient: AppColors.redButtonDoubleGradient,
                hideBorder: true,
                title: 'INVITATION LINK',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                onTap: () async {
                  await FlutterShare.share(
                      title: 'Referral Code :',
                      text: 'Join Now & Get Exiting Prizes. here is my Referral Code : ${userData.referralCode}',
                      linkUrl: "https://bigbossmall.live",
                      chooserTitle: 'Referral Code : ');
                },
              ),
            ),
            SizedBox(height: height*0.03,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListTile(
                    onTap: list[index].onTap,
                    leading: Image.asset(list[index].images,height: height*0.05,),
                    title: textWidget(
                      text: list[index].title,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey),
                  ),
                ),
              );
            }),
            SizedBox(height: height*0.03,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: height*0.30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height*0.02,),
                    textWidget(text: "promotion data",
                    fontSize: 17),
                    SizedBox(height: height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height*0.10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              textWidget(text: "₹0.00",
                                  fontSize: 15),
                              textWidget(text: "This Week",
                                  fontSize: 15),
                            ],
                          ),
                        ),
                        Container(
                            height: height*0.10,
                            child: VerticalDivider(color: Colors.grey,)),
                        Container(
                          height: height*0.10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              textWidget(text: "₹0.00",
                                  fontSize: 15),
                              textWidget(text: "Total Commission",
                                  fontSize: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height*0.10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(text: "0",
                                  fontSize: 15),
                              textWidget(text: " active direct \n subordinate ",
                                  fontSize: 15),
                            ],
                          ),
                        ),
                        Container(
                            height: height*0.10,
                            child: VerticalDivider(color: Colors.grey,)),
                        Container(
                          height: height*0.10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(text: "0",
                                  fontSize: 15),
                              textWidget(text: "       Total number of \n subordinates in team",
                                  fontSize: 15),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ],
                ),

              ),
            )


          ],
        ):Container()
      ),
    );
  }
  Future<void> fetchData() async {
    try {
      final userDataa = await baseApiHelper.fetchProfileData();
      if (kDebugMode) {
        print(userDataa);
        print("userData");
      }
      if (userDataa != null) {
        Provider.of<ProfileProvider>(context, listen: false).setUser(userDataa);
      }
    } catch (error) {}
  }

  UserViewProvider userProvider = UserViewProvider();

  _launchURL3() async {
    var url = "https://t.me/WinnGrand7official";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL4() async {
    var url = "https://www.youtube.com/@winngrand7";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
