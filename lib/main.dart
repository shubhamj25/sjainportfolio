import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myportfolio/models/user.dart';
import 'package:myportfolio/my_flutter_app_icons.dart';
import 'package:myportfolio/repositories/user_repo.dart';
import 'package:myportfolio/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/user_bloc.dart';

Future<void> main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        messagingSenderId: "211063386402",
        appId: "1:211063386402:web:655e2cd76e95a3f714357b",
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
          primarySwatch: Colors.blue,
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
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _topBar(User user) {
    return Row(
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
                  onPressed: () => launch(user.gitUrl),
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
    );
  }

  Widget _abtMyself() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          child: Material(
            elevation: 20.0,
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(5.0, 30.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                title: Text(
                  "About Myself",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
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
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
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
                      fontWeight: FontWeight.w100),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 2.0,
              width: MediaQuery.of(context).size.width * 0.95,
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
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: ListTile(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffold,
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
                      image: AssetImage(_userbloc.state.user.coverUrl),
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
                              height: 500.0,
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
                                autoplayDelay: 5000,
                                curve: Curves.easeIn,
                                autoplayDisableOnInteraction: true,
                              ),
                            ),

                            _abtMyself()
                            //PhotoCard(),
                          ],
                        ),
                        _educationalBg()
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
      child: Material(
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.user.avatarUrl),
                      radius: 80.0,
                    ),
                  ),
                  ListTile(
                    title:
                        Text("Shubham Jain", style: TextStyle(fontSize: 18.0)),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, bottom: 8.0),
                              child: Icon(Icons.email),
                            ),
                            Expanded(
                                child: Text(widget.user.email,
                                    style: TextStyle(fontSize: 16.0))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, bottom: 8.0),
                              child: Icon(Icons.phone_android),
                            ),
                            Expanded(
                                child: Text(widget.user.mobile,
                                    style: TextStyle(fontSize: 16.0))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, bottom: 8.0),
                              child: Icon(Icons.link),
                            ),
                            Expanded(
                                child: Text(
                              widget.user.gitUrl,
                              style: TextStyle(fontSize: 16.0),
                            )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8.0, bottom: 8.0),
                              child: Icon(Icons.my_location),
                            ),
                            Expanded(
                                child: Text(widget.user.address,
                                    style: TextStyle(fontSize: 16.0))),
                          ],
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
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GridView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 20.0 / 10.0, crossAxisCount: 2),
                        children: widget.skills
                            .map((skill) => Skill(skill.title, skill.level))
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
  final String name, level;

  Skill(this.name, this.level);

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
          style: TextStyle(fontSize: 16.0),
        ),
        subtitle: Text(
          "${widget.level}",
          style: TextStyle(fontSize: 14.0),
        ),
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
                  "Hobbies",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Hobbie(
                            "Coding MindSet",
                            "I am an enthusiastic programmer and have keen interest in learning new skills.",
                            Icon(
                              Icons.laptop_mac,
                              size: 25.0,
                            )),
                        Hobbie(
                            "Sport Activities",
                            "Badminton, BasketBall and Table Tennis are some of the sports which I like to play in my leisure time.",
                            Icon(
                              Icons.fitness_center,
                              size: 25.0,
                            )),
                        Hobbie(
                            "Music and Travel",
                            "I love listening pop music and exploring new destinations",
                            Icon(
                              Icons.headset,
                              size: 25.0,
                            )),
                      ],
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
  final Icon icon;

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
            style: TextStyle(fontSize: 18.0),
          ),
          subtitle: Text(
            "${widget.desc}",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
