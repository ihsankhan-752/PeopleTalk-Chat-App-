import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peopletalk/screens/friends/friends.dart';
import 'package:peopletalk/screens/friends/suggestions.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/utils/text_styles.dart';

import '../../../../controllers/auth_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../../widgets/navigations.dart';
import '../../../chat/group_chat/invite_user_for_group_chat.dart';
import '../../../friends/requests.dart';
import '../../../friends/widgets/custom_list_tile.dart';
import 'list_tile_trailing_image.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({Key? key}) : super(key: key);

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  int requestLength = 0;
  List userList = [];
  List frndList = [];
  String username = '';
  String userImage = '';
  String bio = '';

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
    username = userSnap['username'];
    userImage = userSnap['image'];
    bio = userSnap['bio'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            color: Colors.deepOrange.withOpacity(0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 35, backgroundImage: NetworkImage(userImage)),
                SizedBox(height: 3),
                Text(
                  username,
                  style: AppTextStyle().BASIC_STYLE.copyWith(
                        fontSize: 22,
                      ),
                ),
                SizedBox(height: 3),
                Text(
                  bio,
                  style: TextStyle(
                    color: AppColors.PRIMARY_BLACK,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
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
                ),
              );
            },
            title: 'Friends',
            widget: DrawerListTileImage(image: 'frnd_list'),
          ),
          CustomListTile(
            onPressed: () {
              Navigator.of(context).pop();
              navigateWithPush(
                context,
                InviteUserForGroupChat(
                  frndList: frndList,
                ),
              );
            },
            title: 'Create Group',
            widget: Icon(Icons.group),
          ),
          CustomListTile(title: 'Profile', widget: Icon(FontAwesomeIcons.person, color: AppColors.SKY)),
          CustomListTile(title: 'Language', widget: Icon(FontAwesomeIcons.language, color: AppColors.SKY)),
          CustomListTile(
              onPressed: () {
                CustomDialogs().showCustomAlertDialog(
                    context: context,
                    title: "Wait",
                    content: "Do you want to LogOut?",
                    onNegativeTapped: () {
                      Navigator.of(context).pop();
                    },
                    onPositiveTapped: () {
                      Navigator.of(context).pop();
                      AuthController().signOut(context);
                    });
              },
              title: 'LogOut',
              widget: Icon(
                FontAwesomeIcons.signOut,
                color: AppColors.SKY,
              )),
        ],
      ),
    );
  }
}
