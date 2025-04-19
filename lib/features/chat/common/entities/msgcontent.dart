import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  final String? token;
  final String? content;
  final String? type;
  final Timestamp? addtime;

  Msgcontent({
    this.token,
    this.content,
    this.type,
    this.addtime,
  });

  factory Msgcontent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Msgcontent(
      token: data?['token'] != null ? data!['token'] as String : null,
      content: data?['content'] != null ? data!['content'] as String : null,
      type: data?['type'] != null ? data!['type'] as String : null,
      addtime: data?['addtime'] != null ? data!['addtime'] as Timestamp : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (token != null) "token": token,
      if (content != null) "content": content,
      if (type != null) "type": type,
      if (addtime != null) "addtime": addtime,
    };
  }
}
