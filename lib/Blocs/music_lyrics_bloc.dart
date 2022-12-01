import 'dart:async';

import 'package:flutter/material.dart';
import 'package:relu_task_flutter/Retrofit/network_response.dart';
import 'package:relu_task_flutter/Models/music_lyrics_model.dart';
import 'package:relu_task_flutter/repos/music_lyrics_repository.dart';

class MusicLyricsBloc {
  late MusicLyricsRepository _musicLyricsRepository;
  late StreamController<Response<MusicLyricsModel>> _musicLyricsController;
  int trackId;
  StreamSink<Response<MusicLyricsModel>> get musicLyricsSink =>
      _musicLyricsController.sink;

  Stream<Response<MusicLyricsModel>> get musicLyricsStream =>
      _musicLyricsController.stream;

  MusicLyricsBloc({required this.trackId}) {
    _musicLyricsController =
        StreamController<Response<MusicLyricsModel>>.broadcast();
    _musicLyricsRepository = MusicLyricsRepository(trackId: trackId);
    fetchMusicLyrics();
  }

  fetchMusicLyrics() async {
    musicLyricsSink.add(Response.loading('Loading lyrics'));
    try {
      MusicLyricsModel musicLyrics =
          await _musicLyricsRepository.fetchMusicDetailsData();
      musicLyricsSink.add(Response.completed(musicLyrics));
    } catch (e) {
      musicLyricsSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _musicLyricsController.close();
  }
}
