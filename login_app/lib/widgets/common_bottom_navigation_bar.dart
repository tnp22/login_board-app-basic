import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CommonBottomNavigationBar({
    Key? key,
    required this.currentIndex
  }):super(key : key) ;

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //selectedItemColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index){
          switch(index){
            case 0: Navigator.pushReplacementNamed(context, '/'); break;
            // case 1: Navigator.pushReplacementNamed(context, '/user/search'); break;
            // case 2: Navigator.pushReplacementNamed(context, '/user/product'); break;
            // case 3: Navigator.pushReplacementNamed(context, '/user/cart'); break;
            case 1: Navigator.pushReplacementNamed(context, '/mypage/profile'); break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈"
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: "검색"
          // ),
          //           BottomNavigationBarItem(
          //   icon: Icon(Icons.category),
          //   label: "상품"
          // ),
          //           BottomNavigationBarItem(
          //   icon: Icon(Icons.shopping_bag),
          //   label: "장바구니"
          // ),
                              BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "마이"
          ),
        ]
      );
  }
}