import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/user_bloc.dart';
import 'models/certification.dart';
import 'models/user.dart';
import 'my_flutter_app_icons.dart';
import 'repositories/user_repo.dart';
import 'widgets/drawer.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        messagingSenderId: "211063386402",
        appId: "211063386402:web:655e2cd76e95a3f714357b",
        apiKey: "AIzaSyAMcapBSKjiSxJeovFQriIcS8FhuPD39vc",
        databaseURL: "https://portfolio-5e04b.firebaseio.com",
        projectId: "portfolio-5e04b"),
  );
  runApp(
    RepositoryProvider(
      create: (context) => UserRepository(),
      child: MaterialApp(
        title: "@Shubham Jain",
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shubham Jain',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "HappyMonkey",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocProvider(
          create: (context) =>
              UserBloc()..add(FetchProfile(userId: "sjain251298@gmail.com")),
          child: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserBloc _userbloc;
  final GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _userbloc = context.read<UserBloc>();
    super.initState();
  }

  Widget _textRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(
              Icons.star,
              color: Colors.grey,
            ),
          ),
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontSize: 18.0),
          )),
        ],
      ),
    );
  }

  Widget _certificateTile(Certification _certification) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage, image: _certification.icon),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                _certification.title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
              ),
              Text(
                _certification.org,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Issued on : ${_certification.issuedOn}",
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                "Credential ID : ${_certification.credential}",
                style: TextStyle(fontSize: 16.0),
              ),
              MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 10),
                onPressed: () => launch(_certification.certificateUrl),
                child: Row(
                  children: [
                    Text(
                      "Show Credential",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.open_in_new,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar(User user) {
    var _containerWidth = MediaQuery.of(context).size.width < 750
        ? MediaQuery.of(context).size.width * 0.95
        : MediaQuery.of(context).size.width * 0.85;
    return Container(
      width: _containerWidth,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: 6,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
              onPressed: () => _scaffold.currentState.openDrawer(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: 3,
                    backgroundColor: Colors.white,
                    child: Icon(
                      MyFlutterApp.github,
                      color: Colors.indigo,
                    ),
                    onPressed: () =>
                        launch("https://github.com/" + user.gitUsername),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: 4,
                    backgroundColor: Colors.white,
                    child: Icon(
                      MyFlutterApp.linkedin,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () => launch(user.linkedInUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: 5,
                    backgroundColor: Colors.white,
                    child: Icon(
                      MyFlutterApp.facebook,
                      color: Colors.black,
                    ),
                    onPressed: () => launch(user.fbUrl),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _abtMyself() {
    var _containerWidth = MediaQuery.of(context).size.width < 750
        ? MediaQuery.of(context).size.width * 0.95
        : MediaQuery.of(context).size.width * 0.85;
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
      child: Container(
          width: _containerWidth,
          child: Material(
            elevation: 20.0,
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  "About Myself",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_userbloc.state.user.bio,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w100)),
                ),
              ),
            ),
          )),
    );
  }

  Widget _educationalBg() {
    var _containerWidth = MediaQuery.of(context).size.width < 750
        ? MediaQuery.of(context).size.width * 0.95
        : MediaQuery.of(context).size.width * 0.85;
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: _containerWidth,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Educational Background",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 2.0,
              width: _containerWidth,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: _containerWidth,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        subtitle: Column(
                          children: <Widget>[
                            ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.location_city),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Schooling (2014-2015)",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ],
                                ),
                                subtitle:
                                    _textRow(_userbloc.state.user.schooling)),
                            ListTile(
                                title: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.account_balance),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Higher Secondary (2016-2017)",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w700),
                                    )),
                                  ],
                                ),
                                subtitle:
                                    _textRow(_userbloc.state.user.highSchool)),
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.school),
                                  ),
                                  Expanded(
                                      child: Text(
                                    "College (2017-2021)",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _userbloc.state.user.college
                                      .map((item) => _textRow(item))
                                      .toList()),
                            ),
                            ListTile(
                              title: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.timeline),
                                  ),
                                  Expanded(
                                      child: Text(
                                    "Career (2021 - present)",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _userbloc.state.user.career
                                      .map((item) => _textRow(item))
                                      .toList()),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ));
  }

  Widget _certifications() {
    var _containerWidth = MediaQuery.of(context).size.width < 750
        ? MediaQuery.of(context).size.width * 0.95
        : MediaQuery.of(context).size.width * 0.85;
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: _containerWidth,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Courses & Certifications",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 2.0,
              width: _containerWidth,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0)),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: _containerWidth,
                    padding: const EdgeInsets.only(top: 8),
                    child: ResponsiveGridList(
                        scroll: false,
                        shrinkWrap: true,
                        desiredItemWidth:
                            min(450, MediaQuery.of(context).size.width - 64),
                        minSpacing: 10,
                        children: _userbloc.state.user.certifications
                            .map((item) => _certificateTile(item))
                            .toList()),
                  )),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffold,
        resizeToAvoidBottomInset: true,
        drawer: Drawer(child: MyDrawer()),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.status == UserStateStatus.initial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == UserStateStatus.success) {
              return Stack(
                children: <Widget>[
                  //TopBar(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          _userbloc.state.user.coverUrl),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        _topBar(_userbloc.state.user),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 600.0,
                              child: Swiper(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: PhotoCard(
                                        user: _userbloc.state.user,
                                      ),
                                    );
                                  } else if (index == 1) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: SkillCard(
                                        skills: _userbloc.state.user.skills,
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: HobbieCard(),
                                    );
                                  }
                                },
                                pagination: SwiperPagination(),
                                viewportFraction: 0.85,
                                scale: 0.85,
                                autoplay: true,
                                autoplayDelay: 10000,
                                curve: Curves.easeIn,
                                autoplayDisableOnInteraction: true,
                                fade: 0.8,
                              ),
                            ),
                            _abtMyself(),
                          ],
                        ),
                        _educationalBg(),
                        _certifications()
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(child: Text("ERROR"));
            }
          },
        ),
      ),
    );
  }
}

