import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("서치"),
      ),
      body: Center(
        child: Custombutton(text: "로그인", onPressed: (){},
          isFullWidth:true,
          //color: Colors.amber,
          //backgroundColor: Colors.pinkAccent,
          )
      ),
      //왼쪽드로워
      // drawer : Drawer(),
      //오른쪽 드로워
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 1),
    );
  }
}