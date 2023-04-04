import 'package:flutter/material.dart';
import 'package:peopletalk/screens/dashboard/home/minor_screens/group_view.dart';
import 'package:peopletalk/screens/dashboard/home/minor_screens/status_view.dart';

import '../minor_screens/chat_view.dart';

class ChatGroupCallCondition extends StatefulWidget {
  @override
  State<ChatGroupCallCondition> createState() => _ChatGroupCallConditionState();
}

class _ChatGroupCallConditionState extends State<ChatGroupCallCondition> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Chats",
                      style: TextStyle(fontWeight: _currentIndex == 0 ? FontWeight.bold : FontWeight.normal),
                    ),
                    SizedBox(height: 3),
                    Container(
                      height: _currentIndex == 0 ? 3 : 0,
                      width: _currentIndex == 0 ? 80 : 0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.purple,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Groups",
                      style: TextStyle(fontWeight: _currentIndex == 1 ? FontWeight.bold : FontWeight.normal),
                    ),
                    SizedBox(height: 3),
                    Container(
                      height: _currentIndex == 1 ? 3 : 0,
                      width: _currentIndex == 1 ? 80 : 0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.purple,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(fontWeight: _currentIndex == 2 ? FontWeight.bold : FontWeight.normal),
                    ),
                    SizedBox(height: 3),
                    Container(
                      height: _currentIndex == 2 ? 3 : 0,
                      width: _currentIndex == 2 ? 80 : 0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.purple,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_currentIndex == 0) ChatView(),
          if (_currentIndex == 1) GroupView(),
          if (_currentIndex == 2) StatusView(),
        ],
      ),
    );
  }
}
