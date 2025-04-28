
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tj2024b_app/app/product/productView.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State< ProductList >{
  // 1.
  int cno = 0; // 카테고리 번호 갖는 상태변수, 초기값 0
  int page = 1; // 현재 조회중인 페이지 번호 갖는 상태변수, 초기값 1
  List<dynamic> productList = []; // 자바 서버로부터 조회한 제품( DTO ) 목록 상태 변수
  final dio = Dio();
  // String baseUrl = "http://localhost:8080"; // 기본 자바서버의 URL 정의 // 환경에 따라 IP 변경
  String baseUrl = "http://192.168.40.97:8080"; // 에뮬레이터ㅂㅈ
  // * 현재 스크롤의 상태( 위치/크기 등 )을 감지하는 컨트롤러
  // * 무한스크롤( 스크롤이 거의 바닥에 존재했을 때 새로운 자료 요청 )
  final ScrollController scrollController = ScrollController();

  // 2. 현재 위젯 생명주기 : 위젯이 처음으로 열렸을 때 1번 실행
  @override // (1) 자바서버에게 자료 요청 (2) 스크롤의 리스너(이벤트) 추가
  void initState() {
    onProductAll( page ); // 현재 페이지 전달
    scrollController.addListener( onScroll ); // .addListener: 스크롤의 이벤트(함수) 리스너 추가
  } // f end

  // 3. 자바서버에게 자료 요청 메소드
  void onProductAll( int currentPage ) async {
    try{
      final response = await dio.get( "${baseUrl}/product/all?page=${currentPage}" ); // 현재페이지(page) 매개변수로 보낸다.
      final data = response.data;
      setState(() {
        page = currentPage; // 증가된 현재페이지를 상태변수에 반영
        if( page == 1 ){ // 만약에 첨페이지이면 자료 *대입*
          productList = data['content'];
        }else if( page >= data['totalPages'] ){ // 만약에 현재 페이지수가 전체 페이지수보다 이상이면
          page = data['totalPages']; // 현재페이지수를 전체페이지수로 변경
        }else{
          productList.addAll( data['content'] );
        }
        print( productList );
        print( data );
      });
    }catch( e ){ print( e ); }
  } // f end

  // 4. 스크롤의 리스너(이벤트) 추가 메소드
  void onScroll(){
    // - 만약에 현재 스크롤의 위치가 거의( 적당하게 100 ~ 200 사이 ) 끝에 도달했을 때
    if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 150 ){
      onProductAll( page + 1 ); // 스크롤이 거의 바닥에 도달했을 때 page를 1 증가하여 다음 페이지 자료 요청한다.
    }
  } // f end


  @override
  Widget build(BuildContext context) {
    if( productList.isEmpty ){ // 만약에 제품목록이 비어 있으면
      return Center( child: Text("조회된 제품이 없습니다."),);
    }
    // 제품목록이 있으면
      // - ListView.builder : 여러개 아이템/항목/위젯들을 리스트 형식으로 출력하는 위젯
    return ListView.builder(
      controller: scrollController, // <--- * ListView에 스크롤 컨트롤러 연결 *
      itemCount: productList.length, // 목록의 항목 개수 <--> 제품목록의 개수, page 1일때 5, page 2일때 10
      itemBuilder: ( context, index ) {
        // (1) 각 index번째 제품 꺼내기
        final product = productList[index];
        // (2) 각 제품의 이미지 리스트 추출
        final List<dynamic> images = product['images'];
        // (3) 만약에 이미지가 존재하면 대표이미지(1개) 추출, 없으면 기본 이미지 추출
        String imageUrl;
        if( images.isEmpty ){ // 리스트(이미지)가 비어있으면
          imageUrl = "${baseUrl}/upload/default.jpg";
        }else{
          imageUrl = "${baseUrl}/upload/${images[0]}";
        }
        // (4) 위젯
        return InkWell( // 해당 위젯을 클릭(탭:모바일 터치)하면 '상세페이지'로 이동 구현
          onTap: () => { // 만약에 하위 위젯(Card)을 클릭했을 때 이벤트 발생
            Navigator.push(context,                              // 위젯명( 인수1, 인수2 )
              MaterialPageRoute(builder: (context) => ProductView( pno: product['pno'], ) )
            )
          } , 
          child: Card(
            margin: EdgeInsets.all( 15 ),
            child: Padding( // 가로 배치, div.flex{ div.flex }
              padding: EdgeInsets.all( 10 ),
              child: Row(
                children: [ // 가로 배치할 위젯들
                  Container( // 하위요소를 담을 박스(div)
                    width: 100, height: 100, // 가로 세로 사이즈
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover, // 만약에 이미지가 구역보다 크면 비율유지
                    ), // 웹 이미지 출력( 이미지 위젯 ),
                  ),
                  SizedBox( width: 20 ,), // 여백
                  Expanded(child: Column( // 그 외 구역
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                    children: [
                      Text( product['pname'], style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ), ),
                      SizedBox( height: 8,),
                      Text( "가격 : ${ product['pprice'] }", style: TextStyle( fontSize: 16, color: Colors.red, ), ),
                      SizedBox( height: 4,),
                      Text( "카테고리 : ${ product['cname'] }" ),
                      SizedBox( height: 4,),
                      Text( "조회수 : ${ product['pview'] }" ),
                    ],
                  ))
                ],
              )
            ),
          ),
        );
      }, // itemBuilder
    ); // ListView
  }
}