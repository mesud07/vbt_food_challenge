import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:vbt_food_challange/features/onboardingpage/product/app_strings.dart';
import '../../../core/theme/color/color_theme.dart';
import '../../../core/widgets/custom_button.dart';
import '../model/onboarding_model.dart';
import '../product/app_size.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedSlider = 0;
  PageController sliderController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: _builderPageView(),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: _buildCustomButton(),
            )
          ],
        ),
      ),
    );
  }

  PageView _builderPageView() {
    return PageView.builder(
      onPageChanged: (index) {
        setState(() {
          selectedSlider = index;
        });
      },
      controller: sliderController,
      itemCount: models.length,
      itemBuilder: (context, index) {
        return _builderColumn(index, context);
      },
    );
  }

  Column _builderColumn(int index, BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: large * 5,
      ),
      _builderSvgPicture(index),
      const SizedBox(
        height: large * 6,
      ),
      _buildModelContainer(index, context),
      const SizedBox(
        height: large * 1,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          models.length,
          (index) => buildSliderNav(index: index),
        ),
      ),
    ]);
  }

  SvgPicture _builderSvgPicture(int index) {
    return SvgPicture.asset(
      models[index].image,
      height: xLarge5x * 6.8,
    );
  }

  Container _buildModelContainer(int index, BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      child: Column(
        children: [
          const SizedBox(height: xLarge2x / 3),
          Text(
            models[index].title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: isDark ? AppColors().white : AppColors().black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: xLarge2x / 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: xLarge2x * 2),
            child: Text(
              models[index].description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: isDark ? AppColors().white : AppColors().darkerGrey,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  CustomButton _buildCustomButton() {
    return CustomButton(
      func: () {
        if (selectedSlider != (models.length - 1)) {
          sliderController.animateToPage(selectedSlider + 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.linear);
        }
      },
      isLoading: false,
      text: selectedSlider == models.length - 1
          ? AppStrings.buttonBasla
          : AppStrings.buttonIleri,
    );
  }

  AnimatedContainer buildSliderNav({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: MediaQuery.of(context).size.width * 0.02,
      width: MediaQuery.of(context).size.width * 0.02,
      decoration: BoxDecoration(
          color: selectedSlider == index
              ? const Color(0XFFff6a6a)
              : const Color(0xFFD7D7D7),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
