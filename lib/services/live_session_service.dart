import 'package:flutter_pustack/model/live_session/live_session_model.dart';

class LiveSessionService {
  /*
  * _list is List<LiveSessionModel> list
  * This method convert list in map Map<DateTime, LiveSessionModel?>
  * witch use in Widget for display
  * */
  Map<DateTime, LiveSessionModel?> generateCalendarList(
      List<LiveSessionModel> _list) {
    /// Minimum Hours to display
    int minHour = 8;

    /// Maximum Hours to display
    int maxHour = 24;

    /// modulation for time range divide
    int modulation = _list.length < 2 ? 2 : 4;

    DateTime _currentTime = DateTime.now();
    Map<DateTime, LiveSessionModel?> _liveSessionModelList = Map();
    if (_list.isEmpty) {
      for (int i = minHour; i < maxHour; i++)
        if (i % modulation == 0) {
          _liveSessionModelList[DateTime(
            _currentTime.year,
            _currentTime.month,
            _currentTime.day,
            i,
          )] = null;
        }
    }
    for (int i = 0; i < _list.length; i++) {
      var model = _list[i];
      if (i == 0 && model.startTime.hour - 1 > 1) {
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          minHour,
        )] = null;
        for (int j = minHour; j < model.startTime.hour - 1; j++) {
          if (j % modulation == 0) {
            _liveSessionModelList[DateTime(
              model.startTime.year,
              model.startTime.month,
              model.startTime.day,
              j,
            )] = null;
          }
        }
      }
      if (model.startTime.minute == 00) {
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          (model.startTime.hour - 1),
        )] = null;
      } else
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          (model.startTime.hour),
          00,
        )] = null;
      _liveSessionModelList[model.startTime] = model;
      if (model.startTime.hour != maxHour)
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          (model.startTime.hour + 1),
        )] = null;
      if (i == _list.length - 1 && model.startTime.hour + 1 < maxHour) {
        /*if (_list.length < 3) {

        }*/
        for (int j = model.startTime.hour + 1; j < maxHour; j++) {
          if (j % modulation == 0) {
            _liveSessionModelList[DateTime(
              model.startTime.year,
              model.startTime.month,
              model.startTime.day,
              j,
            )] = null;
          }
        }
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          maxHour,
        )] = null;
      }
    }
    return _liveSessionModelList;
  }
}
