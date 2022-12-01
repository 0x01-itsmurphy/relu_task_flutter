import 'dart:async';

import 'package:relu_task_flutter/Retrofit/api_handler.dart';
import 'package:relu_task_flutter/main_utils.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart';

class MusicListRepository {
  ApiHandler apiHandler = ApiHandler();
  Future<MusicListModel> fetchMusicListData() async {
    final response =
        await apiHandler.get("chart.tracks.get?apikey=${MainUtils.apiKey}");
    return MusicListModel.fromJson(response);
  }
}
