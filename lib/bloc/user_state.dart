part of 'user_bloc.dart';

enum UserStateStatus {initial, success}

class UserState extends Equatable {
  final User user;
  final UserStateStatus status;
  const UserState({this.user,this.status = UserStateStatus.initial});
  @override
  List<Object> get props => [];
}
