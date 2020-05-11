import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

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
                  Container(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.home,color: Colors.black,),
                        onPressed:()=> Navigator.pop(context),
                      ),
                    ),
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
                              padding: const EdgeInsets.all(16.0),
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Projects",style:TextStyle(fontSize: 25.0,),),
                                      Text("UnderTaken",style:TextStyle(fontSize: 25.0,),),
                                    ],
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("The Following Projects have been build by me during my College period.Links to most of them have been provided and inconvinience for those whose link is not there."
                                      "Kindly tap the heart if you love my project.",style:TextStyle(fontSize:18.0),),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ResponsiveGridList(
                            scroll: false,
                            desiredItemWidth: 370,
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
      "Flutter App for an Autonomous Vehicle currently initialised to deliver food items from canteen to office staff.",
      "https://github.com/shubhamj25/twigger",
      "Flutter and Dart"
  ),
  ProjectCard(
      "Twigger",
      "Flutter App for an Autonomous Vehicle currently initialised to deliver food items from canteen to office staff.",
      "https://github.com/shubhamj25/twigger",
      "Flutter and Dart"
  ),
  ProjectCard(
      "Twigger",
      "Flutter App for an Autonomous Vehicle currently initialised to deliver food items from canteen to office staff.",
      "https://github.com/shubhamj25/twigger",
      "Flutter and Dart"
  )
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
  ProjectCard(this.title,this.description,this.link,this.category);
  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.indigoAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        elevation: 20.0,
        child: Container(
          width: 370.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.title}",style: TextStyle(color:Colors.white,fontSize: 18.0,fontWeight: FontWeight.w700),),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.android,color: Colors.white,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${widget.category}",style: TextStyle(color:Colors.white,fontSize: 16.0,fontWeight: FontWeight.w500),),
                      ),
                    ],
                  ),
                  Text("${widget.description}",style: TextStyle(color:Colors.white,fontSize: 16.0),),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Card(elevation:6.0,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.link),
                          ),
                          Text("${widget.link}",style: TextStyle(fontSize: 14.0),),
                        ],
                      ),
                    )),
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

