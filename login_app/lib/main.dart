import 'package:flutter/material.dart';
import 'package:login_app/provider/user_provider.dart';
import 'package:login_app/screens/auth/join_screen.dart';
import 'package:login_app/screens/auth/login_screen.dart';
import 'package:login_app/screens/board/insert_screen.dart';
import 'package:login_app/screens/board/list_screen.dart';
import 'package:login_app/screens/board/read_screen.dart';
import 'package:login_app/screens/board/update_screen.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/screens/mypage/profile_screen.dart';
import 'package:login_app/screens/user/cart_screen.dart';
import 'package:login_app/screens/user/product_screen.dart';
import 'package:login_app/screens/user/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp() : FLutter 앱의 시작점을 지정하는 함수
  // - Provider(MyApp) 을 루트 위젯으로 설정하여 앱을 실행
  runApp(
    // Provider
    // - ChangeNotifierProvider 을 사용하여 UserProvider를 전역으로 사용
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    )

  );
  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Provider.of<UserProvider>(context,listen: false).autoLogin();
    

    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const HomeScreen()
      initialRoute: "/",
      // routes: {
      //   '/' : (context) => HomeScreen(),
      //   '/auth/join' : (context) => JoinScreen(),
      //   '/auth/login' : (context) => LoginScreen(),
      //   '/user/search' : (context) => SearchScreen(),
      //   '/user/product' : (context) => ProductScreen(),
      //   '/user/cart' : (context) => CartScreen(),
      //   '/mypage/profile' : (context) => ProfileScreen(),
      // },
      onGenerateRoute: (settings){
        // settings.name: 라우팅 경로 ('/', '/mypage/profile')
        switch(settings.name){
          case '/':
            return PageRouteBuilder(
              pageBuilder: (context,animation,secondaryAnimation) => HomeScreen(),
              transitionDuration: Duration(seconds: 0),
            ); 
          //회원가입
          case '/auth/join':
            return PageRouteBuilder(
              pageBuilder: (context,animation,secondaryAnimation) => JoinScreen(),
              transitionDuration: Duration(seconds: 0),
            ); 
          //로그인
          case '/auth/login':
            return PageRouteBuilder(
              pageBuilder: (context,animation,secondaryAnimation) => LoginScreen(),
              transitionDuration: Duration(seconds: 0),
            ); 
          // //검색
          // case '/user/search':
          //   return PageRouteBuilder(
          //     pageBuilder: (context,animation,secondaryAnimation) => SearchScreen(),
          //     transitionDuration: Duration(seconds: 0),
          //   ); 
          // //상품
          // case '/user/product':
          //   return PageRouteBuilder(
          //     pageBuilder: (context,animation,secondaryAnimation) => ProductScreen(),
          //     transitionDuration: Duration(seconds: 0),
          //   ); 
          // //장바구니
          // case '/user/cart':
          //   return PageRouteBuilder(
          //     pageBuilder: (context,animation,secondaryAnimation) => CartScreen(),
          //     transitionDuration: Duration(seconds: 0),
          //   ); 
          //마이페이지
          case '/mypage/profile':
            return PageRouteBuilder(
              pageBuilder: (context,animation,secondaryAnimation) => ProfileScreen(),
              transitionDuration: Duration(seconds: 0),
            ); 
          default:
        }
      },
      routes: {
        '/board/list' : (context) => const ListScreen(),
        '/board/read' : (context) => const ReadScreen(),
        '/board/insert' : (context) => const InsertScreen(),
        '/board/update' : (context) => const UpdateScreen(),
      },
    );
  }
}