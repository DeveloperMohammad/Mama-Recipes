import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeStepperWidget extends StatefulWidget {
  const RecipeStepperWidget({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  State<RecipeStepperWidget> createState() => _RecipeStepperWidgetState();
}

class _RecipeStepperWidgetState extends State<RecipeStepperWidget> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const ClampingScrollPhysics(),
      onStepContinue: () {
        setState(() {
          if (currentStep < widget.recipe.steps.length - 1) {
            currentStep++;
          }
        });
      },
      onStepCancel: () {
        setState(() {
          if (currentStep >= 1) {
            setState(() {
              currentStep--;
            });
          }
        });
      },
      currentStep: currentStep,
      onStepTapped: (index) => setState(() => currentStep = index),
      controlsBuilder: (context, controlDetails) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: controlDetails.onStepContinue,
                child: const Text(
                  'مرحله بعد',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton(
                onPressed: controlDetails.onStepCancel,
                child: const Text('مرحله قبل'),
              ),
            ],
          ),
        );
      },
      steps: widget.recipe.steps.map((step) {
        return Step(
          state: StepState.indexed,
          title: const SizedBox.shrink(),
          content: Text(step),
        );
      }).toList(),
    );
  }
}
