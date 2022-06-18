import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myportfolio/bloc/user_bloc.dart';
import 'package:myportfolio/code_icons.dart';
import 'package:myportfolio/constants/constants.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/project.dart';
import 'models/user.dart';

class Projects extends StatefulWidget {
  final User user;

  const Projects({Key key, this.user}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.status == UserStateStatus.initial) {
              return Center(child: CircularProgressIndicator());
            } else if (state.status == UserStateStatus.success) {
              return Stack(
                children: <Widget>[
                  //TopBar(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: CachedNetworkImageProvider(_userBloc.state.user.projectCoverUrl),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Work",
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "Samples",
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.home,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ResponsiveGridList(
                                scroll: false,
                                desiredItemWidth: 300,
                                minSpacing: 10,
                                children: _userBloc.state.user.projects
                                    .map((project) => ProjectCard(
                                          project: project,
                                        ))
                                    .toList(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Text("ERROR");
            }
          },
        ),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final int heroTag;

  ProjectCard({this.heroTag, this.project});

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  Widget _getIconFromProjectType(Project project) {
    switch (project.type) {
      case Constants.WEB:
        {
          return Icon(
            Icons.web,
            color: Colors.black,
          );
        }
      case Constants.MOBILE:
        {
          return Icon(
            Icons.phone_android,
            color: Colors.black,
          );
        }
      case Constants.CODE:
        {
          return Icon(
            Icons.code,
            color: Colors.black,
          );
        }
      case Constants.HTML:
        {
          return Icon(
            Code.html5,
            color: Colors.black,
          );
        }
      case Constants.BLOCKCHAIN:
        {
          return Icon(
            Code.bitcoin,
            color: Colors.black,
          );
        }
      case Constants.DATABASE:
        {
          return Icon(
            Code.database,
            color: Colors.black,
          );
        }
      default:
        return Icon(
          Icons.code,
          color: Colors.black,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigoAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 20.0,
      child: Container(
        width: 310.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.project.title}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                FloatingActionButton(
                  heroTag: widget.heroTag,
                  child: _getIconFromProjectType(widget.project),
                  backgroundColor: Colors.white,
                  onPressed: () {},
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.extension,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.project.category}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.project.description}",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: FloatingActionButton.extended(
                      heroTag: DateTime.now().millisecondsSinceEpoch,
                      backgroundColor: Colors.white,
                      icon: Icon(
                        Icons.link,
                        color: Colors.indigoAccent,
                      ),
                      onPressed: () => launch("${widget.project.link}"),
                      label: Text(
                        "View",
                        style: TextStyle(color: Colors.indigoAccent),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
