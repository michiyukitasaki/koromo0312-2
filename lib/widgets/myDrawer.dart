import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:instagram_clone_flutter/Profile_public/home.dart';

import '../Calendar/calendar_page/calendar_page.dart';
import '../ToDo/page/home_page.dart';
import '../ref/video_screen.dart';
import '../resources/auth_methods.dart';
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
                  leading: Icon(Icons.image_search,color: Colors.white,),
                  title: Text('写真一覧',style: TextStyle(color: Colors.white),),
                  onTap: (){
                    // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                    // Navigator.pushReplacement(context, route);
                    Get.to(()=> SearchScreen());
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
                // Divider(
                //   height: 10,color: Colors.white,thickness: 6,
                // ),
                // ListTile(
                //   leading: Icon(Icons.video_collection_sharp,color: Colors.white,),
                //   title: Text('動画',style: TextStyle(color: Colors.white),),
                //   onTap: (){
                //     // Route route = MaterialPageRoute(builder: (c) => ItemHome());
                //     // Navigator.pushReplacement(context, route);
                //     Get.to(()=>VideoScreen());
                //   },
                // ),
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
}
