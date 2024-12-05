import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/survey_kit.dart';

typedef StepShell = Widget Function({
  required Step step,
  required Widget child,
  StepResult Function()? resultFunction,
  bool isValid,
  SurveyController? controller,
});

class StepView extends StatefulWidget {
  final Step step;
  final Widget? answerView;
  final SurveyController? controller;

  const StepView({
    super.key,
    required this.step,
    this.answerView,
    this.controller,
  });

  @override
  State<StepView> createState() => _StepViewState();
}

class _StepViewState extends State<StepView> {
  final startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final surveyConfiguration = SurveyConfiguration.of(context);
    final _surveyController =
        widget.controller ?? surveyConfiguration.surveyController;

    final questionAnswer = QuestionAnswer.of(context);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Container(
            height: constraint.maxHeight,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraint) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...widget.step.content
                                    .map((c) => c.createWidget()),
                                if (widget.answerView != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: widget.answerView,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: questionAnswer.isValid,
                    builder: (context, isValid, child) {
                      return FilledButton(
                        onPressed: isValid
                            ? () => _surveyController.nextStep(
                                  context,
                                  questionAnswer.stepResult,
                                )
                            : null,
                        child: Text(
                          widget.step.buttonText ??
                              surveyConfiguration.localizations?['next']
                                  ?.toUpperCase() ??
                              'Next',
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
