import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_clone_flutter/Profile_public/home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Calendar/calendar_page/calendar_page.dart';
import '../NewsPage/home_screen.dart';
import '../ToDo/page/home_page.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../screens/VideoPage/video/add_video_screen.dart';
import '../screens/VideoPage/video/video_screen.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/login_screen.dart';
import '../screens/search_screen.dart';
class MyDrawer extends StatelessWidget {

  // final String uid;
  // const MyDrawer({
  //   Key? key,
  //   required this.uid,
  // }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
        Column(
              children: [
                // ListTile(
                //   leading: Icon(Icons.wysiwyg,color: Colors.white,),
                //   title: Text('ホーム',style: TextStyle(color: Colors.white),),
                //   onTap: (){
                //     // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                //     // Navigator.pushReplacement(context, route);
                //     Get.to(()=>WebPubHomeScreen());
                //   },
                // ),
                // Divider(
                //   height: 10,color: Colors.white,thickness: 6,
                // ),
                ListTile(
                  leading: Icon(Icons.home,color: Colors.white,),
                  title: Text('ホーム',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                    // Navigator.pushReplacement(context, route);
                    Get.to(()=>  ResponsiveLayout(
                      mobileScreenLayout: MobileScreenLayout(),
                      webScreenLayout: WebScreenLayout(),
                    )
                    );
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera_back,color: Colors.white,),
                  title: Text('画像のアップロード',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                    // Navigator.pushReplacement(context, route);
                    Get.to(()=>AddPostScreen());
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.video_call_sharp,color: Colors.white,),
                  title: Text('動画アップロード',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                    // Navigator.pushReplacement(context, route);
                    Get.to(()=>AddVideoScreen());
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today_rounded,color: Colors.white,),
                  title: Text('カレンダー',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                    // Navigator.pushReplacement(context, route);
                    Get.to(()=>CalendarPage());
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.notes_outlined,color: Colors.white,),
                  title: Text('To Doリスト',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => ToDoHomePage(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.notes_outlined,color: Colors.white,),
                  title: Text('ニュースページ',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (context) => NewsFeedScreen(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.transit_enterexit,color: Colors.white,),
                  title: Text('おかねるブログへ',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    _launchInApp();
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),
                ListTile(
                  leading: Icon(Icons.adjust_outlined,color: Colors.white,),
                  title: Text('サインアウト',style: TextStyle(color: Colors.white),),
                  onTap: () async {
                    await AuthMethods().signOut();
                    Navigator.of(context)
                        .pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                        const LoginScreen(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10,color: Colors.white,thickness: 6,
                ),

        ],
    ),]

      ),

    );
  }
  _launchInApp() async {
    String url = 'https://okaneru.com/';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    } else {
      throw 'このURLにはアクセスできません';
    }
  }

}
