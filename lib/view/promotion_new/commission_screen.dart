import 'package:flutter/material.dart';
import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';

class Select{
  String title;
  Select(this.title);
}
class CommissionScreen extends StatefulWidget {
  const CommissionScreen({super.key});

  @override
  State<CommissionScreen> createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {

  List<Select> list = [
    Select("Daily Salary"),
    Select("Free Refferal Bonus"),
    Select("Level Income"),
    Select("Team Salary"),
    Select("Weekly Salary"),
    Select("CTO Income"),
    Select("Bonanza Bonus"),
    Select("Deposit Bonus"),
    Select("Promotion Income"),
    Select("Trading Income"),
    Select("Leadership Salary"),
    Select("Winner Income"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
          leading: AppBackBtn(),
          title: textWidget(
              text: 'Commission Data',
              fontSize: 20,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            gradient: AppColors.containerMainGradient
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height*0.45,
                  width: width,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5,
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColors.redButtonDoubleGradient,
                            borderRadius: BorderRadius.circular(10)

                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.imagesLotteryIcon,height: height*0.04,),
                              Text(
                                list[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
