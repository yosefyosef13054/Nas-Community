import 'package:flutter/foundation.dart';
import 'package:nas_academy/core/modules/trainer_booking/trainer_booking.dart';

class TrainerProvider extends ChangeNotifier {
  TrainerBooking? _booking;

  TrainerBooking? get booking => _booking;

  set setBooking(TrainerBooking value) {
    _booking = value;
    notifyListeners();
  }



}