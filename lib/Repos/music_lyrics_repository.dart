import 'dart:async';
import 'package:relu_task_flutter/Retrofit/api_handler.dart';
import 'package:relu_task_flutter/main_utils.dart';
import 'package:relu_task_flutter/Models/music_lyrics_model.dart';

class MusicLyricsRepository {
  final int trackId;
  MusicLyricsRepository({required this.trackId});
  ApiHandler apiHandler = ApiHandler();
  Future<MusicLyricsModel> fetchMusicDetailsData() async {
    final response = await apiHandler
        .get("track.lyrics.get?track_id=$trackId&apikey=${MainUtils.apiKey}");
    return MusicLyricsModel.fromJson(response);
  }
}
