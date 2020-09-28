import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  static const String id = "player_screen";
  final String title;
  final String imageUrl;
  final String audioUrl;

  PlayerScreen({
    Key key,
    this.title,
    this.imageUrl,
    this.audioUrl,
  }) : super(key: key);

  AudioPlayer player = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
            player.stop();
          },
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Image(
            image: NetworkImage(imageUrl),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    player.play(audioUrl);
                  }),
              IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () {
                    player.pause();
                  }),
              IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    player.stop();
                  })
            ],
          ),
        ],
      )),
    );
  }
}
