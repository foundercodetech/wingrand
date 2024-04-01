// ignore_for_file: library_private_types_in_public_api

import 'package:wingrandseven/res/aap_colors.dart';
import 'package:wingrandseven/res/components/app_bar.dart';
import 'package:wingrandseven/res/components/app_btn.dart';
import 'package:wingrandseven/res/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class ExtraDepositPay extends StatefulWidget {
  final String url;

  const ExtraDepositPay({super.key, required this.url});

  @override
  _ExtraDepositPayState createState() => _ExtraDepositPayState();
}
class _ExtraDepositPayState extends State<ExtraDepositPay> {
  late WebViewController _controller;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    print('wwwwww');

    return SafeArea(
      child: Scaffold(
        appBar: GradientAppBar(
            leading: const AppBackBtn(),
            title: textWidget(
                text: 'Pay', fontSize: 25, color: AppColors.primaryTextColor),
            gradient: AppColors.primaryGradient),
        body: Column(
          children: <Widget>[
            if (_isLoading)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white, // Set your desired background color
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Expanded(
              child: WebView(
                backgroundColor: Colors.transparent,
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                  webViewController.clearCache();
                  final cookieManager = CookieManager();
                  cookieManager.clearCookies();
                },
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('upi://')) {
                    launch(request.url);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  setState(() {
                    _isLoading = true;
                  });
                },
                onPageFinished: (String url) {
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}