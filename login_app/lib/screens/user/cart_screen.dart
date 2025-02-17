import 'package:flutter/material.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카트"),
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
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 3),
    );
  }
}