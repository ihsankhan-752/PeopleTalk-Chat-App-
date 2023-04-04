import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var auth = FirebaseAuth.instance;
var currentUser = FirebaseAuth.instance.currentUser;
var userUid = FirebaseAuth.instance.currentUser!.uid;
var fireStore = FirebaseFirestore.instance;
