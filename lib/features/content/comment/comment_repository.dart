import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ytclone/features/content/comment/comment_model.dart';
import 'package:uuid/uuid.dart';

final commentProvider = Provider(
  (ref) => CommentRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class CommentRepository {
  final FirebaseFirestore firestore;
  CommentRepository({
    required this.firestore,
  });

  Future<void> uploadCommentToFirestore({
    required String commentText,
    required String videoId,
    required String displayName,
    required String profilePic,
  }) async {
    String commentId = const Uuid().v4();
    CommentModel comment = CommentModel(
      commentText: commentText,
      videoId: videoId,
      commmentId: commentId,
      displayName: displayName,
      profilePic: profilePic,
    );
    await firestore.collection("comments").doc(commentId).set(comment.toMap());
  }
}