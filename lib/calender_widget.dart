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
  final bool displayCurrentTimeline;

  CalenderWidget(
      {Key? key,
      this.eventCartWidget,
      this.eventDateWidget,
      required this.list,
      this.padding = const EdgeInsets.all(0),
      this.isLightTheme = false,
      this.physics,
      this.displayCurrentTimeline = false})
      : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  final GlobalKey _globalKey = GlobalKey();
  DateTime _currentTime = DateTime.now();
  double _containerHeight = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              if (i != 0 && i != widget.list.keys.length - 1) {
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
                        crossAxisAlignment:
                            /*widget.list[key] != null
                            ? CrossAxisAlignment.start
                            :*/
                            CrossAxisAlignment.start,
                        children: [
                          widget.eventDateWidget!(
                              context, _key, widget.list[_key])!,
                          widget.eventCartWidget!(
                              context, _key, widget.list[_key])!,
                        ],
                      ),
                    ),
                    if (_showCurrentTime && widget.displayCurrentTimeline) ...{
                      Positioned(
                        top: _currentTime.minute - _key.minute == 0
                            ? (widget.list[_key] != null ? 0 : 0)
                            : ((_containerHeight *
                                        (_currentTime.minute -
                                            widget.list.keys
                                                .toList()[i]
                                                .minute)) /
                                    _timeDiffInMinutes) +
                                (widget.list[_key] != null ? -1 : -1),
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
