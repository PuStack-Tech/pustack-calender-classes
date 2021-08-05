import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pustack/common/app_colors.dart';

import 'common/utility.dart';
import 'model/live_session/live_session_model.dart';

class CalenderWidget extends StatefulWidget {
  /*
   * eventCartWidget return right side widget that display classdata card
   */
  final Widget? Function(
          BuildContext context, DateTime day, LiveSessionModel? model)?
      eventCartWidget;

  /*
   * eventCartWidget return left side widget that display hours card
   */
  final Widget? Function(
          BuildContext context, DateTime day, LiveSessionModel? model)?
      eventDateWidget;

  /*
   * controlling list physics
   */
  final ScrollPhysics? physics;

  /*
   * pass theme is light or dark
   */
  final bool isLightTheme;

  /*
   * pass map that display in timeline
   */
  final Map<DateTime, LiveSessionModel?> list;

  /*
   * Add padding in Listview
   */
  final EdgeInsets padding;

  /*
   * For display current timeline
   * if class data is current day class data pass true
   */
  final bool? displayCurrentTimeline;

  CalenderWidget(
      {Key? key,
      this.eventCartWidget,
      this.eventDateWidget,
      required this.list,
      this.padding = const EdgeInsets.all(0),
      this.isLightTheme = false,
      this.physics,
      this.displayCurrentTimeline})
      : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  final GlobalKey _globalKey = GlobalKey();
  DateTime _currentTime = DateTime.now();
  double _containerHeight = 0.0;
  late bool _displayCurrentTimeline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.displayCurrentTimeline != null) {
      _displayCurrentTimeline = widget.displayCurrentTimeline!;
    } else {
      _displayCurrentTimeline = Utility.isToday(widget.list.keys.first);
    }

    ///
    Timer.periodic(Duration(minutes: 1), (Timer t) {
      setState(() {});
    });

    /// This callback user for get classes event card height
    /// so we display red current timeline
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _containerHeight = _globalKey.currentContext!.size!.height;
      print('the new height is $_containerHeight');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _currentTime = DateTime.now();
    // _currentTime = DateTime(
    //     DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 30);
    return Stack(
      children: [
        ListView.builder(
            padding: widget.padding.copyWith(top: 10),
            shrinkWrap: true,
            itemCount: widget.list.length,
            physics: widget.physics,
            itemBuilder: (context, i) {
              var _key = widget.list.keys.toList()[i];
              var _showCurrentTime = false;
              var _timeDiffInMinutes = 0;
              if (i != widget.list.keys.length - 1) {
                var nextKey = widget.list.keys.toList()[i + 1];
                _timeDiffInMinutes =
                    Utility.findDifferenceInMinutes(_key, nextKey);

                _showCurrentTime =
                    Utility.findDifferenceInMinutes(_currentTime, _key)
                            .isNegative &&
                        !Utility.findDifferenceInMinutes(_currentTime, nextKey)
                            .isNegative;

                if (_key.hour == _currentTime.hour &&
                    _key.minute == _currentTime.minute) {
                  _showCurrentTime = true;
                }
                if (nextKey.hour == _currentTime.hour &&
                    nextKey.minute == _currentTime.minute) {
                  _showCurrentTime = false;
                }
                print("${_timeDiffInMinutes}");
                print("${_showCurrentTime}");
                print("========== ");
              }
              return Container(
                key: _showCurrentTime ? _globalKey : null,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: widget.list[_key] != null
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        children: [
                          widget.eventDateWidget!(
                              context, _key, widget.list[_key])!,
                          widget.eventCartWidget!(
                              context, _key, widget.list[_key])!,
                        ],
                      ),
                    ),
                    if (_showCurrentTime && _displayCurrentTimeline) ...{
                      Positioned(
                        top: ((_containerHeight - 10) *
                                    Utility.findDifferenceInMinutes(
                                        _key, _currentTime)) /
                                _timeDiffInMinutes +
                            (widget.list[_key] != null ? -5 : -0),
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              margin: EdgeInsets.only(left: 15),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.liveColor,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.liveColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    }
                  ],
                ),
              );
            }),

        /// Show fade-in and fade-out effect while list scroll
        Positioned(
          top: 0,
          left: MediaQuery.of(context).size.width / 6,
          width: MediaQuery.of(context).size.width,
          height: 10,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              //this determines the blur in the x and y directions best to keep to relitivly low numbers
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(
                          0.2), //This controls the darkness of the bar
                      Colors.black.withOpacity(0),
                    ],
                    // stops: [0, 1], if you want to adjust the gradiet this is where you would do it
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: MediaQuery.of(context).size.width * 0.833,
          width: MediaQuery.of(context).size.width,
          height: 30,
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.isLightTheme
                        ? AppColors.calenderHoursLightBG
                        : AppColors.calenderHoursDarkBG,
                    //This controls the darkness of the bar
                    (widget.isLightTheme
                            ? AppColors.calenderHoursLightBG
                            : AppColors.calenderHoursDarkBG)
                        .withOpacity(0),
                  ],
                  // stops: [0, 1], if you want to adjust the gradiet this is where you would do it
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
