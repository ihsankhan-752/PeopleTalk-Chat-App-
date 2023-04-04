import 'package:flutter/material.dart';

navigateWithName(BuildContext context, String routeName) {
  Navigator.of(context).pushNamed(routeName);
}

navigateWithPush(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}
