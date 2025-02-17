import 'package:flutter/material.dart';
import 'package:login_app/models/User.dart';
import 'package:login_app/notifications/Snackbar.dart';
import 'package:login_app/provider/user_provider.dart';
import 'package:login_app/screens/home_screen.dart';
import 'package:login_app/service/user_service.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/common_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

    final _formKey = GlobalKey<FormState>();

    TextEditingController _usernameController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();

    User? _user;
    UserService userService = UserService();

    String? _username;         //아이디
    String? _name;
    String? _email;

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of<UserProvider>(context, listen: true);

    if( !userProvider.isLogin){
      WidgetsBinding.instance.addPostFrameCallback( (_) {
        if(Navigator.canPop(context)){
          Navigator.pop(context);
        }
        Navigator.pushNamed(context, "/auth/login");
      });

      return const HomeScreen();
    }

    // 로그인 상태
    String? _username = userProvider.userInfo.username ?? '없음';

    // 사용자 정보 조회요청
    if(_user == null){
      userService.getUser(_username).then((value){
        setState(() {
          _user = User.fromMap(value);
        });
        _usernameController.text = (_user?.username ?? _username)!;
        _nameController.text = _user?.name ?? '';
        _emailController.text = _user?.email ?? '';      
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("프로필"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child:
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text("프로필 수정",
                  style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),
                  )
                  ), 
                const SizedBox(height: 16,),
                // 아이디
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '아이디',
                    hintText: '아이디를 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    // setState(() {
                    //   _username = value;
                    // });
                  },
                ),
                const SizedBox(height: 16,),
                                TextFormField(
                                controller: _nameController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '이름',
                    hintText: '이름을 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    setState(() {
                      _user?.name = value;
                    });
                  },
                ),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {},
                  decoration: const InputDecoration(
                    labelText: '이메일',
                    hintText: '이메일를 입력해주세요.',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value){
                    setState(() {
                      _user?.email = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                Custombutton(
                  text: "회원 탈퇴", 
                  isFullWidth: true,
                  backgroundColor: Colors.redAccent,
                  onPressed: (){ 
                    // 회원탈퇴
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("정말로 탈퇴하시겠습니까?"),
                          content: Text("정말로 탈퇴하시겠습니까?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("취소"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text("확인"),
                              onPressed: (){
                                Navigator.pop(context);
                                //회원탈퇴 요청
                                userService.deleteUser(_username).then((value){
                                  if(value){
                                    //회원탈퇴 성공
                                    //-로그아웃 처리
                                    userProvider.logout();
                                    // - 홈화면으로 이동
                                    Navigator.pushReplacementNamed(context,'/');
                                  }
                                });
                              },)
                          ],
                        );
                      }
                    );
                  })
              ],
            ),
          ),
        ),
        bottomSheet: Custombutton
          (text: '회원수정',
          isFullWidth: true, 
          onPressed: () async {
            if(_formKey.currentState!.validate()){
              bool result = await userService.updateUser(
                {
                    'username' : _username,
                    'name' : _user!.name,
                    'email' : _user!.email
                }
              );
              if(result){
                Snackbar(
                  text: "회원정보 수정에 성공하였습니다.",
                  icon: Icons.check_circle,
                  backgroundColor: Colors.green
                ).showSnackbar(context);

                // provider 에 수정된 사용자 정보 업데이트
                userProvider.userInfo = User(
                  username: _username,
                  name: _user!.name,
                  email: _user!.email,
                );
              }
            }
          }
          ),
      //왼쪽드로워
      // drawer : Drawer(),
      //오른쪽 드로워
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommonBottomNavigationBar(currentIndex: 4),
    );
  }
}