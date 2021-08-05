class LiveSessionModel {
  String? sessionId;
  String? accessTier;
  int? airYear;
  int? airMonth;
  int? airDay;
  int? airHour;
  int? airMinute;
  String? category;
  String? subject;
  String? chapter;
  String? displayName;
  int? sessionDuration;
  int? videoDuration;
  bool? showLinkedChapter;
  List<int>? endColor;
  List<int>? startColor;
  String? videoType;
  String? videoLink;
  String? noteLink;
  String? sessionStatus;
  List<LiveSessionQuizModel>? liveSessionQuizzes;

  DateTime get startTime =>
      DateTime(airYear!, airMonth!, airDay!, airHour!, airMinute!);

  LiveSessionModel({
    this.sessionId,
    this.accessTier,
    this.airYear,
    this.airMonth,
    this.airDay,
    this.airHour,
    this.airMinute,
    this.category,
    this.subject,
    this.chapter,
    this.displayName,
    this.videoDuration,
    this.sessionDuration,
    this.showLinkedChapter,
    this.endColor,
    this.startColor,
    this.videoType,
    this.videoLink,
    this.noteLink,
    this.sessionStatus,
    this.liveSessionQuizzes,
  });

  List<LiveSessionModel> getList() {
    return [
      LiveSessionModel(
        subject: "Chemistry",
        sessionStatus: "Completed",
        chapter: "Classification of Elements in Periodic Table",
        airMinute: 0,
        airHour: 8,
        airDay: 5,
        airMonth: 8,
        airYear: 2021,
      ),
      /*LiveSessionModel(
        subject: "Chemistry",
        sessionStatus: "Completed",
        chapter: "Classification of Elements in Periodic Table",
        airMinute: 0,
        airHour: 10,
        airDay: 5,
        airMonth: 8,
        airYear: 2021,
      ),
      LiveSessionModel(
        subject: "Chemistry",
        sessionStatus: "Completed",
        chapter: "Classification of Elements in Periodic Table",
        airMinute: 30,
        airHour: 11,
        airDay: 5,
        airMonth: 8,
        airYear: 2021,
      ),
      LiveSessionModel(
        subject: "Chemistry",
        sessionStatus: "Completed",
        chapter: "Classification of Elements in Periodic Table",
        airMinute: 0,
        airHour: 15,
        airDay: 5,
        airMonth: 8,
        airYear: 2021,
      ),*/
    ];
  }
}

enum LiveSessionQuizStatus {
  initial,
  deployed,
  pending,
  disposed,
}

class LiveSessionQuizModel {
  LiveSessionQuizModel({
    required this.deployTs,
    required this.disposeTs,
    required this.optionCount,
    required this.answerIndex,
    required this.quizId,
    this.status,
  });

  int deployTs;
  int disposeTs;
  int optionCount;
  int answerIndex;
  String quizId;
  LiveSessionQuizStatus? status;
}
