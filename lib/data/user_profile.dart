import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String uid;
  final String? email;
  final String? username;
  final String? profilePicture;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserProfile({
    required this.uid,
    this.email,
    this.username,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      profilePicture: json['profilePicture'] as String?,
      createdAt: json['createdAt'] != null 
          ? (json['createdAt'] as Timestamp).toDate() 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? (json['updatedAt'] as Timestamp).toDate() 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      // createdAt and updatedAt are handled by Firestore
    };
  }

  UserProfile copyWith({
    String? uid,
    String? email,
    String? username,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isProfileComplete => username != null && username!.isNotEmpty && 
                                  profilePicture != null && profilePicture!.isNotEmpty;

  @override
  List<Object?> get props => [uid, email, username, profilePicture, createdAt, updatedAt];
}