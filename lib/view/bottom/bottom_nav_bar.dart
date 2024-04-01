import 'package:wingrandseven/generated/assets.dart';
import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/utils/routes/routes_name.dart';
import 'package:wingrandseven/utils/utils.dart';
import 'package:wingrandseven/view/account/account_screen.dart';
import 'package:wingrandseven/view/activity/activity_screen.dart';
import 'package:wingrandseven/view/home/Offers_screen.dart';
import 'package:wingrandseven/view/home/home_screen.dart';
import 'package:wingrandseven/view/promotion/promotion_screen.dart';
import 'package:wingrandseven/view/promotion_new/promotion_main.dart';
import 'package:wingrandseven/view/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widget/bottom_widget.dart';


class BottomNavBar extends StatefulWidget {
  final int initialIndex;
  const BottomNavBar({super.key, this.initialIndex=0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _lastSelected = 0;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const ActivityScreen(),
    // const PromotionScreen(),
    const PromotionMain(),
    const WalletScreen(),
    const AccountScreen(),
  ];

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is int) {
        setState(() {
          _lastSelected = args;
        });
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      showDialog(context: context, builder: (context)=>OffersScreen());
    });
  }
  Future<bool> _onWillPop() async {
    if (_lastSelected > 0) {
      setState(() {
        _lastSelected=0;
      });
      return false;
    } else {
      return  await Utils.showExitConfirmation(context)?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
        body: _tabs[_lastSelected],
        bottomNavigationBar: FabBottomNavBar(
          color: const Color(0xffA4A5B0),
          selectedColor: const Color(0xffA4A5B0),
          onTabSelected: _selectedTab,
          backgroundColor: AppColors.darkcolor,

          items: [
            FabBottomNavBarItem(
              // imageData: _lastSelected == 0 ? Assets.imagesHomeYellow:Assets.imagesHomeGrey,
              imageData: Assets.imagesHomeGrey,
                text: 'Home'
            ),
            FabBottomNavBarItem(
              imageData: Assets.imagesTrophyGrey,
              text: 'Activity'
            ),
            FabBottomNavBarItem(
              text: '\n Promotion'
            ),
            FabBottomNavBarItem(
              imageData: Assets.imagesWalletGrey,
              text: 'Wallet'
            ),
            FabBottomNavBarItem(
              imageData:Assets.imagesAccountGrey,
              text: 'Account'
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.darkcolor,
          onPressed: () {
              setState(() {
                _selectedTab(2);
                selectedIndex=2;
              });
          },
          elevation: 0,
          child:
          Image.asset(Assets.imagesDiamond,fit: BoxFit.cover,)
        ),
      ),
    );
  }
}
class FeedbackProvider {
  static void navigateTohome(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 0);
  }
  static void navigateToActivity(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 1);
  }
  static void navigateToPromotion(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 2);
  }
  static void navigateToWallet(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 3);
  }
  static void navigateToAccount(BuildContext context) {
    Navigator.pushNamed(context, RoutesName.bottomNavBar,arguments: 4);
  }


}


class GradientTextview extends StatelessWidget {
  GradientTextview(
      this.text, {
        super.key,
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

