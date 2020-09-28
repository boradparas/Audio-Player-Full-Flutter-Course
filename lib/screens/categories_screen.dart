import 'dart:io' show Platform;
import 'package:audio_player_full_flutter_course/constants.dart';
import 'package:audio_player_full_flutter_course/screens/home_screen.dart';
import 'package:audio_player_full_flutter_course/services/network_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audios_list_screen.dart';

class CategoriesScreen extends StatelessWidget {
  static const String id = "categories_screen";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          actions: [
            IconButton(
              tooltip: "Logout",
              icon: Icon(Icons.close),
              color: Colors.white,
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setBool("isLoggedin", false);
                Navigator.popAndPushNamed(context, HomeScreen.id);
              },
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: NetworkServices().getCategories("47"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator());
              } else {
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    color: Colors.black,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(kImagesAndAudioPathUrl +
                            snapshot.data[index].category_image),
                      ),
                      subtitle: Text(snapshot.data[index].category_description),
                      title: Text(snapshot.data[index].category_name),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AudiosListScreen(
                              title: snapshot.data[index].category_name,
                              categoryId: snapshot.data[index].category_id,
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
      ),
    );
  }
}
