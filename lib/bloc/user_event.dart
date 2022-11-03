part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchProfile extends UserEvent {
  final String userId;
  const FetchProfile({this.userId});
  @override
  // TODO: implement props
  List<Object> get props => [userId];
}

class LogEngagingUser extends UserEvent {
  final String name, email;
  const LogEngagingUser({this.name, this.email});
  @override
  // TODO: implement props
  List<Object> get props => [email];
}
