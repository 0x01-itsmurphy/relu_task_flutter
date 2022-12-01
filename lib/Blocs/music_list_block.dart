import 'dart:async';
import 'package:relu_task_flutter/Retrofit/network_response.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart';
import 'package:relu_task_flutter/repos/music_list_repository.dart';

class MusicListBloc {
  late MusicListRepository? _musicListRepository;
  late StreamController<Response<MusicListModel>> _musicListController;

  StreamSink<Response<MusicListModel>>? get musicListSink =>
      _musicListController.sink;

  Stream<Response<MusicListModel>>? get musicListStream =>
      _musicListController.stream;

  MusicListBloc() {
    _musicListController =
        StreamController<Response<MusicListModel>>.broadcast();
    _musicListRepository = MusicListRepository();
    fetchMusicList();
  }

  fetchMusicList() async {
    musicListSink!.add(Response.loading('Loading list. '));
    try {
      MusicListModel musicList =
          await _musicListRepository!.fetchMusicListData();
      musicListSink!.add(Response.completed(musicList));
    } catch (e) {
      musicListSink!.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicListController.close();
  }
}
