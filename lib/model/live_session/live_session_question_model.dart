class LiveSessionQuestionModel {
  String? questionId;
  List<String>? options;
  String? questionType;
  String? statement;
  DateTime? updateTs;
  LiveSessionQuestionModel({
    this.updateTs,
    this.questionId,
    this.options,
    this.questionType,
    this.statement,
  });
}

class PreSessionQuestionModel extends LiveSessionQuestionModel {
  PreSessionQuestionModel({
    questionId,
    options,
    questionType,
    statement,
    updateTs,
  }) : super(
          updateTs: updateTs,
          questionId: questionId,
          options: options,
          questionType: questionType,
          statement: statement,
        );
}

class InSessionQuestionModel extends LiveSessionQuestionModel {
  int? answerIndex;
  int? duration;
  String? questionStatus;
  DateTime? deployTime;
  InSessionQuestionModel({
    this.answerIndex,
    this.duration,
    this.questionStatus,
    this.deployTime,
    options,
    questionType,
    statement,
    questionId,
    updateTs,
  }) : super(
          updateTs: updateTs,
          questionId: questionId,
          options: options,
          questionType: questionType,
          statement: statement,
        );
}
