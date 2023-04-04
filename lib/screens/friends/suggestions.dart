import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopletalk/screens/friends/widgets/suggestion_snap_card.dart';
import 'package:peopletalk/utils/colors.dart';
import 'package:peopletalk/utils/constants.dart';
import 'package:peopletalk/utils/text_styles.dart';
import 'package:peopletalk/widgets/text_input.dart';

class SuggestionView extends StatefulWidget {
  const SuggestionView({Key? key}) : super(key: key);

  @override
  State<SuggestionView> createState() => _SuggestionViewState();
}

class _SuggestionViewState extends State<SuggestionView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Suggestions", style: AppTextStyle().BASIC_STYLE.copyWith(color: AppColors.PRIMARY_WHITE)),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: fireStore.collection('users').where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
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
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (searchController.text.isEmpty) {
                            return SuggestionSnapCard(data: snapshot.data!.docs[index]);
                          } else if (snapshot.data!.docs[index]['username']
                              .toString()
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return SuggestionSnapCard(data: snapshot.data!.docs[index]);
                          } else {
                            return SizedBox();
                          }
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}
