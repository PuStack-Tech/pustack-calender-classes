import 'package:flutter/material.dart';
import 'package:flutter_pustack/common/AppAssets.dart';
import 'package:flutter_pustack/common/app_colors.dart';
import 'package:flutter_pustack/widget/event_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'calender_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<DateTime, ClassModel?> list = {};
  DateTime currentTime = DateTime.now();
  DateFormat dateFormat = DateFormat("H a");
  bool isLightTheme = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getCalendarData();
  }

  getCalendarData() {
    list.clear();
    var classList = ClassModel().getList();
    if (classList.isEmpty) {
      list[DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        1,
      )] = null;
      list[DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        24,
      )] = null;
    }

    // for (var model in classList) {
    for (int i = 0; i < classList.length; i++) {
      var model = classList[i];
      if (i == 0 && model.startTime!.hour - 1 > 1) {
        list[DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          1,
        )] = null;
      }
      list[DateTime(
        currentTime.year,
        currentTime.month,
        currentTime.day,
        (model.startTime!.hour - 1),
      )] = null;
      if (model.startTime!.minute != 00)
        list[DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          (model.startTime!.hour),
          00,
        )] = null;
      list[model.startTime!] = model;
      if (model.startTime!.hour != 24)
        list[DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          (model.startTime!.hour + 1),
        )] = null;
      if (i == classList.length - 1 && model.startTime!.hour + 1 < 24) {
        list[DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          24,
        )] = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: isLightTheme
            ? AppColors.scaffoldLightColor
            : AppColors.scaffoldDarkColor,
        body: Container(
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: isLightTheme
                          ? AppColors.calenderHoursLightBG
                          : AppColors.calenderHoursDarkBG,
                    ),
                  ),
                  Expanded(flex: 5, child: SizedBox.shrink()),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  DateFormat("MMM")
                                      .format(currentTime)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    color: AppColors.gryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLightTheme = !isLightTheme;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: isLightTheme
                                        ? AppColors.circleBG
                                        : AppColors.white,
                                    foregroundColor: AppColors.transparent,
                                    child: Text(
                                      DateFormat("dd").format(currentTime),
                                      style: TextStyle(
                                        color: isLightTheme
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                child: Text(
                                                  "IIT JEE",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: isLightTheme
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 1,
                                                child: userProfile(
                                                    image: AppAssets.user3),
                                              ),
                                              Positioned(
                                                right: 20,
                                                child: userProfile(
                                                    image: AppAssets.user2),
                                              ),
                                              Positioned(
                                                right: 40,
                                                child: userProfile(
                                                    image: AppAssets.user4),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: isLightTheme
                                            ? AppColors.black
                                            : AppColors.white,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: Image.asset(
                                        isLightTheme
                                            ? AppAssets.dayCalenderBg
                                            : AppAssets.nightCalenderBg,
                                        fit: BoxFit.cover,
                                      ).image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    color: AppColors.black.withOpacity(0.3),
                                    padding: EdgeInsets.only(left: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // "Good ${currentTime.hour >= 16 ? "evening" : "morning"}, Ravi",
                                          "Good ${!isLightTheme ? "evening" : "morning"}, Ravi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: isLightTheme
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "You have ${ClassModel().getList().length} classes today",
                                          style: TextStyle(
                                              color: isLightTheme
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: CalenderWidget(
                        list: list,
                        isLightTheme: isLightTheme,
                        eventDateWidget: (context, date, model) {
                          return Expanded(
                            flex: 1,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                        color: AppColors.gryTextColor,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${DateFormat(model != null ? "h:mm" : "h a").format(date)}",
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              color: model != null
                                                  ? (isLightTheme
                                                      ? AppColors.black
                                                      : AppColors.white)
                                                  : null,
                                              fontSize:
                                                  model != null ? 16 : 14),
                                        ),
                                        if (model != null)
                                          TextSpan(
                                            text:
                                                "${DateFormat("\na").format(date)}",
                                            style: TextStyle(fontSize: 14),
                                          )
                                      ]),
                                )
                                /*Text(
                              "${DateFormat(model != null ? "hh:mm \na" : "h a").format(date)}",
                              style: TextStyle(),
                            ),*/
                                ),
                          );
                        },
                        eventCartWidget: (context, date, model) {
                          return Expanded(
                            flex: 5,
                            child: model != null
                                ? EventWidget(model, isLightTheme: isLightTheme)
                                : Divider(
                                    color: isLightTheme
                                        ? AppColors.calenderHoursLightBG
                                        : AppColors.calenderHoursLightBG
                                            .withOpacity(0.05),
                                    thickness: 2,
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfile({String? image}) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: Image.asset(
            image!,
            fit: BoxFit.cover,
          ).image,
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: isLightTheme ? AppColors.white : AppColors.scaffoldDarkColor,
        ),
      ),
    );
  }
}

class ClassModel {
  late DateTime? startTime;
  late String? subject;
  late String? topic;
  late String? lessonNumber;
  late String? status;
  late String? teacherImage;
  late String? teacherName;
  final bool isLive;
  DateTime currentTime = DateTime.now();

  ClassModel({
    this.startTime,
    this.subject,
    this.topic,
    this.lessonNumber,
    this.status,
    this.teacherImage,
    this.teacherName,
    this.isLive = false,
  });

  List<ClassModel> getList() {
    return [
      ClassModel(
        startTime: DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          10,
        ),
        subject: "Chemistry",
        status: "Completed",
        topic: "Classification of Elements in Periodic Table",
        lessonNumber: "2",
        teacherName: "Megha Patel",
        teacherImage: AppAssets.user2,
      ),
      ClassModel(
        startTime: DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          16,
          45,
        ),
        subject: "Maths",
        status: "LIVE",
        topic: "Differentiation",
        lessonNumber: "2",
        teacherName: "Praneet",
        teacherImage: AppAssets.user1,
        isLive: true,
      ),
    ];
  }
}
