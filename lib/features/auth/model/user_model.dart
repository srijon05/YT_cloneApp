import 'dart:convert';

class UserModel{
  final String displayName;
  final String username;
  final String email;
  final String profilePic;
  final List<String> subscriptions;
  final int videos;
  final String userId;
  final String descriptions;
  final String type;
  UserModel({
    required this.displayName,
    required this.username,
    required this.email,
    required this.profilePic,
    required this.subscriptions,
    required this.videos,
    required this.userId,
    required this.descriptions,
    required this.type
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'displayName':displayName,
      'username':username,
      'email':email,
      'profilePic':profilePic,
      'subscriptions':subscriptions,
      'videos':videos,
      'userId':userId,
      'descriptions':descriptions,
      'type':type
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      displayName: map['displayName'] as String,
      username: map['username'] as String,
       email: map['email'] as String, 
       profilePic: map['profilePic'] as String,
       subscriptions: List<String>.from(map['subscriptions'] ?? [],
       ),
       videos: map['videos'] as int,
       userId: map['userId'] as String,
       descriptions: map['descriptions'] as String,
       type: map['type'] as String);
  }
  String toJson() => json.encode(toMap());
   
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>); 
}
