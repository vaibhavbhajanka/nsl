import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_language/video_screen.dart';

import 'models/vowel.dart';

class VowelScreen extends StatelessWidget {
  final String title;
  const VowelScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('vowels')
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
                    Vowel currentVowel =
                        Vowel.fromMap(snapshot.data!.docs[index]);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VideoScreen(
                                        letter: currentVowel.vowel.toString(),
                                        video: currentVowel.video.toString(),
                                        image: currentVowel.image.toString(),
                                      )),
                            );
                          },
                          child: Hero(
                            tag: currentVowel.vowel.toString(),
                            child: AspectRatio(
                              aspectRatio: 3/2,
                              child: Image.network(
                                currentVowel.image.toString(),
                              ),
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
