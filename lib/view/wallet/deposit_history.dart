// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/model/UsdtDepositHistoryModel.dart';
import 'package:wingrandseven/model/user_model.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/api_urls.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../model/deposit_model.dart';

class DepositIconModel {
  final String title;
  final String? image;
  DepositIconModel({required this.title, this.image});
}

class History {
  String method;
  String balance;
  String type;
  String orderno;
  History(this.method, this.balance, this.type, this.orderno);
}

class DepositHistory extends StatefulWidget {
  const DepositHistory({super.key});

  @override
  State<DepositHistory> createState() => _DepositHistoryState();
}

class _DepositHistoryState extends State<DepositHistory> with  SingleTickerProviderStateMixin {

  @override
  void initState() {
    DepositHistoryyy();
    UsdtDepositHistoryyy();
    super.initState();
    selectedCatIndex = 0;

  }

  int ?responseStatuscode;

  List<DepositIconModel> depositIconList = [
    DepositIconModel(title: 'Indian Pay', image: Assets.imagesUpiImage),
    DepositIconModel(title: 'USDT', image: Assets.imagesUsdtIcon),
    
  ];
  late int selectedCatIndex;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Deposit History',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(gradient: AppColors.containerMainGradient),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                height: 70,
                width: width * 0.93,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: depositIconList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCatIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          height: 40,
                          width: 115,
                          decoration: BoxDecoration(
                            gradient: selectedCatIndex == index
                                ? AppColors.redButtonDoubleGradient
                                : AppColors.secondaryappbar,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey, width: 0.1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 0.2,
                                blurRadius: 2,
                                offset: const Offset(2, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('${depositIconList[index].image}'),
                                height: 25,

                              ),
                              textWidget(
                                text: depositIconList[index].title,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: selectedCatIndex == index
                                    ? Colors.white
                                    : AppColors.goldencolorthree,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: height*0.02),
              selectedCatIndex==0?
              responseStatuscode== 400 ?
              const Notfounddata(): DepositItems.isEmpty? const Center(child: CircularProgressIndicator()):
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                        itemCount: DepositItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: width * 0.30,
                                        decoration: BoxDecoration(
                                            color: DepositItems[index].status=="0"?Colors.orange: DepositItems[index].status=="1"?AppColors.DepositButton:Colors.red,
                                            borderRadius: BorderRadius.circular(10)),
                                        child: textWidget(
                                            text: DepositItems[index].status=="0"?"Pending":DepositItems[index].status=="1"?"Complete":"Failed",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primaryTextColor
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Balance",
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryTextColor),
                                      textWidget(
                                          text: "₹${DepositItems[index].amount}",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryTextColor),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:  const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Type",
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryTextColor),
                                      Image.asset(DepositItems[index].type=="2"?Assets.imagesUsdtIcon:Assets.imagesFastpayImage, height: height*0.05,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Time",
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryTextColor),
                                      textWidget(
                                          text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(DepositItems[index].created_at.toString())),                                        fontSize: 14,
                                          fontWeight: FontWeight.bold,


                                          ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          text: "Order number",
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryTextColor),
                                      Row(
                                        children: [
                                          textWidget(
                                              text: DepositItems[index].orderid.toString(),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                               AppColors.secondaryTextColor),
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          Image.asset(Assets.iconsCopy, color: Colors.grey,height: height * 0.03)                                      ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })

              ):
              responseStatuscode== 400 ?
              const Notfounddata(): usdtitem.isEmpty? const Center(child: CircularProgressIndicator()):
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: usdtitem.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      width: width * 0.30,
                                      decoration: BoxDecoration(
                                          color: usdtitem[index].status=="0"?Colors.orange: usdtitem[index].status=="1"?AppColors.DepositButton:Colors.red,
                                          borderRadius: BorderRadius.circular(10)),
                                      child: textWidget(
                                          text: usdtitem[index].status=="0"?"Pending":usdtitem[index].status=="1"?"Success":"Reject",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryTextColor
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Amount",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    textWidget(
                                        text: "₹${usdtitem[index].amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "USDT amount",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    textWidget(
                                        text: "₹${usdtitem[index].actual_amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Time",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    textWidget(
                                        text: DateFormat("dd-MMM-yyyy, hh:mm a").format(DateTime.parse(usdtitem[index].created_at.toString())),                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,

                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        );
                      })
              )
            ],
          ),
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<DepositModel> DepositItems = [];

  Future<void> DepositHistoryyy() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse(ApiUrl.depositHistory+token),);
    if (kDebugMode) {
      print(ApiUrl.depositHistory+token);
      print('depositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        DepositItems = responseData.map((item) => DepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        DepositItems = [];
      });
      throw Exception('Failed to load data');
    }
  }


  List<USDTDepositModel> usdtitem = [];

  Future<void> UsdtDepositHistoryyy() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse("${ApiUrl.usdtdepositHistory}userid=$token"),);
    if (kDebugMode) {
      print("${ApiUrl.usdtdepositHistory}userid=$token");
      print('usdtdepositHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];

      if (kDebugMode) {
        print(responseData);
        print("responseData");
      }


      setState(() {
        usdtitem = responseData.map((item) => USDTDepositModel.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        usdtitem = [];
      });
      throw Exception('Failed to load data');
    }
  }


}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: height / 3,
          width: width / 2,
        ),
        const Text("Data not found",)
      ],
    );
  }

}



