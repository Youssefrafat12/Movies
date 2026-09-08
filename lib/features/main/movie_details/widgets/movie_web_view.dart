import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MovieWebView extends StatefulWidget {
  final String url;

  const MovieWebView({super.key, required this.url});

  @override
  State<MovieWebView> createState() => _MovieWebViewState();
}

class _MovieWebViewState extends State<MovieWebView> {
  late WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (isLoading)
              Container(
                color: AppColors.transparentColor.withValues(alpha: 0.3),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
