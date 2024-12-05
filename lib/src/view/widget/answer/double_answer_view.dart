import 'package:flutter/material.dart' hide Step;
import 'package:flutter/services.dart';
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';

class DoubleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const DoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DoubleAnswerViewState createState() => _DoubleAnswerViewState();
}

class _DoubleAnswerViewState extends State<DoubleAnswerView>
    with MeasureDateStateMixin, AnswerMixin<DoubleAnswerView, double> {
  late final DoubleAnswerFormat _doubleAnswerFormat;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('DoubleAnswerFormat is null');
    }
    _doubleAnswerFormat = answer as DoubleAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ??
        _doubleAnswerFormat.defaultValue?.toString() ??
        '';
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onValidationChanged =
          isValid(widget.result?.result ?? _doubleAnswerFormat.defaultValue);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool isValid(double? value) {
    if (value == null && !widget.questionStep.isMandatory) {
      return true;
    }
    return value != null;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.-]')),
              ],
              decoration: InputDecoration(hintText: _doubleAnswerFormat.hint),
              controller: _controller,
              onChanged: (String text) {
                final number = double.tryParse(text);
                onChange(number);
              },
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
