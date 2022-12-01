import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:relu_task_flutter/Blocs/connectivity_bloc.dart';
import 'package:relu_task_flutter/Blocs/music_details_bloc.dart';
import 'package:relu_task_flutter/Blocs/music_lyrics_bloc.dart';
import 'package:relu_task_flutter/Models/music_details_model.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart' as ListTrack;
import 'package:relu_task_flutter/Retrofit/network_response.dart';
import 'package:relu_task_flutter/Screens/widgets/loading_widget.dart';
import 'package:relu_task_flutter/Screens/widgets/track_details_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackDetailsScreen extends StatefulWidget {
  final ListTrack.Track trackCurrent;
  const TrackDetailsScreen({required this.trackCurrent});
  @override
  _TrackDetailsScreenState createState() => _TrackDetailsScreenState();
}

class _TrackDetailsScreenState extends State<TrackDetailsScreen> {
  late ConnectivityBloc _netBloc;
  late MusicDetailsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _netBloc = ConnectivityBloc();
    _bloc = MusicDetailsBloc(trackId: widget.trackCurrent.trackId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: TrackDetailsAppBar(
          track: widget.trackCurrent,
        ),
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: _netBloc.connectivityResultStream.asBroadcastStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data) {
                case ConnectivityResult.mobile:
                case ConnectivityResult.wifi:
                  _bloc.fetchMusicDetails();
                  return RefreshIndicator(
                    onRefresh: () => _bloc.fetchMusicDetails(),
                    child: StreamBuilder<Response<MusicDetailsModel>>(
                      stream: _bloc.musicDetailsStream!.asBroadcastStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data!.status) {
                            case Status.LOADING:
                              return LoadingWidget(
                                loadingMessage: snapshot.data!.message!,
                              );
                            case Status.COMPLETED:
                              return TrackDetails(
                                musicDetails: snapshot.data!.data!,
                                trackId: widget.trackCurrent.trackId!,
                              );
                            case Status.ERROR:
                              return const Text('Errror');

                            default:
                          }
                        }
                        return const LoadingWidget(
                          loadingMessage: 'Connecting',
                        );
                      },
                    ),
                  );

                case ConnectivityResult.none:
                  return const Center(
                    child: Text('No internet'),
                  );
                default:
              }
            }
            return const Text('Check Connectivity object');
          }),
    );
  }

  @override
  void dispose() {
    _netBloc.dispose();
    _bloc.dispose();
    super.dispose();
  }
}

class TrackDetails extends StatefulWidget {
  final MusicDetailsModel musicDetails;
  final int trackId;
  const TrackDetails(
      {super.key, required this.musicDetails, required this.trackId});

  @override
  _TrackDetailsState createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  late MusicLyricsBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = MusicLyricsBloc(trackId: widget.trackId);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Track track = widget.musicDetails.message!.body!.track!;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            LyricsContainer(
              heading: 'Name',
              body: track.trackName!,
            ),
            LyricsContainer(
              heading: 'Artist',
              body: track.artistName!,
            ),
            LyricsContainer(
              heading: 'Album Name',
              body: track.albumName!,
            ),
            LyricsContainer(
              heading: 'Rating ⭐',
              body: track.trackRating.toString(),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<dynamic>(
                stream: _bloc.musicLyricsStream.asBroadcastStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data!.status) {
                      case Status.LOADING:
                        return LoadingWidget(
                          loadingMessage: snapshot.data!.message!,
                        );
                      case Status.COMPLETED:
                        return Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(148, 255, 225, 223),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Lyrics',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 26),
                              ),
                              LyricsContainer(
                                heading: '',
                                body: snapshot.data!.data!.message!.body!
                                    .lyrics!.lyricsBody!,
                              ),
                            ],
                          ),
                        );
                      case Status.ERROR:
                        break;

                      default:
                    }
                  }
                  return const LoadingWidget(
                    loadingMessage: 'Loading',
                  );
                })
          ],
        ),
      ),
    );
  }
}

class LyricsContainer extends StatelessWidget {
  final String heading;
  final String body;
  const LyricsContainer({super.key, required this.heading, required this.body});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(148, 255, 225, 223),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 15.0,
          ),
          Text(
            heading,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          Text(
            body,
            style: const TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
