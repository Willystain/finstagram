import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;
  final String uid;
  final String photoUrl;

  const User({
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.uid,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["userName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        'userName': name,
        'email': email,
        'image': photoUrl,
        'uid': uid,
      };
}
