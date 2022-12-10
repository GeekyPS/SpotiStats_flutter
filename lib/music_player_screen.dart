import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spotify_sdk/models/connection_status.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import 'widgets/sized_icon_button.dart';


class MusicPlayerScreen extends StatefulWidget {
  final String spotifyUri;
  MusicPlayerScreen({required this.spotifyUri});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  bool _loading = false;
  bool _connected = false;
  late ImageUri? currentTrackImageUri;

  @override
  void initState() {
    connectToSpotifyRemoteAndPlaySong(widget.spotifyUri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectionStatus>(
        stream: SpotifySdk.subscribeConnectionStatus(),
        builder: (context, snapshot) {
          _connected = false;
          var data = snapshot.data;
          if (data != null) {
            _connected = data.connected;
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('SpotiStats Player'),
              actions: [
                _connected
                    ? IconButton(
                  onPressed: disconnect,
                  icon: const Icon(Icons.exit_to_app),
                )
                    : Container(),
              ],
            ),
            body: _bodyWidget(context),
            bottomNavigationBar: _connected ? _buildBottomBar(context) : null,
          );
        },
      );
  }

  Widget _buildBottomBar(BuildContext context) {
    return BottomAppBar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedIconButton(
                width: 50,
                onPressed: () => checkIfAppIsActive(context),
                icon: Icons.info,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bodyWidget(BuildContext context2) {
    return Stack(
      children: [
        _connected
       ?  ListView(
          padding: const EdgeInsets.all(8),
          children: [
            const Divider(),
            _buildPlayerStateWidget(),
            const Divider()
          ],
        )
        : Center(child: ElevatedButton(onPressed: ()=> connectToSpotifyRemoteAndPlaySong(widget.spotifyUri), child: Text("Connect To Spotify Remote"),),),
        _loading
            ? Container(
            color: Colors.black12,
            child: const Center(child: CircularProgressIndicator()))
            : const SizedBox(),
      ],
    );
  }

  Widget _buildPlayerStateWidget() {
    return StreamBuilder<PlayerState>(
      stream: SpotifySdk.subscribePlayerState(),
      builder: (BuildContext context, AsyncSnapshot<PlayerState> snapshot) {
        var track = snapshot.data?.track;
        currentTrackImageUri = track?.imageUri;
        var playerState = snapshot.data;

        if (playerState == null || track == null) {
          return Center(
            child: Container(),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _connected
                ? spotifyImageWidget(track.imageUri)
                : const Text('Connect to see an image...'),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedIconButton(
                  width: 50,
                  icon: Icons.skip_previous,
                  onPressed: skipPrevious,
                ),
                playerState.isPaused
                    ? SizedIconButton(
                  width: 50,
                  icon: Icons.play_arrow,
                  onPressed: resume,
                )
                    : SizedIconButton(
                  width: 50,
                  icon: Icons.pause,
                  onPressed: pause,
                ),
                SizedIconButton(
                  width: 50,
                  icon: Icons.skip_next,
                  onPressed: skipNext,
                ),
              ],
            ),
            const Divider()
          ],
        );
      },
    );
  }

  Widget spotifyImageWidget(ImageUri image) {
    return FutureBuilder(
        future: SpotifySdk.getImage(
          imageUri: image,
          dimension: ImageDimension.large,
        ),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return Image.memory(snapshot.data!);
          } else if (snapshot.hasError) {
            setStatus(snapshot.error.toString());
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Error getting image')),
            );
          } else {
            return SizedBox(
              width: ImageDimension.large.value.toDouble(),
              height: ImageDimension.large.value.toDouble(),
              child: const Center(child: Text('Getting image...')),
            );
          }
        });
  }

  Future<void> disconnect() async {
    try {
      pause();
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.disconnect();
      setStatus(result ? 'disconnect successful' : 'disconnect failed');
      setState(() {
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future<void> connectToSpotifyRemoteAndPlaySong(String spotifyUri) async {
    try {
      setState(() {
        _loading = true;
      });
      var result = await SpotifySdk.connectToSpotifyRemote(
          //TODO: Add your Spotify Client ID and use the redirectURl mentioned below in Spotify App Admin Settings
          clientId: "CLIENT ID HERE",
          redirectUrl: "http://localhost/");
      setStatus(result
          ? 'connect to spotify successful'
          : 'connect to spotify failed');
      setState(() {
        _loading = false;
      });
      await SpotifySdk.play(spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      setState(() {
        _loading = false;
      });
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setState(() {
        _loading = false;
      });
      setStatus('not implemented');
    }
  }

  Future getPlayerState() async {
    try {
      return await SpotifySdk.getPlayerState();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }


  Future<void> play(String spotifyUri) async {
    try {
      await SpotifySdk.play(spotifyUri: spotifyUri);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  Future<void> checkIfAppIsActive(BuildContext context) async {
    try {
      var isActive = await SpotifySdk.isSpotifyAppActive;
      final snackBar = SnackBar(
          content: Text(isActive
              ? 'Spotify app connection is active (currently playing)'
              : 'Spotify app connection is not active (currently not playing)'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on PlatformException catch (e) {
      setStatus(e.code, message: e.message);
    } on MissingPluginException {
      setStatus('not implemented');
    }
  }

  void setStatus(String code, {String? message}) {
    var text = message ?? '';
    debugPrint('$code$text');
  }
}