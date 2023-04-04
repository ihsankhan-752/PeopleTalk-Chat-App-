import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? username;
  String? email;
  String? bio;
  dynamic contact;
  String? image;
  List? friendsList;
  List? blockUsers;
  List? invitations;

  UserModel({
    this.uid,
    this.bio,
    this.email,
    this.username,
    this.image,
    this.friendsList,
    this.blockUsers,
    this.contact,
    this.invitations,
  });
  factory UserModel.fromDocument(DocumentSnapshot snap) {
    return UserModel(
        uid: snap['uid'],
        bio: snap['bio'],
        username: snap['username'],
        email: snap['email'],
        image: snap['image'],
        contact: snap['contact'],
        friendsList: snap['friendsList'],
        blockUsers: snap['blockUsers'],
        invitations: snap['invitations']);
  }
}
