import 'package:flutter/material.dart';
import 'package:login_app/models/board.dart';
import 'package:login_app/service/board_service.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  // 🧊 state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String? id;
  final boardService = BoardService();
  late Future<Map<String, dynamic>?> _board;
  late Board board;

  // 팝업메뉴 아이템 (수정하기, 삭제하기)
  final List<PopupMenuEntry<String>> _popupMenuItems = [
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.black,),
                      SizedBox(width: 8,),
                      Text("삭제하기")
                    ],
                  )
                ),
              ];

  @override
  void initState() {
    super.initState();

    // id 파라미터 넘겨받기
    WidgetsBinding.instance.addPostFrameCallback( (_) {
      final args = ModalRoute.of(context)!.settings.arguments;

      if( args is String ) {
        setState(() {
          id = args;
          print("id : $id");
          _getData(id!);
        });
      }
      
    });
  }

  // 게시글 조회 요청
  Future<void> _getData(String id) async {
    final data = await boardService.select(id);
    if( data != null ) {
      setState(() {
        board = Board.fromMap(data);
        _titleController.text = board.title ?? '';
        _writerController.text = board.writer ?? '';
        _contentController.text = board.content ?? '';
      });
    } else {
      print("데이터를 조회할 수 없습니다.");
    }
  }

  // 게시글 수정 처리
  Future<void> update() async {
    // 유효성 검사
    if( !_formKey.currentState!.validate() ) {
      print('게시글 입력 정보가 유효하지 않습니다');
      return;
    }
    // 게시글 객체 수정
    board.title = _titleController.text;
    board.writer = _writerController.text;
    board.content =  _contentController.text;
    
    // 데이터 수정
    int result = await boardService.update(board);
    if( result > 0 ) {
      print("게시글 수정 성공!");
      // 게시글 목록으로 이동
      Navigator.pushReplacementNamed(context, "/board/list");
    }
    else {
      print("게시글 수정 실패!");
    }
  }

  // ❓ 삭제 확인 (정말로 삭제하시겠습니까?)
  Future<bool> _confirm() async {
    bool result = false;
    await showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("삭제 확인"),
          content: Text("정말로 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              }, 
              child: Text("삭제")
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              }, 
              child: Text("취소")
            ),
          ],
        );
      }
    ).then((value) {
      // [삭제], [취소] 클릭 후
      result = value ?? false;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/board/list");
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("게시글 수정"),
        actions: [
          PopupMenuButton(
            onSelected: (String value) async {
              // 삭제하기 클릭
              if( value == 'delete' ) {
                // 삭제 확인 ➡ 삭제 처리
                bool check = await _confirm();
                if( check ) {
                  // 삭제 처리
                  int result = await boardService.delete(id!);
                  if( result > 0 ) {
                    // 게시글 목록으로 이동
                    Navigator.pushReplacementNamed(context, "/board/list");
                  }
                }
              }
            }, 
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return _popupMenuItems;
            }
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 제목
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '제목'
                ),
                validator: (value) {
                  if( value == null || value.isEmpty ) {
                    return "제목을 입력하세요.";
                  }
                  return null;
                },
              ),
              // 작성자
              TextFormField(
                controller: _writerController,
                decoration: const InputDecoration(
                  labelText: '작성자'
                ),
                validator: (value) {
                  if( value == null || value.isEmpty ) {
                    return "작성자를 입력하세요.";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0,),
              // 내용
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if( value == null || value.isEmpty ) {
                    return "내용을 입력하세요.";
                  }
                  return null;
                },
                maxLines: 5,    // 여러줄 입력 설정 (5줄)
                keyboardType: TextInputType.multiline, // 여러줄 입력 설정
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // 게시글 데이터 수정 처리
              update();
            }, 
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // 테두리 곡률 제거
              )
            ),
            child: const Text("수정하기")
          ),
        ),
      ),
    );
  }
}