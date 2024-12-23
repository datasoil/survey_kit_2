import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:intl/intl.dart';
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';

class DateAnswerView extends StatefulWidget {
  /// [QuestionStep] which includes the [DateAnswerFormat]
  final Step questionStep;

  /// [DateQuestionResult] which boxes the result
  final StepResult? result;

  const DateAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _DateAnswerViewState createState() => _DateAnswerViewState();
}

class _DateAnswerViewState extends State<DateAnswerView>
    with MeasureDateStateMixin, AnswerMixin<DateAnswerView, DateTime> {
  final DateFormat _dateFormat = DateFormat('E, MMM d');
  late DateAnswerFormat _dateAnswerFormat;
  DateTime? _result;

  @override
  void initState() {
    super.initState();
    _dateAnswerFormat = widget.questionStep.answerFormat! as DateAnswerFormat;
    _result =
        widget.result?.result as DateTime? ?? _dateAnswerFormat.defaultDate;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onValidationChanged = isValid(_result);
    });
    super.didChangeDependencies();
  }

  @override
  bool isValid(dynamic result) {
    return !widget.questionStep.isMandatory || result != null;
  }

  @override
  void onChange(DateTime? result) {
    setState(() {
      _result = result!;
    });
    super.onChange(result);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Theme.of(context).platform == TargetPlatform.iOS)
          _iosDatePicker()
        else
          _androidDatePicker(),
      ],
    );
  }

  Widget _androidDatePicker() {
    final questionText = widget.questionStep.answerFormat?.question;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 80.0,
              ),
              Positioned(
                left: 8.0,
                bottom: 8.0,
                child: Text(
                  _dateFormat.format(_result ?? DateTime.now()),
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 300.0,
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              firstDate: _dateAnswerFormat.minDate,
              lastDate: _dateAnswerFormat.maxDate,
              dayTextStyle: Theme.of(context).textTheme.titleMedium,
              dynamicCalendarRows: true,
              daySplashColor: Colors.transparent,
              selectedDayTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
              disabledDayTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
              todayTextStyle: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            value: [_result],
            onValueChanged: (value) => onChange(value.first),
            onDisplayedMonthChanged: onChange,
          ),
        ),
      ],
    );
  }

  Widget _iosDatePicker() {
    final questionText = widget.questionStep.answerFormat?.question;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        Container(
          width: double.infinity,
          height: 300,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            minimumDate: _dateAnswerFormat.minDate,
            //We have to add an hour to to met the assert maxDate > initDate
            maximumDate: _dateAnswerFormat.maxDate?.add(
                  const Duration(hours: 1),
                ) ??
                DateTime.now().add(
                  const Duration(hours: 1),
                ),
            initialDateTime: _dateAnswerFormat.defaultDate,
            onDateTimeChanged: onChange,
          ),
        ),
      ],
    );
  }
}
