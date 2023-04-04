import 'package:flutter/material.dart';
import 'package:peopletalk/screens/friends/widgets/frnds_snap_card.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/widgets/text_input.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/text_styles.dart';

class FriendView extends StatefulWidget {
  final List? frndList;
  const FriendView({Key? key, this.frndList}) : super(key: key);

  @override
  State<FriendView> createState() => _FriendViewState();
}

class _FriendViewState extends State<FriendView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Friends", style: AppTextStyle().BASIC_STYLE.copyWith(color: AppColors.PRIMARY_WHITE)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SearchTextInput(
                searchController: searchController,
                onChanged: (v) {
                  setState(() {});
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.frndList!.length,
                itemBuilder: (context, index) {
                  return StreamBuilder(
                    stream: fireStore.collection("users").doc(widget.frndList![index]).snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                      if (searchController.text.isEmpty) {
                        return FriendSnapCard(data: data);
                      } else if (data['username'].toString().toLowerCase().contains(searchController.text.toLowerCase())) {
                        return FriendSnapCard(data: data);
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
