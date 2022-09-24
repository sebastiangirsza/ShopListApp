import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String? email;
  final String uid;

  const UserModel({
    required this.email,
    required this.uid,
  });

  UserModel.fromFirebase(User user)
      : email = user.email,
        uid = user.uid;
}
