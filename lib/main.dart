
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:myportfolio/my_flutter_app_icons.dart';
import 'package:myportfolio/projects.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sjain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder> {
        '/projects': (BuildContext context) => new Projects(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffold=new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffold,
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.account_circle,size: 120.0,),
              ),
              ListTile(
                title:Text("Shubham Jain",style: TextStyle(fontSize: 20.0),),
                subtitle:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Currently Studying 3rd Year\n@Thapar University,Patiala",style: TextStyle(fontSize: 18.0),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: ListTile(
                  leading: Icon(Icons.library_books),
                  title:Text("Projects Undertaken",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100,color: Color.fromARGB(255,50,50,60)),),
                  onTap: (){
                    Navigator.pushNamed(context,'/projects');
                  },
                ),
              )
            ],
          ),
        ),
        body:Stack(
          children: <Widget>[
            //TopBar(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/scenery.png"),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: 6,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.sort,color: Colors.black,),
                          onPressed:()=> _scaffold.currentState.openDrawer(),
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
                                child: Icon(MyFlutterApp.github,color: Colors.indigo,),
                                onPressed:()=> launch("https://github.com/shubhamj25"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                heroTag: 4,
                                backgroundColor: Colors.white,
                                child: Icon(MyFlutterApp.linkedin,color: Colors.blueAccent,),
                                onPressed:()=> launch("https://www.linkedin.com/in/shubham-jain-640476189/"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FloatingActionButton(
                                heroTag: 5,
                                backgroundColor: Colors.white,
                                child: Icon(MyFlutterApp.facebook,color: Colors.black,),
                                onPressed:()=> launch("https://www.facebook.com/shubhu.2512"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 500.0,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (context,index){
                            if(index==0){
                              return  Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: PhotoCard(),
                              );
                            }
                            else if(index==1){
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0),
                                child: SkillCard(),
                              );
                            }
                            else{
                              return Padding(
                                padding:  const EdgeInsets.symmetric(vertical:8.0),
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

                      Padding(
                        padding: const EdgeInsets.only(bottom:30.0,top:30.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width*0.95,
                            child:Material(
                              elevation:20.0,
                              color: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.elliptical(5.0, 30.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ListTile(
                                  title: Text("About Myself",style:TextStyle(fontSize: 30.0,color: Colors.white),),
                                  subtitle: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Myself Shubham Jain.I am a Full Stack Developer and Currently pursuing my B-TECH from Thapar Institute of Engineering and Technology, Patiala.",style:TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w100)),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("I started building web based projects during my Sophomore year using HTML & CSS and JavaScript as Frontend and PHP as backend."
                                            "Recently I started working on Flutter with Firebase as backend.",style:TextStyle(fontSize: 18.0,fontWeight: FontWeight.w100,color: Colors.white)),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("I also did my training in the field of Blockchain Technology under National Informatics Center, MietY GOI."
                                            "\nDuring this training session I was introduced with the Hyperledger Platform using which I developed a Blockchain Powered Sample Nodejs Application.",style:TextStyle(fontSize: 18.0,color: Colors.white,fontWeight: FontWeight.w100)),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      //PhotoCard(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width:MediaQuery.of(context).size.width*0.95,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Educational Background",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                fontWeight: FontWeight.w100
                                  ),textAlign: TextAlign.center,),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 2.0,
                          width: MediaQuery.of(context).size.width*0.95,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom:16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(bottomLeft:Radius.circular(8.0) ,bottomRight: Radius.circular(8.0)),
                            ),
                            child:Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.95,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:15.0),
                                    child: ListTile(
                                      subtitle:Column(
                                      children: <Widget>[
                                        ListTile(
                                          title: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.location_city),
                                              ),
                                              Expanded(child: Text("Schooling (2014-2015)",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.w700),)),
                                            ],
                                          ),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.star,color: Colors.grey,),
                                              ),
                                              Expanded(child: Text("Matriculated from Apeejay School, Noida under CBSE Board securing 10.0 CGPA.",style: TextStyle(fontSize:18.0),)),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.account_balance),
                                              ),
                                              Expanded(child: Text("Higher Secondary (2016-2017)",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.w700),)),
                                            ],
                                          ),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.star,color: Colors.grey,),
                                              ),
                                              Expanded(child: Text("Completed 12th from Ahlcon Public School, Delhi under CBSE Board securing 95% in main subjects.",style: TextStyle(fontSize:18.0),)),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.school),
                                              ),
                                              Expanded(child: Text("College (2017-2018)",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.w700),)),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.star,color: Colors.grey,),
                                                  ),
                                                  Expanded(child: Text("Year of Joining Thapar University.",style: TextStyle(fontSize:18.0),)),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.star,color: Colors.grey,),
                                                  ),
                                                  Expanded(child: Text("In the summer of 2018 I worked as a Trainee in KEI Industries Limited where I learned about how the company details are managed.",style: TextStyle(fontSize:18.0),)),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.star,color: Colors.grey,),
                                                  ),
                                                  Expanded(child: Text("Got an Internship in Placeholderdigital Solutions Ltd. from an Internship Fair held by EDC,Thapar University.",style: TextStyle(fontSize:18.0),)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Icon(Icons.timeline),
                                              ),
                                              Expanded(child: Text("Current (2019-present)",style: TextStyle(fontSize:18.0,fontWeight: FontWeight.w700),)),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.star,color: Colors.grey,),
                                                  ),
                                                  Expanded(child: Text("Internship in NIC ,MietY during the summers where I started to explore over the field of Blockchain Technology.",style: TextStyle(fontSize:18.0),)),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.star,color: Colors.grey,),
                                                  ),
                                                  Expanded(child: Text("Currently I am studying my 6th semester.",style: TextStyle(fontSize:18.0),)),
                                                ],
                                              ),
                                            ],
                                          ),
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
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class PhotoCard extends StatefulWidget {
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
            width: MediaQuery.of(context).size.width*0.85,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/portfolio-5e04b.appspot.com/o/shubhu2.jpg?alt=media&token=24d2aeda-fcfb-4784-b84a-fb5809b7553e"),
                      radius:80.0,
                    ),
                  ),
                  ListTile(
                    title: Text("Shubham Jain",style: TextStyle(fontSize: 18.0)),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0,right:8.0,bottom:8.0),
                              child: Icon(Icons.email),
                            ),
                            Expanded(child: Text("sjain251298@gmail.com",style: TextStyle(fontSize: 16.0))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:  const EdgeInsets.only(top:8.0,right:8.0,bottom:8.0),
                              child: Icon(Icons.phone_android),
                            ),
                            Expanded(child: Text("+918558859060",style: TextStyle(fontSize: 16.0))),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:  const EdgeInsets.only(top:8.0,right:8.0,bottom:8.0),
                              child: Icon(Icons.link),
                            ),
                            Expanded(child: Text("https://github.com/shubhamj25",style: TextStyle(fontSize: 16.0),)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:  const EdgeInsets.only(top:8.0,right:8.0,bottom:8.0),
                              child: Icon(Icons.my_location),
                            ),
                            Expanded(child: Text("Vasundhara Enclave Delhi - 110096",style: TextStyle(fontSize: 16.0))),
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
                child: Text("Skills",style: TextStyle(fontSize: 22.0),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width*0.85,
                  child: GridView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 20.0/10.0,
                      crossAxisCount: 2
                    ),
                    children: <Widget>[
                      Skill("Flutter", "Intermediate"),
                      Skill("Dart", "Intermediate"),
                      Skill("FireBase", "Intermediate"),
                      Skill("Blockchain", "Beginner"),
                      Skill("C/C++", "Intermediate"),
                      Skill("Web Dev", "Intermediate"),
                      Skill("HTML + CSS", "Intermediate"),
                      Skill("Javascript", "Intermediate"),
                      Skill("BootStrap", "Intermediate"),
                      Skill("DBMS", "Expert"),
                      Skill("SQL/PLSQL", "Intermediate"),
                      Skill("PHP", "Intermediate"),
                      Skill("Dart", "Intermediate"),
                      Skill("Arduino", "Intermediate"),
                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Skill extends StatefulWidget {
  final String name,level;
  Skill(this.name,this.level);
  @override
  _SkillState createState() => _SkillState();
}

class _SkillState extends State<Skill> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: ListTile(
        title: Text("${widget.name}",style: TextStyle(fontSize: 16.0),),
        subtitle:Text("${widget.level}",style: TextStyle(fontSize: 14.0),) ,
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
                child: Text("Hobbies",style: TextStyle(fontSize: 22.0),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 300.0,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hobbie("Coding MindSet", "I am an enthusiastic programmer and have keen interest in learning new skills.", Icon(Icons.laptop_mac,size: 25.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hobbie("Sport Activities", "Badminton, BasketBall and Table Tennis are some of the sports which I like to play in my leisure time.", Icon(Icons.fitness_center,size: 25.0,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hobbie("Music and Travel","I love listening pop music and exploring new destinations", Icon(Icons.headset,size: 25.0,)),
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Hobbie extends StatefulWidget {
  final String name,desc;
  final Icon icon;
  Hobbie(this.name,this.desc,this.icon);
  @override
  _HobbieState createState() => _HobbieState();
}

class _HobbieState extends State<Hobbie> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: widget.icon,
        title: Text("${widget.name}",style: TextStyle(fontSize: 18.0),),
        subtitle:Text("${widget.desc}",style: TextStyle(fontSize: 16.0),) ,
      ),
    );
  }
}
