import 'package:flutter/material.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart';
import 'package:relu_task_flutter/Screens/track_details_screen.dart';

class TrackTileWidget extends StatelessWidget {
  final Track track;
  const TrackTileWidget({
    super.key,
    required this.track,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TrackDetailsScreen(trackCurrent: track)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: ListTile(
          leading: Image.asset(
            'assets/icons/music.png',
            height: 20,
          ),
          title: Text(
            track.trackName!,
          ),
          subtitle: Text(track.albumName!),
          trailing: Container(
            width: 110,
            child: Text(
              track.artistName!,
              softWrap: true,
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          ),
        ),
      ),
    );
  }
}
