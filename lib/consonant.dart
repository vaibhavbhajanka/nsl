import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_language/video_screen.dart';

import 'models/consonant.dart';

class ConsonantScreen extends StatelessWidget {
  final String title;
  const ConsonantScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('consonants')
                .orderBy('id')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Consonant currentConsonant =
                        Consonant.fromMap(snapshot.data!.docs[index]);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => VideoScreen(
                            //             letter: currentConsonant.consonant.toString(),
                            //             // video: currentConsonant.video.toString(),
                            //             image: currentConsonant.image.toString(),
                            //           )),
                            // );
                          },
                          child: Hero(
                            tag: currentConsonant.consonant.toString(),
                            child: AspectRatio(
                              aspectRatio: 2 / 1,
                              child: CachedNetworkImage(
                                imageUrl: currentConsonant.image.toString(),
                                progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              // child: Image.network(
                              //   currentConsonant.image.toString(),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
