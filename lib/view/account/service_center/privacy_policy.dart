import 'package:flutter/foundation.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/helper/api_helper.dart';
import 'package:wingrandseven/res/provider/privacypolicy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  @override
  void initState() {
    fetchDataPrivacyPolicy(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataprivacy = Provider.of<PrivacyPolicyProvider>(context).PpData;


    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Privacy Policy',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: dataprivacy!= null?Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: AppColors.containerMainGradient),
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataprivacy.disc.toString()),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataPrivacyPolicy(context) async {
    try {
      final privacyDataa = await  baseApiHelper.fetchdataPP();
      if (kDebugMode) {
        print(privacyDataa);
        print("privacyDataa");
      }

      if (privacyDataa != null) {
        Provider.of<PrivacyPolicyProvider>(context, listen: false).setPrivacy(privacyDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
