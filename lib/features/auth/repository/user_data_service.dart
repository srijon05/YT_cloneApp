import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ytclone/features/auth/model/user_model.dart';

final userDataServiceProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance),
    );

class UserDataService{
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({
    required this.auth,
    required this.firestore,
  });

  addUserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String profilePic,
    required String descriptions,
   
  })async{
      UserModel  user = UserModel(
        displayName: displayName, 
        username: username, 
        email: email, 
        profilePic: profilePic,
        subscriptions: [], 
        videos: 0, 
        userId: auth.currentUser!.uid, 
        descriptions: descriptions, 
        type: "user",);

        await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }
  Future<UserModel> fetchCurrentUserData()async{
    final currentUserMap= 
     await firestore.collection("users").doc(auth.currentUser!.uid).get();
  UserModel user = UserModel.fromMap(currentUserMap.data()!);
  return user;   
  }
  Future<UserModel> fetchAnyUserData(userId) async {
    final currentUserMap =
        await firestore.collection("users").doc(userId).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
}