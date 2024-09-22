import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:valet_parking_app/components/custom_dots.dart';
import 'package:valet_parking_app/components/custom_text_button.dart';
import 'package:valet_parking_app/components/custom_button.dart';
import 'package:valet_parking_app/modules/onboarding/onboarding_controller.dart';
import 'package:valet_parking_app/routes/app_pages.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [
              SizedBox(
                height: 560,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (value) => controller.currentPage.value = value,
                  itemCount: controller.contents.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Image.asset(
                          controller.contents[i].image,
                          height: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          controller.contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          controller.contents[i].desc,
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    );
                  },
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    CustomDots(
                      length: controller.contents.length,
                      index: controller.currentPage.value,
                      currentPage: controller.currentPage.value,
                    ),
                    const SizedBox(height: 40),
                    controller.currentPage.value + 1 == controller.contents.length
                        ? SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              text: "Empezar",
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: CustomTextButton(
                                  onPressed: () {
                                    controller.pageController.jumpToPage(2);
                                  },
                                  text: "Saltar",
                                ),
                              ),
                              Expanded(
                                child: CustomButton(
                                  onPressed: () {
                                    controller.pageController.nextPage(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeIn,
                                    );
                                  },
                                  text: "Siguiente",
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