class PhotoCard extends StatefulWidget {
  final User user;

  const PhotoCard({this.user});

  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<PhotoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 480,
      child: Material(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 480,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 380),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: widget.user.avatarUrl,
                                height: 160,
                                width: 160,
                                fit: BoxFit.cover)),
                        radius: 80.0,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text("Shubham Jain",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w800)),
                      subtitle: Column(
                        children: <Widget>[
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launch(
                                Uri(scheme: 'mailto', path: widget.user.email)
                                    .toString()),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(Icons.email,
                                      color: Colors.blueAccent),
                                ),
                                Expanded(
                                    child: Text(widget.user.email,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launch(
                                Uri(scheme: 'tel', path: widget.user.mobile)
                                    .toString()),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(
                                    Icons.phone_android,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                    child: Text(widget.user.mobile,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launch("https://github.com/" +
                                widget.user.gitUsername),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(
                                    MyFlutterApp.github_circled_alt2,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  widget.user.gitUsername,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                )),
                              ],
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            onTap: () => launch(widget.user.mapLink),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(
                                    Icons.my_location,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                    child: Text(widget.user.address,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(
                                    Icons.date_range,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                    child: Text(widget.user.dob,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),
                          InkWell(
                            hoverColor: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Icon(
                                    Icons.card_travel_rounded,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Expanded(
                                    child: Text("Passport available",
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkillCard extends StatefulWidget {
  final List<Skills> skills;

  const SkillCard({this.skills});

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 380,
      child: Material(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Skills",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 336.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GridView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: MediaQuery.of(context).size.width < 750
                            ? SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 20.0 / 10.0,
                                crossAxisCount: 2)
                            : SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 20.0 / 8.0,
                                crossAxisCount: 3),
                        children: widget.skills
                            .map((skill) =>
                                Skill(skill.title, skill.level, skill.logo))
                            .toList())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Skill extends StatefulWidget {
  final String name, level, logo;

  Skill(this.name, this.level, this.logo);

  @override
  _SkillState createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: ListTile(
        title: Text(
          "${widget.name}",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 750 ? 13 : 16,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          "${widget.level}",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width < 750 ? 11 : 13,
              fontWeight: FontWeight.w400),
        ),
        trailing: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.logo,
            width: MediaQuery.of(context).size.width * 0.075,
            height: MediaQuery.of(context).size.width * 0.075,
            fit: BoxFit.contain),
      ),
    );
  }
}

class HobbieCard extends StatefulWidget {
  @override
  _HobbieCardState createState() => _HobbieCardState();
}

class _HobbieCardState extends State<HobbieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 380,
      child: Material(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, bottom: 0),
                child: Text(
                  "Hobbies",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8.0),
                child: Container(
                    height: 360.0,
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: 352),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Hobbie(
                              "Coding MindSet",
                              "I am an enthusiastic programmer having keen interest in learning new skills.",
                              Image.asset('images/coder.gif',
                                  width: MediaQuery.of(context).size.width < 750
                                      ? 70
                                      : 100,
                                  height: 60,
                                  fit: BoxFit.fitWidth),
                            ),
                            Hobbie(
                              "Sport Activities",
                              "Badminton, BasketBall and Table Tennis are few sports which play in my leisure time.",
                              Image.asset('images/badminton.gif',
                                  width: MediaQuery.of(context).size.width < 750
                                      ? 70
                                      : 100,
                                  height: 60,
                                  fit: BoxFit.fill),
                            ),
                            Hobbie(
                              "Music and Travel",
                              "I love listening pop music and exploring new destinations",
                              Image.asset(
                                'images/travel.gif',
                                width: MediaQuery.of(context).size.width < 750
                                    ? 70
                                    : 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hobbie extends StatefulWidget {
  final String name, desc;
  final Widget icon;

  Hobbie(this.name, this.desc, this.icon);

  @override
  _HobbieState createState() => _HobbieState();
}

class _HobbieState extends State<Hobbie> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: ListTile(
          leading: widget.icon,
          title: Text(
            "${widget.name}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 750 ? 16 : 18,
                fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            "${widget.desc}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 750 ? 14 : 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

String formattedDate(DateTime _date) {
  return "${_date.day} / ${_date.month} / ${_date.year}";
}
