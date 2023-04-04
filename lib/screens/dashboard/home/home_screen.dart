import 'package:flutter/material.dart';
import 'package:peopletalk/screens/dashboard/home/widgets/chat_group_status_condition.dart';
import 'package:peopletalk/screens/dashboard/home/widgets/home_screen_drawer.dart';
import 'package:peopletalk/services/notification_services.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:peopletalk/utils/text_styles.dart';
import 'package:peopletalk/widgets/text_input.dart';

import '../../chat/one_to_one_chat/audio_call_pick_up_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    NotificationServices().getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AudioCallPickUpScreen(
      scaffold: Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        endDrawer: HomeScreenDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          elevation: 0,
          centerTitle: true,
          title: Text("People Talk", style: AppTextStyle().BASIC_STYLE),
          actions: [
            IconButton(
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.more_vert, color: AppColors.PRIMARY_BLACK),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20),
              ChatGroupCallCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
