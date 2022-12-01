import 'dart:async';
import 'package:relu_task_flutter/Retrofit/network_response.dart';
import 'package:relu_task_flutter/Models/music_details_model.dart';
import 'package:relu_task_flutter/repos/music_details_repository.dart';

class MusicDetailsBloc {
  late MusicDetailsRepository _musicDetailsRepository;
  late StreamController<Response<MusicDetailsModel>> _musicDetailsController;
  int trackId;
  StreamSink<Response<MusicDetailsModel>> get musicDetailsSink =>
      _musicDetailsController.sink;

  Stream<Response<MusicDetailsModel>>? get musicDetailsStream =>
      _musicDetailsController.stream;

  MusicDetailsBloc({required this.trackId}) {
    _musicDetailsController =
        StreamController<Response<MusicDetailsModel>>.broadcast();
    _musicDetailsRepository = MusicDetailsRepository(trackId: trackId);
  }

  fetchMusicDetails() async {
    musicDetailsSink.add(Response.loading('Loading details.. '));
    try {
      MusicDetailsModel musicDetails =
          await _musicDetailsRepository.fetchMusicDetailsData();
      musicDetailsSink.add(Response.completed(musicDetails));
    } catch (e) {
      musicDetailsSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicDetailsController.close();
  }
}
