import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/helper/api_helper.dart';
import 'package:wingrandseven/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wingrandseven/view/wallet/wallet_history.dart';
import 'package:provider/provider.dart';
import '../../res/provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  void initState() {
    walletfetch(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final walletdetails = Provider.of<WalletProvider>(context).walletlist;
    
    return Scaffold(
      appBar: GradientAppBar(
          title: textWidget(
              text: 'Wallet', fontSize: 25, color: Colors.white,),
          gradient: AppColors.secondaryappbar),
      body: walletdetails != null
          ? Container(
           height: height,
            width: width,
            decoration: BoxDecoration(
            gradient: AppColors.containerMainGradient
              ),
            child: ListView(
             shrinkWrap: true,
             children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        height: height*0.38,
                        width: width,
                        decoration: BoxDecoration(
                            gradient: AppColors.redButtonGradient),
                        child: Align(
                          alignment: Alignment.center,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                              height: height*0.33,
                              width: width*0.90,
                              child: Column(
                                children: [
                                  Image.asset(Assets.iconsWithdrawHistory,height: height*0.06,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.currency_rupee,
                                          size: 20, color: AppColors.browntextprimary),
                                      textWidget(
                                          text: double.parse(walletdetails.wallet.toString()).toStringAsFixed(2),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color:AppColors.browntextprimary,),

                                    ],
                                  ),
                                  textWidget(
                                    text: 'Total Balance',
                                    color: AppColors.browntextprimary,
                                    fontSize: 14,

                                  ),
                                  const SizedBox(height: 40),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const WalletHistory(
                                                          name: "Winning Wallet",
                                                          type: "1")));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Container(
                                                height: height * 0.10,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                color: Color(0xffff9eb9),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    textWidget(
                                                      text: "Winning Wallet",
                                                      fontSize: 11,

                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                    textWidget(
                                                      text: "₹ ${walletdetails.winning_wallet}",
                                                      fontSize: 13,

                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletHistory(name: "Bonus", type: "2")));
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletHistory(name: "Bonus", type: "3")));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Container(
                                                height: height * 0.10,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffff9eb9),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    textWidget(
                                                      text: "Bonus",
                                                      fontSize: 12,

                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                    textWidget(
                                                      text: "₹ ${walletdetails.bonus}",
                                                      fontSize: 13,

                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletHistory(name: "Commission", type: "2")));
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: Container(
                                                height: height * 0.10,
                                                width: width * 0.25,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffff9eb9),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    textWidget(
                                                      text: "Commission",
                                                      fontSize: 12,

                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                    textWidget(
                                                      text: "₹ ${walletdetails.commission}",
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w900,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),


                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height*0.03,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          itemWidget(() {
                            Navigator.pushNamed(context, RoutesName.depositScreen);
                          }, Assets.iconsDepositHistory, 'Deposit'),
                          itemWidget(() {
                            Navigator.pushNamed(context, RoutesName.withdrawScreen);
                          }, Assets.iconsWithdrawHistory, 'Withdraw'),
                          itemWidget(() {
                            Navigator.pushNamed(context, RoutesName.depositHistory);
                          }, Assets.iconsDepositHistory, 'Deposit \nHistory'),
                          itemWidget(() {
                            Navigator.pushNamed(context, RoutesName.withdrawalHistory);
                          }, Assets.iconsWithdrawHistory, 'Withdraw \nHistory'),


                        ],
                      )
                    ],
                  ),

                ],
              ),
          )
          : Container(),
    );
  }

  Future<void> walletfetch(context) async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final walletData = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(walletData);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(walletData!);
    } catch (error) {
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }


  Widget itemWidget(Function()? onTap, String image, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Image.asset(image, height: 40),
              )),
          const SizedBox(height: 10),
          textWidget(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              ),
        ],
      ),
    );
  }
}
