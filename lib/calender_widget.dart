import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pustack/common/app_colors.dart';

import 'home_page.dart';

class CalenderWidget extends StatefulWidget {
  final Widget? Function(BuildContext context, DateTime day, ClassModel? model)?
      eventCartWidget;
  final Widget? Function(BuildContext context, DateTime day, ClassModel? model)?
      eventDateWidget;
  final ScrollPhysics? physics;
  final bool isLightTheme;

  final Map<DateTime, ClassModel?> list;
  final EdgeInsets? padding;

  CalenderWidget(
      {Key? key,
      this.eventCartWidget,
      this.eventDateWidget,
      required this.list,
      this.padding,
      this.isLightTheme = false,
      this.physics})
      : super(key: key);

  @override
  _CalenderWidgetState createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: widget.padding,
          shrinkWrap: true,
          physics: widget.physics,
          children: [
            for (var key in widget.list.keys) ...{
              Container(
                child: Row(
                  crossAxisAlignment: widget.list[key] != null
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
                  children: [
                    widget.eventDateWidget!(context, key, widget.list[key])!,
                    widget.eventCartWidget!(context, key, widget.list[key])!,
                  ],
                ),
              )
            }
          ],
        ),
        // FadeEndListview(),
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

class FadeEndListview extends StatelessWidget {
  const FadeEndListview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      width: MediaQuery.of(context).size.width,
      height: 20,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [
              /*Colors.grey.withOpacity(0.3),
              Colors.grey.withOpacity(0.0),*/
            ],
          ),
        ),
      ),
    );
  }
}
