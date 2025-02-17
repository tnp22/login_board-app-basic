import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:_scaffoldKey,
      appBar: AppBar(
        title: Text("메인 화면"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // 버튼들을 화면 가운데로 배치
          children: [
              ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/board/list");
              }, 
              child: Text("게시글 목록"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              }, 
              child: Text("로그인"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/join");
              }, 
              child: Text("회원가입"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/mypage");
              }, 
              child: Text("mypage"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white
              ),
            ),

          ]
        )
      ),
      drawer: CustomDrawer(),
      floatingActionButton : FloatingActionButton(
          onPressed: (){
          _scaffoldKey.currentState?.openDrawer();
          } 
      )
    );
  }
}