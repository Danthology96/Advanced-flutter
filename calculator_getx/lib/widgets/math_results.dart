import 'package:calculator/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';

import 'package:calculator/widgets/sub_result.dart';
import 'package:get/get.dart';
import 'line_separator.dart';
import 'main_result.dart';

class MathResults extends StatelessWidget {
  const MathResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final calculatorController = Get.find<CalculatorController>();

    return Obx(
      () => Column(
        children: [
          SubResult(text: calculatorController.firstNumber.value),
          SubResult(text: calculatorController.operation.value),
          SubResult(text: calculatorController.secondNumber.value),
          LineSeparator(),
          MainResultText(text: calculatorController.mathResult.value),
        ],
      ),
    );
  }
}
