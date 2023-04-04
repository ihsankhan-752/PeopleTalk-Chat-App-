import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/friends/requests.dart';
import 'package:peopletalk/screens/friends/suggestions.dart';

import '../../utils/constants.dart';
import '../../widgets/navigations.dart';
import '../dashboard/home/widgets/list_tile_trailing_image.dart';
import 'friends.dart';
import 'widgets/custom_list_tile.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  int requestLength = 0;
  List userList = [];
  List frndList = [];
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    DocumentSnapshot userSnap = await fireStore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    QuerySnapshot snap = await fireStore
        .collection('requests')
        .where('receiverUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("status", isEqualTo: "")
        .get();
    requestLength = snap.docs.length;
    frndList = userSnap['friendsList'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
      ),
      body: Column(
        children: [
          CustomListTile(
            onPressed: () {
              Navigator.of(context).pop();
              navigateWithPush(context, SuggestionView());
            },
            title: 'Suggestions',
            widget: DrawerListTileImage(image: 'suggestions'),
          ),
          CustomListTile(
              onPressed: () {
                Navigator.of(context).pop();
                navigateWithPush(
                  context,
                  FriendRequestView(),
                );
              },
              title: 'Requests : $requestLength',
              widget: DrawerListTileImage(image: 'request')),
          CustomListTile(
              onPressed: () {
                Navigator.of(context).pop();
                navigateWithPush(
                    context,
                    FriendView(
                      frndList: frndList,
                    ));
              },
              title: 'Friends',
              widget: DrawerListTileImage(image: 'frnd_list')),
        ],
      ),
    );
  }
}
