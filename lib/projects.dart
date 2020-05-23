import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myportfolio/code_icons.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //TopBar(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/firewatch.png"),
                    fit: BoxFit.cover,
                  )
              ),
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
                            Text("Projects",style:TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w800),),
                            Text("UnderTaken",style:TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.w100),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.home,color: Colors.black,),
                          onPressed:()=> Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),

                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                            color:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 20.0),
                              child: ListTile(
                                subtitle: Padding(
                                  padding: const EdgeInsets.symmetric(vertical:8.0),
                                  child: Text("The Following Projects have been build by me during my College period.Links to most of them have been provided and inconvinience for those whose link is not there.",style:TextStyle(fontSize:18.0),),
                                ),
                              ),
                            ),
                          ),
                        ),
                          ResponsiveGridList(
                            scroll: false,
                            desiredItemWidth: 300,
                            minSpacing: 10,
                            children: projects,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<ProjectCard> projects=[
  ProjectCard(
      "Twigger",
      "Flutter App for an Autonomous Vehicle currently initialized to deliver food items from canteen to office staff.",
      "https://github.com/shubhamj25/twigger",
      "Flutter and Dart",100,Icon(Icons.phone_android,color: Colors.black,)
  ),
  ProjectCard(
      "InstaView",
      "Flutter Application to view ,comment,like and upload inspirational videos posted on the app by its users.",
      "https://github.com/shubhamj25/instaview",
      "Flutter and Dart",101,Icon(Icons.phone_android,color: Colors.black,)
  ),
  ProjectCard(
      "E- notice Board",
      "Web Application to read and post University Notices.Developed using HTML5 and Bootstrap4 with php as backend to a SQL Database",
      "https://eboard25.000webhostapp.com/eboard/examples/",
      "HTML + CSS,AJAX & PHP",102,Icon(Code.code,color: Colors.black,)
  ),
  ProjectCard(
      "BlockChain FabCar Application",
      "Handles car ownership transactions using blockchain with NODEJS interface to invoke transactions and uses Hyperledger Explorer to have a view over all blocks appended to the blockchain.",
      "https://github.com/shubhamj25/fabcar-app",
      "Hyperledger Fabric",103,Icon(Code.bitcoin,color: Colors.black,)
  ),
  ProjectCard(
      "MEAN Stack Web Application",
      "This is a MEAN stack application using Node JS + Mongo DB as a service in Backend and Angular as Frontend.",
      "http://postshubhu251298.herokuapp.com/",
      "MEAN Stack",104,Icon(Code.database,color: Colors.black,)
  ),
  ProjectCard(
      "Sample Railway Reservation Portal",
      "A Sample Railway Reservation Web Application built using PHP as backend and HTML + CSS for Frontend.",
      "https://railyatri1234.000webhostapp.com/",
      "Web Development",105,Icon(Icons.web,color: Colors.black,)
  ),
  ProjectCard(
      "Website for EDC@TIET",
      "I worked for the Entrepreneurship Development Cell of my college and made a sample website for its representation. In this I used HTML + CSS for Frontend, PHP for backend and MYSQL for queries, Adobe Photoshop for Image Editing.",
      "https://shubhamj25.github.io/profile2/examples/contents/edc.html",
      "Web Development",106,Icon(Icons.web,color: Colors.black,)
  ),
  ProjectCard(
      "Webkiosk Demo",
      "Demo model of student management portal for a college/school.Since ,it's meant to work on a Single System thus below link shows the html page according to a User already logged in.",
      "https://shubhamj25.github.io/profile2/examples/contents/html/WEBSITE.html",
      "HTML & C++",107,Icon(Code.html5,color: Colors.black,)
  ),
];

/*
class ProjectDetails{
  final String link,title,description,category;
  ProjectDetails.fromMap(Map<dynamic ,dynamic> map)
      : assert(map['title']!=null),
        assert(map['link']!=null),
        link=map['link'],
        title=map['title'],
        description=map['description'],
        category=map['category'];
  ProjectDetails.fromSnapshot(DocumentSnapshot snapshot):this.fromMap(snapshot.data);
}
 */



class ProjectCard extends StatefulWidget {
  final String link,title,description,category;
  final int herotag;
  final Icon icon;
  ProjectCard(this.title,this.description,this.link,this.category,this.herotag,this.icon);
  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigoAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      elevation: 20.0,
      child:Container(
        width: 310.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title}",style: TextStyle(color:Colors.white,fontSize: 18.0,fontWeight: FontWeight.w700),),
                  ),
                ),
                FloatingActionButton(
                  heroTag: widget.herotag,
                  child: widget.icon,
                  backgroundColor: Colors.white,
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.extension,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${widget.category}",style: TextStyle(color:Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),
                Text("${widget.description}",style: TextStyle(color:Colors.white,fontSize: 16.0),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: FloatingActionButton.extended(heroTag:DateTime.now().millisecondsSinceEpoch,backgroundColor:Colors.white,icon:Icon(Icons.link,color: Colors.indigoAccent,),onPressed:()=>launch("${widget.link}"), label:Text("View Project",style: TextStyle(color: Colors.indigoAccent),)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

