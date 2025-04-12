import 'package:flutter/material.dart';
import 'package:volt_market/core/constants/image_manager.dart';
import 'package:volt_market/core/helper/navigation_helper.dart';
import 'package:volt_market/core/helper/sharedpref_helper.dart';
import 'package:volt_market/core/helper/spacing_helper.dart';
import 'package:volt_market/core/routing/my_routes.dart';
import 'package:volt_market/core/theme/colors_manager.dart';
import 'package:volt_market/features/onboarding/widgets/custom_animated_indicator.dart';
import 'package:volt_market/features/onboarding/widgets/custom_button.dart';
import 'package:volt_market/features/onboarding/widgets/pageview_screen_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int index = 0;
  bool isItLastScreen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsManager.lightShade,
                ColorsManager.darkBlueViolet,
                ColorsManager.lightPurple,
              ],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged:
                      (value) => setState(() {
                        index = value;
                        if (index == 2) {
                          isItLastScreen = true;
                        } else {
                          isItLastScreen = false;
                        }
                      }),
                  physics: BouncingScrollPhysics(),
                  children: [
                    PageViewScreenWidget(
                      img: ImageManager.kIntroFirstScreen,
                      title:
                          'Discover The Latest Tech\nExplore Cutting-Edge Gadgets & Devices',
                      description:
                          'Stay ahead with the newest smartphones, laptops, and smart home devices. We bring you the best from top brands at unbeatable prices.',
                    ),
                    PageViewScreenWidget(
                      img: ImageManager.kIntroSecondScreen,
                      title:
                          'Exclusive Deals & Discounts\nSave Big on Premium Electronics',
                      description:
                          'Enjoy limited-time offers, flash sales, and member-only discounts on your favorite electronics. Never miss a deal again!',
                    ),
                    PageViewScreenWidget(
                      img: ImageManager.kIntroThirdScreen,
                      title:
                          'Fast & Secure Delivery\nYour Order, At Your Doorstep',
                      description:
                          'Get lightning-fast shipping and real-time tracking. We ensure safe delivery with warranty support for all products.',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAnimatedIndicator(active: index == 0),
                  horizontalSpace(6),
                  CustomAnimatedIndicator(active: index == 1),
                  horizontalSpace(6),
                  CustomAnimatedIndicator(active: index == 2),
                ],
              ),
              verticalSpace(40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: isItLastScreen ? 'Register' : 'Skip',
                      onTap: () async {
                        await SharedprefHelper.setFirstTimeFlag(false);
                        if (isItLastScreen) {
                          context.pushNamedAndRemoveUntil(
                            MyRoutes.signupScreen,
                            (route) => false,
                          );
                        } else {
                          context.pushNamedAndRemoveUntil(
                            MyRoutes.loginScreen,
                            (route) => false,
                          );
                        }
                      },
                    ),
                    CustomButton(
                      text: isItLastScreen ? 'Login' : 'Next',
                      color: Color(0xFFFFFFFF),
                      onTap: () async {
                        if (isItLastScreen) {
                          await SharedprefHelper.setFirstTimeFlag(false);
                          context.pushNamedAndRemoveUntil(
                            MyRoutes.loginScreen,
                            (route) => false,
                          );
                        }
                        _pageController.animateToPage(
                          index + 1,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.linear,
                        );
                      },
                    ),
                  ],
                ),
              ),
              verticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
