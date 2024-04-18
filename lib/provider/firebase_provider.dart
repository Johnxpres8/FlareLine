import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flareline/entity/user_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseProvider extends ChangeNotifier {
  FirebaseProvider() {
    init();
  }

  final box = GetStorage();

  void init() {

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('authStateChanges User is currently signed out!');
      } else {
        print('authStateChanges User is signed in!');
      }
    });

    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        print('idTokenChanges User is currently signed out!');
      } else {
        print('idTokenChanges User is signed in!');
      }
    });

    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  Future<UserCredential> signInWithGithub() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(githubProvider);
  }

  Future<UserEntity> login(User user) async {
    UserEntity? userEntity = await generateUserEntity(user);
    userEntity.token = user.refreshToken;
    return userEntity;
  }

  Future<UserEntity> generateUserEntity(User user) async {
    UserEntity userEntity = UserEntity();
    userEntity.uid = Uuid().v1();
    userEntity.email = user.email ?? '';
    userEntity.avatar = user.photoURL;
    userEntity.displayName = user.displayName;
    userEntity.phoneNumber = user.phoneNumber;
    userEntity.platformUid = user.providerData.first.uid;
    userEntity.platform = user.providerData.first.providerId;
    userEntity.token = user.refreshToken;
    return userEntity;
  }

}