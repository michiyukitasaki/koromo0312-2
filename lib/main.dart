import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram_clone_flutter/providers/user_provider.dart';
import 'package:instagram_clone_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone_flutter/responsive/responsive_layout.dart';
import 'package:instagram_clone_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:provider/provider.dart';

import 'Calendar/provider/event_provider.dart';
import 'ToDo/provider/todos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          // apiKey: "AIzaSyCjQlOyVCoxt7BYG4gCm8OikT_Y07iN7fU",
          // authDomain: "product-management0219.firebaseapp.com",
          // databaseURL: "https://product-management0219-default-rtdb.asia-southeast1.firebasedatabase.app",
          // projectId: "product-management0219",
          // storageBucket: "product-management0219.appspot.com",
          // messagingSenderId: "1053487127090",
          // appId: "1:1053487127090:web:53637588350c224f0bfa2b"
          apiKey: "AIzaSyBsK7eEp0D0HqWKWenZQefM9ylTGIuH0hU",
          authDomain: "imagetotext0226.firebaseapp.com",
          projectId: "imagetotext0226",
          storageBucket: "imagetotext0226.appspot.com",
          messagingSenderId: "340645375939",
          appId: "1:340645375939:web:8f49c3d4f2cc3ca861d776"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => EventProvider()),
        ChangeNotifierProvider(create: (c) => TodosProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ころもの日常',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
