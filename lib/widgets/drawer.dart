import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myportfolio/bloc/user_bloc.dart';

import '../projects.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _userBloc.state.user != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:16.0,vertical:24),
                child: CircleAvatar(
                  backgroundImage: AssetImage(_userBloc.state.user.avatarUrl),
                  radius: 60.0,
                ),
              ),
              ListTile(
                title: Text(
                  "Shubham Jain",
                  style: TextStyle(fontSize: 20.0),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _userBloc.state.user.drawerDesc,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: ListTile(
                  leading: Icon(Icons.library_books),
                  title: Text(
                    "Work Samples",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w100,
                        color: Color.fromARGB(255, 50, 50, 60)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => UserBloc()
                          ..add(FetchProfile(userId: "sjain251298@gmail.com")),
                        child: Projects(user: _userBloc.state.user),
                      );
                    }));
                  },
                ),
              )
            ],
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
