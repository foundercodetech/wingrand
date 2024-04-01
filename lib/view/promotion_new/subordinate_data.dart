import 'package:flutter/material.dart';
import 'package:wingrandseven/main.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';


class SubordinateScreen extends StatefulWidget {
  const SubordinateScreen({super.key});

  @override
  State<SubordinateScreen> createState() => _SubordinateScreenState();
}

class _SubordinateScreenState extends State<SubordinateScreen> {
  List<String> list = <String>['All', 'LEVEL 1', 'LEVEL 2', 'LEVEL 3'];

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return Scaffold(
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'Subordinate Data',
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
            const SizedBox(height: 10),
            Container(
              height:50,
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const TextField(
                maxLength: 10,
                // controller: phoneNo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    counter: Offstage(),
                    hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                    hintText: 'Enter Mobile Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                      ),
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownMenu(
                  enabled: true,
                  width:150,
                  trailingIcon: Icon(Icons.keyboard_arrow_down_sharp),
                  initialSelection: list.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ), label:value,
                    );
                  }).toList(),
                ),
                Container(
                  height:50,
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const TextField(
                    maxLength: 10,
                    // controller: phoneNo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month),
                        counter: Offstage(),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        hintText: 'dd-mm-yyyy',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                          ),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: height*0.02,),
            Container(
              height: 300,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
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
                            fontWeight: FontWeight.w400,
                          color: Colors.white
                        ),

                        textWidget(
                            text: "number of register",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                        textWidget(
                            text: "0",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),

                        textWidget(
                            text: "Deposit number",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                        textWidget(
                            text: "₹0.00",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                        textWidget(
                            text: "Deposit amount",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        textWidget(
                            text: "0",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                        textWidget(
                            text: "No. of people making \nfirst deposit",
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: height*0.25,
                      child: const VerticalDivider(color: Colors.white,)),
                  Container(
                    height: height*0.28,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        textWidget(
                            text: "0",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),

                        textWidget(
                            text: "number of register",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                        textWidget(
                            text: "0",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),

                        textWidget(
                            text: "Deposit number",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                        textWidget(
                            text: "₹0.00",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                        textWidget(
                            text: "Deposit amount",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white
                        ),
                        textWidget(
                            text: "0",
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                        textWidget(
                            text: "No. of people making \nfirst deposit",
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
