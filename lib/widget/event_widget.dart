import 'package:flutter/material.dart';
import 'package:flutter_pustack/common/app_colors.dart';
import 'package:flutter_pustack/model/live_session/live_session_model.dart';
import 'package:google_fonts/google_fonts.dart';

class EventWidget extends StatelessWidget {
  final LiveSessionModel _liveSessionModel;
  final bool isLightTheme;

  EventWidget(this._liveSessionModel, {Key? key, this.isLightTheme = false})
      : super(key: key);

  /// This method return bool value
  /// For indicate current session was live or not
  bool isLiveSession() {
    return _liveSessionModel.startTime.month == DateTime.now().month &&
        _liveSessionModel.startTime.day == DateTime.now().day &&
        _liveSessionModel.startTime.hour == DateTime.now().hour;
  }

  @override
  Widget build(BuildContext context) {
    bool isLive = isLiveSession();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isLightTheme
                ? AppColors.calenderHoursLightBG
                : AppColors.calenderHoursLightBG.withOpacity(0.1),
            width: 2),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _liveSessionModel.subject!.toUpperCase(),
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: isLive
                              ? AppColors.liveColor
                              : AppColors.gryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      _liveSessionModel.chapter!,
                      // "Classification of Elements in Periodic Table",
                      style: TextStyle(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          fontWeight: FontWeight.bold,
                          color:
                              isLightTheme ? AppColors.black : AppColors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        if (isLive) ...{
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.liveColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 1),
                            child: Text(
                              _liveSessionModel.sessionStatus!,
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                letterSpacing: 0.5,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        },
                        Text(
                          "Lesson 1 " +
                              (!isLive
                                  ? "~ ${_liveSessionModel.sessionStatus}"
                                  : ""),
                          style: TextStyle(
                            color: AppColors.gryTextColor,
                            fontSize: 13,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isLive
                      ? AppColors.liveColor.withOpacity(0.3)
                      : AppColors.circleBG,
                ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isLive ? AppColors.liveColor : AppColors.circleBG,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
          /*SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: Image.asset(
                  model.teacherImage!,
                  fit: BoxFit.cover,
                ).image,
                radius: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${model.teacherName}",
                style: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: isLightTheme ? AppColors.black : AppColors.white,
                ),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
