// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';
import 'dart:ui';

import 'package:chat_application/api/apis.dart';
import 'package:chat_application/main.dart';
import 'package:chat_application/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('WeChat', style: TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          onPressed: () async {
            await GoogleSignIn().signOut();
          },
          child: Icon(Icons.add_comment_rounded),
        ),
      ),
      body: StreamBuilder(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.docs;
            for (var i in data!) {
              log('Data : ${i.data()}');
            }
          }

          return ListView.builder(
              itemCount: 16,
              padding: EdgeInsets.only(top: mq.height * .02),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return chatUserCard();
              });
        }),
        stream: APIs.firestore.collection('users').snapshots(),
      ),
    );
  }
}
