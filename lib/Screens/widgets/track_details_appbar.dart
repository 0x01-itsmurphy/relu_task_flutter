import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart' as ListTrack;

class TrackDetailsAppBar extends StatefulWidget {
  final ListTrack.Track track;
  const TrackDetailsAppBar({super.key, required this.track});

  @override
  _TrackDetailsAppBarState createState() => _TrackDetailsAppBarState();
}

class _TrackDetailsAppBarState extends State<TrackDetailsAppBar> {
  IconData bookmarkIcon = Icons.favorite_border;
  bool changed = false;
  void checkBookmarkStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList('bookmarkList') ?? [];
    setState(() {
      if (stringList.contains(widget.track.trackId.toString())) {
        bookmarkIcon = Icons.favorite;
      } else {
        bookmarkIcon = Icons.favorite_border_outlined;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkBookmarkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.white,
      elevation: 5.0,
      centerTitle: true,
      title: const Text(
        'Track Details',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            bookmarkIcon,
            color: Colors.redAccent,
          ),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final trackIDList = prefs.getStringList('bookmarkList') ?? [];
            final trackNameList = prefs.getStringList('nameList') ?? [];
            final trackAlbumList = prefs.getStringList('albumList') ?? [];
            final trackArtistList = prefs.getStringList('artistList') ?? [];
            setState(() {
              changed = true;
              if (bookmarkIcon == Icons.favorite_border_outlined) {
                bookmarkIcon = Icons.favorite;
                trackIDList.add(widget.track.trackId.toString());
                trackNameList.add(widget.track.trackName!);
                trackAlbumList.add(widget.track.albumName!);
                trackArtistList.add(widget.track.artistName!);
              } else {
                bookmarkIcon = Icons.favorite_border_outlined;
                if (prefs.containsKey('bookmarkList') &&
                    trackIDList.contains(widget.track.trackId.toString())) {
                  int index =
                      trackIDList.indexOf(widget.track.trackId.toString());
                  trackIDList.removeAt(index);
                  trackNameList.removeAt(index);
                  trackAlbumList.removeAt(index);
                  trackArtistList.removeAt(index);
                }
              }
              prefs.setStringList('bookmarkList', trackIDList);
              prefs.setStringList('nameList', trackNameList);
              prefs.setStringList('albumList', trackAlbumList);
              prefs.setStringList('artistList', trackArtistList);
            });
          },
        )
      ],
    );
  }
}
