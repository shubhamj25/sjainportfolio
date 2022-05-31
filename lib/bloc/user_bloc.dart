import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myportfolio/models/user.dart';
import 'package:myportfolio/repositories/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    final UserRepository repo = UserRepository();
    on<UserEvent>((event, emit) async {
      if (event is FetchProfile) {
        var response = await repo.getUserData(event.userId);
        emit(UserState(
            user: User.fromJson(response), status: UserStateStatus.success));
      } else if (event is LogEngagingUser) {
        repo.logEngagingUser(event.name, event.email);
      }
    });
  }
}
