import 'dart:io' show Platform;
import 'package:audio_player_full_flutter_course/screens/player_screen.dart';
import 'package:audio_player_full_flutter_course/services/network_services.dart';
import 'package:audio_player_full_flutter_course/utilities/result_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AudiosListScreen extends StatelessWidget {
  static const String id = "audios_list_screen";
  final String categoryId;
  final String title;

  AudiosListScreen({this.title, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text(title),
              leading: CupertinoNavigationBarBackButton(),
            )
          : AppBar(
              title: Text(title),
            ),
      body: Container(
        child: FutureBuilder(
          future: NetworkServices().getAudioFiles(
              Provider.of<ResultData>(context).userId, categoryId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator());
            } else {
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(kImagesAndAudioPathUrl +
                          snapshot.data[index].audio_image),
                    ),
                    subtitle: Text(snapshot.data[index].audio_description),
                    title: Text(snapshot.data[index].audio_name),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerScreen(
                            title: snapshot.data[index].audio_name,
                            audioUrl: kImagesAndAudioPathUrl +
                                snapshot.data[index].audio_link_1,
                            imageUrl: kImagesAndAudioPathUrl +
                                snapshot.data[index].audio_image,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
