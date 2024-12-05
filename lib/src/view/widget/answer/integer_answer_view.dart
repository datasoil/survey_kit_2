import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';

class IntegerAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const IntegerAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _IntegerAnswerViewState createState() => _IntegerAnswerViewState();
}

class _IntegerAnswerViewState extends State<IntegerAnswerView>
    with MeasureDateStateMixin, AnswerMixin<IntegerAnswerView, int> {
  late final IntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('ImageAnswerFormat is null');
    }
    _integerAnswerFormat = answer as IntegerAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ??
        _integerAnswerFormat.defaultValue?.toString() ??
        '';
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onValidationChanged =
          isValid(widget.result?.result ?? _integerAnswerFormat.defaultValue);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(int? value) {
    if (value == null && !widget.questionStep.isMandatory) {
      return true;
    }
    return value != null &&
        value >= _integerAnswerFormat.min &&
        value <= _integerAnswerFormat.max;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            textInputAction: TextInputAction.next,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9-]')),
            ],
            decoration: InputDecoration(hintText: _integerAnswerFormat.hint),
            controller: _controller,
            onChanged: (String text) {
              final number = int.tryParse(text);
              onChange(number);
            },
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
