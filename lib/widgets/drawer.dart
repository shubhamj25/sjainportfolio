import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../bloc/user_bloc.dart';
import '../projects.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  UserBloc _userBloc;
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email, _name;
  bool _emailError = false;
  bool _isVerifyingEmail = false;
  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNode = FocusNode();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    regex = new RegExp(pattern);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _userBloc.state.user != null
        ? Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 24),
                          child: CircleAvatar(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: _userBloc.state.user.avatarUrl,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover),
                            ),
                            radius: 60.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            "Shubham Jain",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w800),
                          ),
                        ),
                        ListTile(
                          leading: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: _userBloc.state.user.currentCompanyLogo),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              _userBloc.state.user.drawerDesc,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.w600),
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
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 50, 50, 60)),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BlocProvider(
                                  create: (context) => UserBloc()
                                    ..add(FetchProfile(
                                        userId: "sjain251298@gmail.com")),
                                  child: Projects(user: _userBloc.state.user),
                                );
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                              leading: Icon(
                                Icons.attach_file_rounded,
                                color: Colors.white,
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    _userBloc
                                      ..add(LogEngagingUser(
                                          name: _name, email: _email));
                                    html.window.open(
                                        _userBloc.state.user.resumeLink,
                                        '_self');
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Download Resume",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

// Future<bool> verifyEmail(String email) async {
//   if (email == '') return false;
//   String apiKey =
//       "8d8becf9938726356f5f42d57fd96f9e9b014f8fd754c7b1b62d4c4a0814";
//   Uri _url = Uri.https("learning2092.herokuapp.com", "/verifyEmail");
//   Map<String, String> requestBody = {'email': email, 'apiKey': apiKey};
//   final jsonString = json.encode(requestBody);
//   final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
//   http.Response response =
//       await http.post(_url, headers: headers, body: jsonString);
//   if (response.statusCode == 200) {
//     var res = jsonDecode(response.body);
//     if (res['result'] == "valid")
//       return true;
//     else
//       return false;
//   }
//   return false;
// }

void downloadFile(String url) {
  html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}
