import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: Column(
         children: [
                 Custombutton(text: "로그인", onPressed: (){
                  Navigator.pushNamed(context, "/auth/login");
                 },
          isFullWidth:true,
          //color: Colors.amber,
          //backgroundColor: Colors.pinkAccent,
          ),
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
         ]
        

          
      ),
      //왼쪽드로워
      // drawer : Drawer(),
      //오른쪽 드로워
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 0),
    );
  }


}