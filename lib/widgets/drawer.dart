import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myportfolio/bloc/user_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

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
                              child: Text(
                                "Download Resume",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Please provide your name and email to ensure better engagement.",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8))),
                                    color: Colors.white,
                                    child: TextFormField(
                                      focusNode: _focusNodeName,
                                      onTap: () =>
                                          _focusNodeName.requestFocus(),
                                      controller: _nameController,
                                      enableInteractiveSelection: true,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16.0),
                                      validator: (String value) {
                                        if (value == null || value == '') {
                                          return "Please enter your name";
                                        }
                                        return null;
                                      },
                                      onSaved: (String name) {
                                        setState(() {
                                          _name = name;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.0),
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.only(
                                            top: 14.0, left: 24, bottom: 14),
                                        prefixIcon: Icon(Icons.account_circle,
                                            color: Colors.black54),
                                        errorStyle: GoogleFonts.balooBhaina(
                                            fontSize: 14),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 24.0),
                                          child: TextFormField(
                                            focusNode: _focusNode,
                                            controller: _emailController,
                                            enableInteractiveSelection: true,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            onChanged: (value) {
                                              setState(() {
                                                _emailError = false;
                                              });
                                            },
                                            validator: (String value) {
                                              if (value == null ||
                                                  value == "") {
                                                return "Please enter an email";
                                              } else if (!regex
                                                      .hasMatch(value) ||
                                                  _emailError) {
                                                return "Invalid email";
                                              }
                                              return null;
                                            },
                                            onSaved: (String email) {
                                              setState(() {
                                                _email = email;
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.0),
                                              fillColor: Colors.white,
                                              contentPadding: EdgeInsets.only(
                                                  top: 14.0,
                                                  left: 24,
                                                  bottom: 14),
                                              prefixIcon: Icon(
                                                  Icons.alternate_email,
                                                  color: Colors.black54),
                                              errorStyle:
                                                  GoogleFonts.balooBhaina(
                                                      fontSize: 14),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4,
                                          right: 0,
                                          child: _isVerifyingEmail
                                              ? Transform.scale(
                                                  scale: 0.5,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 8,
                                                    ),
                                                  ),
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.download,
                                                    size: 24,
                                                    color: Colors.blue,
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      _isVerifyingEmail = true;
                                                    });
                                                    _formKey.currentState
                                                        .save();
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _userBloc
                                                        ..add(LogEngagingUser(
                                                            name: _name,
                                                            email: _email));
                                                      html.window.open(
                                                          _userBloc.state.user
                                                              .resumeLink,
                                                          '_self');
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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

Future<bool> verifyEmail(String email) async {
  if (email == '') return false;
  String apiKey =
      "8d8becf9938726356f5f42d57fd96f9e9b014f8fd754c7b1b62d4c4a0814";
  Uri _url = Uri.https("learning2092.herokuapp.com", "/verifyEmail");
  Map<String, String> requestBody = {'email': email, 'apiKey': apiKey};
  final jsonString = json.encode(requestBody);
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
  http.Response response =
      await http.post(_url, headers: headers, body: jsonString);
  if (response.statusCode == 200) {
    var res = jsonDecode(response.body);
    if (res['result'] == "valid")
      return true;
    else
      return false;
  }
  return false;
}

void downloadFile(String url) {
  html.AnchorElement anchorElement = new html.AnchorElement(href: url);
  anchorElement.download = url;
  anchorElement.click();
}
