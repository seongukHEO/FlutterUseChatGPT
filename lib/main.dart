import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
with TickerProviderStateMixin{

  TextEditingController messageTextController = TextEditingController();

  static const String _kStrings = "Seonguk Flutter ChatGPT";
  String get _currentString => _kStrings;

  ScrollController scrollController = ScrollController();
  late Animation<int> _characterCount;
  late AnimationController animationController;

  setupAnimations(){
    animationController = AnimationController(
        vsync: this,
        //애니메이션 지속시간
        duration: Duration(milliseconds: 2500)
    );
    //여긴 애니메이션의 길이 파악? 이라고 보면된다
    //즉 0부터 _currentString의 길이만큼
    _characterCount = StepTween(begin: 0 ,end:_currentString.length ).animate(
       CurvedAnimation(
           parent: animationController,
           curve: Curves.easeIn
       )
    );
    animationController.addListener((){
      setState(() {

      });
    });

    animationController.addStatusListener((status){

      //그니까 즉 애니메이션이 끝까지 진행 됐을 경우
      //1초 쉬어주고 다시 뒤로 보낸다
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1)).then((value){
          animationController.reverse();
        });
      }
      //여기는 애니메이션이 중단됐을 경우..?
      else if(status == AnimationStatus.dismissed){
        Future.delayed(Duration(seconds: 1)).then((value){
          animationController.forward();
        });
      }
    });
    //이걸 꼭 넣어주어야 애니메이션이 동작한다
    animationController.forward();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAnimations();
  }


  //데이터 삭제
  @override
  void dispose() {
    messageTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  child: PopupMenuButton(
                    color: Colors.white,
                    itemBuilder: (context){
                      return [
                        PopupMenuItem(child: ListTile(
                          title: Text("히스토리"),
                        )),
                        PopupMenuItem(child: ListTile(
                          title: Text("설정"),
                        )),
                        PopupMenuItem(child: ListTile(
                          title: Text("새로운 채팅"),
                        )),
                      ];
                    },
                  ),
                ),
              ),
              //채팅 위젯
              Expanded(
                  child: AnimatedBuilder(
                    animation: _characterCount,
                    builder: (BuildContext context, Widget? child) {
                      //String을 계산해준다..?
                      String text = _currentString.substring(0, _characterCount.value);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${text}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.green,
                          )
                        ],
                      );
                    },

                    // child: ListView.builder(
                    //   itemCount: 100,
                    //     itemBuilder: (c, i){
                    //     //유저의 질문
                    //     if (i % 2 == 0) {
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(vertical: 16),
                    //         child: Row(
                    //           children: [
                    //             CircleAvatar(),
                    //             SizedBox(width: 8,),
                    //             Expanded(
                    //                 child: Column(
                    //                   children: [
                    //                     Text("User"),
                    //                     Text("message")
                    //                   ],
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                 )
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     }
                    //     //GPT의 답
                    //       return Row(
                    //         children: [
                    //           CircleAvatar(
                    //             backgroundColor: Colors.teal,
                    //           ),
                    //           SizedBox(width: 8,),
                    //           Expanded(child: Column(
                    //             children: [
                    //               Text("GPT"),
                    //               Text("OpenAI")
                    //             ],
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //           ))
                    //         ],
                    //       );
                    //     }
                    // ),
                  )
              ),
              Dismissible(
                key: Key("Chat-bar"),
                direction: DismissDirection.startToEnd,
                onDismissed: (d){
                  if (d == DismissDirection.startToEnd) {
                    //Dismiss 됐을 때 로직 처리
                  }
                },
                //이건 우리가 지정한 bar가 넘어가질 때 보여질 것
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("NewChat")
                  ],
                ),
                confirmDismiss: (d)async{
                  if (d == DismissDirection.startToEnd) {
                    //로직 처리
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all()
                        ),
                        child: TextField(
                          controller: messageTextController,
                          decoration: InputDecoration(
                            //텍스트 필드의 밑줄 삭제
                            border: InputBorder.none,
                            hintText: "Message",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: 42,
                        onPressed: (){},
                        icon: Icon(Icons.arrow_circle_up),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
