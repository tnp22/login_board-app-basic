import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("제품"),
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
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 2),
    );
  }
}