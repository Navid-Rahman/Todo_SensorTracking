import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_sensor_tracking/constants/app_colors.dart';
import 'package:to_do_sensor_tracking/constants/assets.dart';

class BasePage extends StatelessWidget {
  final Widget child;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool? showAppBar;
  final String? appBarTitle;
  final bool showBackButton;
  final Color backgroundColor;

  const BasePage({
    required this.child,
    super.key,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.showAppBar = false,
    this.appBarTitle,
    this.showBackButton = false,
    this.backgroundColor = AppColors.scaffoldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: showAppBar!
              ? AppBar(
                  title: Text(appBarTitle!),
                  titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  backgroundColor: AppColors.scaffoldColor,
                  leading: showBackButton
                      ? IconButton(
                          icon: SvgPicture.asset(Assets.backButton),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : null,
                )
              : null,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
