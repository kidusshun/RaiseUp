import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:raise_up/technician/technician_profile/model/technician_profile_class.dart';

// class TechnicianProfileRepo {
//   Future<List<TechnicianProfile>> getUsers() async {
//     String jsonData = await rootBundle.loadString('assets/db.json');
//     List<dynamic> jsonList = jsonDecode(jsonData)['technicians'];

//     List<TechnicianProfile> profiles = jsonList
//         .map<TechnicianProfile>((json) => TechnicianProfile.fromJson(json))
//         .toList();

//     return profiles;
//   }
// }
class TechnicianProfileRepo {
  Future<List<TechnicianProfile>> getUsers({int profileIndex = 1}) async {
    String jsonData = await rootBundle.loadString('assets/db.json');
    List<dynamic> jsonList = jsonDecode(jsonData)['technicians'];

    List<TechnicianProfile> profiles = jsonList
        .map<TechnicianProfile>((json) => TechnicianProfile.fromJson(json))
        .toList();

    if (profileIndex >= 0 && profileIndex < profiles.length) {
      return [profiles[profileIndex]];
    } else {
      return [];
    }
  }
}
