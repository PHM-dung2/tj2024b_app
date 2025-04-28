
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget{
  // * 하나의 필드를 갖는 생성자
  /*
  int pno; // - 필드/메버변수
  ProductView( this.pno ); // 생성자
  */
  // 오버로딩 지원하지 않는다. : 여러개 생성자를 가질 수 없다.

  // (2) * 여러개의 필드를 갖는 생성자 *
  int? pno; // 타입? : null 포함한다 뜻
  String? pname;
  ProductView( { this.pno, this.pname } );

  @override
  _ProductViewState createState() {
    // print( pno ); // [확인용]
    return _ProductViewState();
  }
}

class _ProductViewState extends State< ProductView >{

  // 1.
  Map< String, dynamic > product = {}; // 제품 1개를 저장하는 상태변수
  final dio = Dio();
  final baseUrl = "http://192.168.40.97:8080";

  // 2. 생명주기
  @override // (1) pno에 해당하는 제품 정보 요청
  void initState() {
    onView();
  }

  // 3. 제품 요청
  void onView() async {
    try{               // * 직계 상위 부모 위젯의 접근 : widget.필드명, widget.메소드명()
      final response = await dio.get( "${baseUrl}/product/view?pno=${widget.pno}");
      final data = response.data;
      if( data != null ){
        setState(() {
          product = data;
        });
      }
    }catch( e ){ print( e ); }

  } // f end

  // 4. 화면 반환
  @override
  Widget build(BuildContext context) {

    // 1. 만약에 제품정보가 없으면 로딩위젯( CircularProgressIndicator )
    if( product.isEmpty ){ return Center( child: CircularProgressIndicator(),); }
    // 2. 이미지 추출
    final List<dynamic> images = product['images'];
    // 3. 이미지 상태에 따라 위젯 만들기
    Widget imageWidget;
    if( images.isEmpty ){
      imageWidget = Container(
        height: 300, // 높이
        alignment: Alignment.center, // 가운데 정렬
        child: Image.network("${baseUrl}/upload/default.jpg", fit: BoxFit.cover, ),
      );
    }else{ // 이미지들이 존재하면
      imageWidget = Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal , // 목록 스크롤 방향, 기본값 : 세로, 가로 설정
          itemCount: images.length, // 이미지 개수 반복
          itemBuilder: (context, index){
            String imageUrl = "${baseUrl}/upload/${images[index]}"; // index번째 이미지
            return Padding(
              padding: EdgeInsets.all( 5 ),
              child: Image.network( imageUrl, fit: BoxFit.cover ),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("제품 상세 정보"),
      ),
      // 3. 본문
      body: SingleChildScrollView( // 내용이 길어지ㅏ면 스크롤 제공하는 위젯
        padding: EdgeInsets.all( 15 ), // 안쪽 여백
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( "상품명 : ${ product['pname'] }", style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold ), ),
            Divider(),
            // 구분선 : vs <hr/>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝에 배치
              children: [
                Text( "판매자 : ${ product['memail'] }" ),
                Text( "카테고리 : ${ product['cname'] }" ),
                Text( "조회수 : ${ product['pview'] }회" ),
              ],
            ),
            SizedBox( height: 18,),
            /* 이미지 위젯 */
            imageWidget,
            /* 이미지 위젯 end */
            SizedBox( height: 10,),
            Text( "가격 : ${product['pprice'] }원", style: TextStyle( fontSize: 22, fontWeight: FontWeight.bold ), ),
            SizedBox( height: 10,),
            Text("제품 설명", style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ),),
            SizedBox( height: 8,),
            Text( product['pcontent'] ),
          ],
        ),
      ),
    );
  }
}