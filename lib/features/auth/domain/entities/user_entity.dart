import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? token;

  const UserEntity({
    required this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.token,
  });

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber, token];
  
  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? token,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      token: token ?? this.token,
    );
  }
}
