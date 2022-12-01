import 'dart:async';
import 'package:relu_task_flutter/main_utils.dart';
import 'package:relu_task_flutter/Retrofit/api_handler.dart';
import 'package:relu_task_flutter/Models/music_details_model.dart';

class MusicDetailsRepository {
  final int trackId;
  MusicDetailsRepository({required this.trackId});
  ApiHandler apiHandler = ApiHandler();
  Future<MusicDetailsModel> fetchMusicDetailsData() async {
    final response = await apiHandler
        .get("track.get?track_id=$trackId&apikey=${MainUtils.apiKey}");
    return MusicDetailsModel.fromJson(response);
  }
}
