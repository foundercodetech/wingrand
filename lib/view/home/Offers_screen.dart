// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, use_build_context_synchronously, avoid_types_as_parameter_names

import 'dart:convert';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/model/extradepositmodel.dart';
import 'package:wingrandseven/model/user_model.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/api_urls.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/provider/user_view_provider.dart';
import 'package:wingrandseven/utils/utils.dart';
import 'package:wingrandseven/view/wallet/depositweb.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {

  @override
  void initState() {
    ExtraDeposit();
    // TODO: implement initState
    super.initState();
  }
  bool loading = false;

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: height*0.52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight:Radius.circular(10) ),
            gradient: AppColors.containerMainGradient
        ),
        child: Column(
          children: [
            Container(
              height: height*0.06,
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),gradient: AppColors.secondaryappbar),
              child: Row(
                children: [
                  const AppBackBtn(),
                  SizedBox(width: width*0.16),
                  Center(
                      child: textWidget(
                          text: "Offers",
                          fontSize: width*0.055,
                          color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: height*0.01),
            Expanded(
              child: ListView.builder(
                itemCount: DepositItems.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext, int index){
                  return
                    DepositItems[index].status=="1"?
                    Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    textWidget(text: "First Deposit ",
                                      fontSize: 13,
                                    ),
                                    textWidget(text:"₹${DepositItems[index].name}",
                                        fontSize: 13,
                                        color: Colors.red.shade900
                                    )
                                  ],
                                ),
                                textWidget(text:"Total: ₹${DepositItems[index].totalamount}",
                                    fontSize: 13,
                                    color:  Colors.red.shade900
                                )

                              ],
                            ),
                            SizedBox(height: height*0.01),

                            textWidget(text:"Deposit ₹${DepositItems[index].name} for the first time in your  account and you can recieve bonus ₹${DepositItems[index].addon}",
                              fontSize: 13,
                            ),

                            SizedBox(height: height*0.01),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: (){
                                  ExtradepositPay(amount:DepositItems[index].name.toString());
                                },
                                child: Container(
                                  height: height*0.04,
                                  width: width*0.28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.red.shade900
                                    )
                                  ),
                                  child:
                                  Center(
                                    child: textWidget(text:"Deposit",
                                        fontSize: 14,
                                        color: Colors.red.shade900
                                    ),
                                  ),

                                ),
                              ),
                            )
                          ],
                        )
                      ),
                    )):
                    Container(
                      decoration: BoxDecoration(
                          gradient: AppColors.secondaryappbar,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  textWidget(text:"First Deposit ",
                                      fontSize: 13,
                                      color: Colors.white
                                  ),
                                  textWidget(text:"₹${DepositItems[index].name}",
                                      fontSize: 13,
                                      color: Colors.grey
                                  ),

                                ],
                              ),

                              textWidget(text:"Total: ₹${DepositItems[index].totalamount}",
                                  fontSize: 13,
                                  color: Colors.grey),

                            ],
                          ),
                          SizedBox(height: height*0.01),
                          textWidget(text:"Deposit ₹${DepositItems[index].name} for the first time in your  account and you can recieve bonus ₹${DepositItems[index].addon}",
                              fontSize: 13,
                              color: Colors.white),
                          SizedBox(height: height*0.01),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: height*0.04,
                              width: width*0.28,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey
                                  )
                              ),
                              child:
                              Center(
                                child: textWidget(text:"Claimed",
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),


                            ),
                          ),
                        ],
                      ),
                    ),
                    );

                  }),
            )


          ],
        ),
      ),
    );
  }

  UserViewProvider userProvider = UserViewProvider();


  ExtradepositPay({required String amount})async {
    setState(() {
      loading=true;
    });
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    if (kDebugMode) {
      print(ApiUrl.extradepositPayment);
      print("ApiUrl.extradepositPayment");

    }

    final response =  await http.get(Uri.parse("${ApiUrl.extradepositPayment}userid=$token&amount=$amount"),
      
    );
    final data = jsonDecode(response.body);
    if (kDebugMode) {
      print(data);
      print("jdguywfud");
    }
    if(data["status"]=='SUCCESS'){
      setState(() {
        loading=false;
      });

      // var urlget =data['payment_link'].toString();
      var url =data['payment_link'].toString();

      // _launchURL(urlget);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>payment_Web(url: url,)));
      Utils.flushBarSuccessMessage(data["msg"],context, Colors.white);
    }
    else{
      setState(() {
        loading=false;
      });
      Utils.flushBarErrorMessage( data["msg"],context, Colors.white);
    }

  }



  List<ExtraDepositModel> DepositItems = [];

  Future<void> ExtraDeposit() async {
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();
    final response = await http.get(Uri.parse(ApiUrl.extradeposit+token),);
    if (kDebugMode) {
      print(ApiUrl.extradeposit+token);
      print('extradeposit');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        DepositItems = responseData.map((item) => ExtraDepositModel.fromJson(item)).toList();
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

}
