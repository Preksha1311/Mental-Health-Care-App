import 'package:flutter/material.dart';
import 'CustomTabBar.dart';
import "Screens/Tasks.dart";
import 'Screens/Dashboard.dart';
import 'Screens/AccountPage.dart';
import 'Screens/DoctorPage.dart';
import 'Screens/SplashPage.dart';
import 'authentication.dart';




void main() =>runApp(MyApp());


class MyApp extends StatelessWidget {
  final String uid;
  MyApp({this.uid=""});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: SplashPage(),
      routes: 
      {
        "tasks":(context)=>Tasks(uid: uid),
        
        "main" :(context)=>MyHomePage(uid:uid),
        "doctor": (context)=>DoctorPage(),
        "account": (context)=>AccountPage(),
      },
      title: 'companion',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String uid;
  MyHomePage({Key key, this.uid}) : super(key: key);

  final String title="our Companion";

  @override
  _MyHomePageState createState() => _MyHomePageState(uid:uid);
}

class _MyHomePageState extends State<MyHomePage> {
PageController pageController=PageController(initialPage: 0);
_MyHomePageState({this.uid});
String uid;

Map<String,Widget> pages;
@override
void initState(){
pages=<String,Widget>{
    "Tasks" : Tasks(uid:uid),
    "Dashboard" : Dashboard(),   
  };
  super.initState();
}

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor:
        Colors.deepOrange,
        title: Text(
          widget.title,
          textAlign: TextAlign.left,
          style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)
          ),
          
        bottom: CustomTabBar(pageController: pageController, pageNames: pages.keys.toList(),),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin:EdgeInsets.all(10.0) ,
            child: Text.rich(TextSpan(text: "JAYESH")),
          ),
        ListTile(
        leading: Image.asset("doctor"),  
        title: Text('Get Professional Help',
          style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
        onTap: () {
        Navigator.pushNamed(context, "doctor");
        Navigator.pop(context);
        },
        ),
        ListTile(
        leading: Image.asset("Account"),  
        title: Text('Your Account',
        style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
        onTap: () {
        Navigator.pushNamed(context, "account");
        Navigator.pop(context);
        },),
        ListTile(
              title: new Text('Logout', textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
              trailing: new Icon(Icons.exit_to_app),
              onTap: () async {
                await signOutWithGoogle();
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
        ]
        )
      ),
      body: 
        PageView(
        controller: pageController,
        children: pages.values.toList(),
        )
      
    );
      
  }
}
