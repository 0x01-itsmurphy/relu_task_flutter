import 'package:flutter/material.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart';
import 'package:relu_task_flutter/Screens/widgets/track_tile_widget.dart';

class TrackListWidget extends StatelessWidget {
  final MusicListModel musicList;
  const TrackListWidget({Key? key, required this.musicList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: musicList.message!.body!.trackList!.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        Track track = musicList.message!.body!.trackList![index].track!;
        return TrackTileWidget(
          track: track,
        );
      },
    );
  }
}
