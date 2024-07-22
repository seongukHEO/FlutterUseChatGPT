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

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController messageTextController = TextEditingController();

  static const String _kStrings = "Seonguk Flutter ChatGPT";
  String get _currentString => _kStrings;

  ScrollController scrollController = ScrollController();

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
                  child: Container(
                    child: ListView.builder(
                      itemCount: 100,
                        itemBuilder: (c, i){
                        //유저의 질문
                        if (i % 2 == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: [
                                CircleAvatar(),
                                SizedBox(width: 8,),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Text("User"),
                                        Text("message")
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    )
                                )
                              ],
                            ),
                          );
                        }
                        //GPT의 답
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.teal,
                              ),
                              SizedBox(width: 8,),
                              Expanded(child: Column(
                                children: [
                                  Text("GPT"),
                                  Text("OpenAI")
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ))
                            ],
                          );
                        }
                    ),
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
