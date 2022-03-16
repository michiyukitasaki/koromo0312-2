import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/Calendar/calendar_page/calendar_page.dart';
import 'package:instagram_clone_flutter/NewsPage/home_screen.dart';
import 'package:instagram_clone_flutter/Profile_public/home.dart';
import 'package:instagram_clone_flutter/screens/add_post_screen.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';
import 'package:instagram_clone_flutter/screens/profile_screen.dart';
import 'package:instagram_clone_flutter/screens/search_screen.dart';
import 'package:instagram_clone_flutter/widgets/myDrawer.dart';

import '../screens/VideoPage/video/add_video_screen.dart';
import '../screens/VideoPage/video/video_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  WebPubHomeScreen(),
  const FeedScreen(),
  VideoScreen(),
  // const SearchScreen(),
  // const AddPostScreen(),
  // const Text('notifications'),
  MyDrawer(),
  // WebPubHomeScreen(),
  // ProfileScreen(
  //   uid: FirebaseAuth.instance.currentUser!.uid,
  // ),
  // AddVideoScreen(),
  // MyDrawer()
  // CalendarPage(),
  NewsFeedScreen()
];
