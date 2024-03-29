import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lorem_gen/lorem_gen.dart';
import 'package:mr_ambarisha_frontend_new/utils/app_colors.dart';


class TermAndConditionView extends StatelessWidget {
  const TermAndConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    final sentence = Lorem.sentence(numSentences: 30);
    return Scaffold(
      appBar: AppBar(leading: InkWell(onTap: () {
        Get.back();
      },
        child: Icon(Icons.arrow_back,color: AppColors.black,)),
        backgroundColor: Colors.white,
        title: const Text(
          "Terms & Condition",
          style: TextStyle(color: AppColors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(
            sentence,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.black),
          ),
        ]),
      ))),
    );
  }
}
