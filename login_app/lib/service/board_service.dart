import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/models/board.dart';

class BoardService {

  // 데이터 목록 조회
  Future<List<Map<String, dynamic>>> list() async {
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards";
    dynamic list;
    try{
      Response response = await dio.get(url);
      print("::::: response - body :::::");
      //print(response.data);
      // list = (response.data as List)
      //                       .map((e) => e as Map<String,dynamic>)
      //                       .toList();


    // 응답이 Map<String, dynamic>이라면 바로 사용
    if (response.data is Map<String, dynamic>) {
      Map<String, dynamic> jsonResponse = response.data;

      // 'list' 키에 해당하는 값을 추출
      if (jsonResponse.containsKey('list') && jsonResponse['list'] is List) {
        // 'list' 값을 List<Map<String, dynamic>> 형태로 변환
        list = List<Map<String, dynamic>>.from(jsonResponse['list']);
        print(list);
      } else {
        print("Error: 'list' key not found or is not a List.");
      }
    } else {
      print("Error: Response is not a valid Map<String, dynamic>");
    }
    } catch (e){
      print(e);
    }
    return list;
  }

  // 데이터 조회
  Future<Map<String, dynamic>?> select(String id) async {
    Dio dio = Dio();
    var url = "http://10.0.2.2:8080/boards/$id";
    var board;
    try{
      var response = await dio.get(url);
      print("::::: response - body :::::");
      //print(response.body);

          // 응답이 Map<String, dynamic>이라면 바로 사용
      if (response.data is Map<String, dynamic>) {
        Map<String, dynamic> jsonResponse = response.data;

        board = Map<String, dynamic>.from(jsonResponse['board']);
        print(board);


      } else {
        print("Error: Response is not a valid Map<String, dynamic>");
      }

      // 'list' 키에 해당하는 값을 추출
      //JSON 디코딩
      // board = jsonDecode(utf8Decoded);
      // boardList :: List<Map<String, dynamic>>
    } catch (e){
      print(e);
    }
    return board;
  }

  // 데이터 등록
  Future<int> insert(Board board) async {
    Dio dio = Dio();
    int result = 0;
    var url = "http://10.0.2.2:8080/boards";
    try{
      var response = await dio.post(
                              url,
                              data : board.toMap()
                              );
      print("::::: response - body :::::");
      print(response.data);

      if( response.statusCode == 200 || response.statusCode == 201){
        print("게시글 등록 성공!");
        result = 1;
      }
      else{
        print("게시글 등록 실패!");
        result=0;
      }
    } catch (e){
      print(e);
    }
    return result;
  }

  // 데이터 수정
  Future<int> update(Board board) async {
    Dio dio = Dio();
        int result = 0;
    var url = "http://10.0.2.2:8080/boards";
    try{
      var response = await dio.put(
                              url,
                              data : board.toMap()
                            );
      print("::::: response - body :::::");
      print(response.data);

      if( response.statusCode == 200 || response.statusCode == 204){
        print("게시글 수정 성공!");
        result = 1;
      }
      else{
        print("게시글 수정 실패!");
        result=0;
      }
    } catch (e){
      print(e);
    }
    return result;
  }

  // 데이터 삭제
  Future<int> delete(String id) async {
    Dio dio = Dio();
    int result = 0;
    var url = "http://10.0.2.2:8080/boards/$id";
    try{
      var response = await dio.delete(url);
      print("::::: response - body :::::");
      print(response.data);

      if( response.statusCode == 200 || response.statusCode == 204){
        print("게시글 삭제 성공!");
        result = 1;
      }
      else{
        print("게시글 삭제 실패!");
        result=0;
      }
    } catch (e){
      print(e);
    }
    return result;
  }
}