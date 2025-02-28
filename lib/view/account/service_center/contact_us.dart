import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:wingrandseven/res/helper/api_helper.dart';
import 'package:wingrandseven/res/provider/contactus_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  @override
  void initState() {
    fetchcontact(context);
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final contactusData = Provider.of<ContactUsProvider>(context).ContactusData;

    return SafeArea(child: Scaffold(
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text: 'Contact Us',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: contactusData!= null?Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: AppColors.containerMainGradient),

        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(contactusData.disc.toString(),textStyle: const TextStyle(color: Colors.white),),
                ),
              ],
            )),


      ):Column(
        children: [
          Center(
            child: Image(
              image: const AssetImage(Assets.imagesNoDataAvailable),
              height: height / 3,
              width: width / 2,
            ),
          ),
          SizedBox(height: height*0.04),
          const Text("Data not found",style: TextStyle(color: Colors.white),)
        ],
      ),
    ));
  }
  Future<void> fetchcontact(context) async {
    try {
      final dataContact = await  baseApiHelper.fetchdataCU();
      if (kDebugMode) {
        print(dataContact);
        print("dataContact");
      }
      if (dataContact != null) {
        Provider.of<ContactUsProvider>(context, listen: false).setCu(dataContact);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
