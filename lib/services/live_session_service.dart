import 'package:flutter_pustack/model/live_session/live_session_model.dart';

class LiveSessionService {
  /*
  * _list is List<LiveSessionModel> list
  * This method convert list in map Map<DateTime, LiveSessionModel?>
  * witch use in Widget for display
  * */
  Map<DateTime, LiveSessionModel?> generateCalendarList(
      List<LiveSessionModel> _list) {
    DateTime _currentTime = DateTime.now();
    Map<DateTime, LiveSessionModel?> _liveSessionModelList = Map();
    if (_list.isEmpty) {
      _liveSessionModelList[DateTime(
        _currentTime.year,
        _currentTime.month,
        _currentTime.day,
        1,
      )] = null;
      _liveSessionModelList[DateTime(
        _currentTime.year,
        _currentTime.month,
        _currentTime.day,
        24,
      )] = null;
    }
    for (int i = 0; i < _list.length; i++) {
      var model = _list[i];
      if (i == 0 && model.startTime.hour - 1 > 1) {
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          1,
        )] = null;
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
      if (model.startTime.hour != 24)
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          (model.startTime.hour + 1),
        )] = null;
      if (i == _list.length - 1 && model.startTime.hour + 1 < 24) {
        _liveSessionModelList[DateTime(
          model.startTime.year,
          model.startTime.month,
          model.startTime.day,
          24,
        )] = null;
      }
    }
    return _liveSessionModelList;
  }
}
