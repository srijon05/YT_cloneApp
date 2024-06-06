import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ytclone/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({
    Key? key,
    required this.user,
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(user.profilePic),
                  ),
                ),
                Padding(
                  padding:const  EdgeInsets.only(top: 10, bottom: 4),
                  child: Text(
                    user.displayName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 9),
                  child: RichText(
                    text:TextSpan(
                      style: const TextStyle(color: Colors.blueGrey),
                      children: [
                        TextSpan(text: "${user.username}    "),
                        TextSpan(text: "${user.subscriptions.length} subscribers    "),
                        TextSpan(text: "${user.videos} videos"),
                      ],
                    ),
                  ),
                ),
      ],
    );
  }
}