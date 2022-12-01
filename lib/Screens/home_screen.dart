import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:relu_task_flutter/Blocs/connectivity_bloc.dart';
import 'package:relu_task_flutter/Blocs/music_list_block.dart';
import 'package:relu_task_flutter/Models/music_list_model.dart';
import 'package:relu_task_flutter/Retrofit/network_response.dart';
import 'package:relu_task_flutter/Screens/bookmark_screen.dart';
import 'package:relu_task_flutter/Screens/widgets/loading_widget.dart';
import 'package:relu_task_flutter/Screens/widgets/track_list_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityBloc _netBloc = ConnectivityBloc();
  MusicListBloc? musicListBloc = MusicListBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 5.0,
        // centerTitle: true,
        title: const Text(
          'Music List',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.favorite_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookmarkScreen()));
            },
          )
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
          stream: _netBloc.connectivityResultStream.asBroadcastStream(),
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case ConnectivityResult.mobile:
              case ConnectivityResult.wifi:
                musicListBloc!.fetchMusicList();

                return RefreshIndicator(
                  onRefresh: () => musicListBloc!.fetchMusicList(),
                  child: StreamBuilder<Response<MusicListModel>>(
                    stream: musicListBloc!.musicListStream!.asBroadcastStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return LoadingWidget(
                                loadingMessage: snapshot.data!.message!);
                          case Status.COMPLETED:
                            return TrackListWidget(
                                musicList: snapshot.data!.data!);
                          case Status.ERROR:
                            break;
                          default:
                        }
                      }
                      return LoadingWidget(loadingMessage: 'Connecting');
                    },
                  ),
                );

              case ConnectivityResult.none:
                //print('No net: ');
                return const Center(
                  child: Text('No internet'),
                );
              default:
            }
            return Container();
          }),
    );
  }

  @override
  void dispose() {
    _netBloc.dispose();
    musicListBloc!.dispose();
    super.dispose();
  }
}
