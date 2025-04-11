
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

String bookPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/book";
String replyPath = "https://alleged-camel-thejoeun-park-c2a346cf.koyeb.app/api/reply";

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
}

class _DetailState extends State< Detail >{

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int bno = ModalRoute.of( context )!.settings.arguments as int;
    bookFindById( bno );
    replyFindAll( bno );
  }

  Dio dio = Dio();
  Map<String, dynamic> book = {};
  // 책 추천 상세 조회
  void bookFindById( bno ) async {
    try{
      final response = await dio.get( bookPath + "/view?bno=$bno" );
      final data = response.data;
      if( data != null ){
        setState(() {
          book = data;
        });
      }
    }catch( e ){ print( e );  }
  } // f end

  List<dynamic> replyList = [];
  // 댓글 전체 조회
  void replyFindAll( bno ) async {
    try{
      final response = await dio.get( replyPath + "?bno=$bno" );
      final data = response.data;
      if( data != null ){
        setState(() {
          replyList = data;
        });
      }
    }catch( e ){ print( e ); }
  } // f end

  TextEditingController rnameController = TextEditingController();
  TextEditingController rcontentController = TextEditingController();
  TextEditingController rpwdController = TextEditingController();

  void replySave() async {
    int bno = book['bno'];

    final sendData = {
      "rname" : rnameController.text,
      "rcontent" : rcontentController.text,
      "rpwd" : rpwdController.text,
      "bno" : bno,
    };

    try{
      final response = await dio.post( replyPath, data: sendData );
      final data = response.data;
      if( data != null ){
        replyFindAll( bno );
        setState(() {
          rnameController.text = '';
          rcontentController.text = '';
          rpwdController.text = '';
        });
      }
    }catch( e ){ print( e ); }
  } // f end

  void replyDelete( int rno ) async {
    final sendData = {
      "rno" : rno,
      "rpwd" : rpwdController.text,
    };

    try{
      final response = await dio.put( replyPath + "/delete", data: sendData );
      final data = response.data;
      if( data ){
        replyFindAll( book['bno'] );
        setState(() {
          rpwdController.text = '';
        });
      }
    }catch( e ){ print( e ); }
  } // f end

  TextEditingController bpwdController = TextEditingController();

  void bookDelete( ) async {
    int bno = book['bno'];

    final sendData = {
      "bno" : bno,
      "bpwd" : bpwdController.text,
    };

    try{
      final response = await dio.put( bookPath + "/delete", data: sendData );
      final data = response.data;
      if( data ){
        Navigator.pushNamed( context, "/" );
      }
    }catch( e ){ print( e ); }
  } // f end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("책 추천 상세 페이지")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("책 제목", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text("${book['btitle'] }", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),

                  Text("작가명", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text("${book['bwriter'] }", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 10),

                  Text("작성날짜", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                  book['updateAt'] == null
                  ? Text( "등록일 : ${ book['createAt'] }", style: TextStyle(fontSize: 10), )
                  : Text( "등록일 : ${ book['createAt'] }", style: TextStyle(fontSize: 10), ),
                  SizedBox(height: 10),

                  Text("책 소개", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                  Text("${book['bcontent'] }", style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, "/update", arguments: book['bno']),
                  child: Text("수정"),
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () async {
                    String? password = await showDialog<String>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("책 삭제"),
                        content: TextField(
                          controller: bpwdController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "비밀번호 입력"),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: Text("취소")),
                          TextButton(
                            onPressed: () => Navigator.pop(context, bpwdController.text),
                            child: Text("확인"),
                          ),
                        ],
                      ),
                    );
                    if (password != null && password.isNotEmpty) {
                      bpwdController.text = password;
                      bookDelete();
                    }
                  },
                  child: Text("삭제"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: TextField(
                  controller: rnameController,
                  decoration: InputDecoration(labelText: "작성자명"),
                  maxLength: 30,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: rcontentController,
                      decoration: InputDecoration(labelText: "리뷰 내용"),
                      maxLines: 2,
                    ),
                    TextField(
                      controller: rpwdController,
                      decoration: InputDecoration(labelText: "비밀번호"),
                      obscureText: true,
                      maxLength: 30,
                    ),
                    Center(
                      child: OutlinedButton(
                        onPressed: replySave,
                        child: Text("댓글 등록"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("댓글", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ...replyList.map((reply) {
              return Card(
                child: ListTile(
                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "작성자: ",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: "${reply['rname']}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      Text("내용: ${reply['rcontent']}"),
                      SizedBox(height: 5),
                      Text("작성일: ${reply['createAt']}"),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.close_outlined),
                    onPressed: () async {
                      String? password = await showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("댓글 삭제"),
                          content: TextField(
                            controller: rpwdController,
                            obscureText: true,
                            decoration: InputDecoration(labelText: "비밀번호 입력"),
                          ),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: Text("취소")),
                            TextButton(
                              onPressed: () => Navigator.pop(context, rpwdController.text),
                              child: Text("확인"),
                            ),
                          ],
                        ),
                      );
                      if (password != null && password.isNotEmpty) {
                        rpwdController.text = password;
                        replyDelete(reply['rno']);
                      }
                    },
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}