import 'package:flutter/material.dart';
import 'package:litsen_chat_gpt/models/chat_model.dart';
import 'package:litsen_chat_gpt/services/api_services.dart';
import 'package:google_fonts/google_fonts.dart';

class TalkPage extends StatefulWidget {
  const TalkPage({Key? key}) : super(key: key);
  @override
  _TalkPageState createState() => _TalkPageState();
}

late List _msgList;

class _TalkPageState extends State<TalkPage> {
  TextEditingController msgInputController = TextEditingController();

  
  @override
  void initState() {
    getMessageList();
    super.initState();
  }

  ListView _showMessageArea() {
    return ListView.builder(
        reverse: true,
        itemCount: _msgList.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: (_msgList[index]["reqAnsGubun"] == "r")
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      color: (_msgList[index]["reqAnsGubun"] == "r")
                          ? Color(0xff2865DC)
                          : Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          color: (_msgList[index]["reqAnsGubun"] == "r")
                              ? Color(0xffE4E9F6)
                              : Color(0xffE1E1E1),
                          blurRadius: 10,
                          blurStyle: BlurStyle.normal,
                          offset: Offset(0, 4),
                        ),
                      ]),
                  child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          Text(
                            _msgList[index]["text"].toString(),
                            // softWrap: true,
                            // maxLines: 100,
                            // overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: (_msgList[index]["reqAnsGubun"] == "r")
                                              ? Colors.white
                                              : Colors.black,
                            ),
                          ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: (){
                                playMessage();
                              }, 
                              tooltip: 'Play to Sound.',
                              icon: Icon(Icons.volume_up,
                                  size: 20,
                                  color: (_msgList[index]["reqAnsGubun"] == "r")
                                            ? Colors.white
                                            : Colors.black,
                              )
                            )
                          ],
                        ),
                      ]))
            ],
          );
        });
  }

  Row _sendMessageArea() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, left: 20),
            width: MediaQuery.of(context).size.width - 100,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffF3F3F3),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffDBDBDB),
                  blurRadius: 15,
                  spreadRadius: 1.5,
                ),
              ],
            ),
            child: TextFormField(
              controller: msgInputController,
              keyboardAppearance: Brightness.dark,
              // controller: msgcontroller,
              maxLines: 35,
              // focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Message...',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  top: 19,
                  left: 20,
                ),
                // prefixIcon: Padding(
                //   padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                //   child: GestureDetector(
                //     // onTap: () {
                //     //   EmojiPicker();
                //     // },
                //     child: Image.asset(
                //       "assets/smile.png",
                //       color: Colors.black,
                //       height: 27,
                //       width: 27,
                //     ),
                //   ),
                // ),
                // suffixIcon: Padding(
                //   padding: const EdgeInsets.only(top: 0, left: 3, right: 15),
                //   child: InkWell(
                //     // onTap: () {
                //     //   showPhotoOptions();
                //     // },
                //     child: Image.asset(
                //       "assets/camera.png",
                //       height: 27,
                //       width: 27,
                //     ),
                //   ),
                // ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 0,
              left: 10,
            ),
            child: FloatingActionButton(
              elevation: 15,
              onPressed: () {},
              child: ElevatedButton(
                  onPressed: () {
                    print("ElevatedButton onPressed");
                    processMessage();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xffFFFFFF),
                    backgroundColor: Color(0xff2865DC),
                    shape: CircleBorder(),
                    disabledForegroundColor:
                        Color(0xff2865DC).withOpacity(0.38),
                    disabledBackgroundColor:
                        Color(0xff2865DC).withOpacity(0.12),
                    padding: EdgeInsets.all(10),
                  ),
                  child: Icon(Icons.send)
                  // Image.asset(
                  //   // (msgcontroller.value.text == "t")
                  //   //     ? "assets/mic.png"
                  //   //     : "assets/send1.png",
                  //   "assets/send1.png",
                  //   color: Colors.white,
                  //   height: 36,
                  //   width: 27,
                  // ),
                  ),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: _showMessageArea()
                ),
              ),
            _sendMessageArea()
            ]
          )
        )
    );
  }

  getMessageList(){
    _msgList = [
      {"userId": 1, "reqAnsGubun": "r", "text": "request12", "sendDt": "20230227"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer11", "sendDt": "20230226"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer10", "sendDt": "20230225"},
      {"userId": 1, "reqAnsGubun": "r", "text": "request9", "sendDt": "20230227"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer8", "sendDt": "20230226"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer7", "sendDt": "20230225"},
      {"userId": 1, "reqAnsGubun": "r", "text": "request6", "sendDt": "20230227"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer5", "sendDt": "20230226"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer4", "sendDt": "20230225"},
      {"userId": 1, "reqAnsGubun": "r", "text": "request3", "sendDt": "20230227"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer2", "sendDt": "20230226"},
      {"userId": 1, "reqAnsGubun": "a", "text": "answer1", "sendDt": "20230225"},
    ];
  }

  processMessage() {
    String msg = getCurrInputMessage();

    if (msg != "") {
      appendNewMessage(ChatModel.makeMessage(reqAnsGubun: "r", text: msg));
      reloadMessageView();
    }
    msgInputController.clear();

    sendMessage(msg);
  }

  getCurrInputMessage() {
    return msgInputController.text.trim();
  }

  appendNewMessage(map){
    _msgList.insert(0, map);
  }

  reloadMessageView() {
    setState(() {
      //_msgList;
    });
  }

  insertMessage(map) {
    // insert data to DB
    // 성공 실패에 따른 처리 다시 보내기
  }

  Future<void> sendMessage(msg) async {
    // send the message to chatGPT
    // 성공 실패에 따른 처리 다시 보내기
    // Map<String, String> chatModel = ApiService.callAPI(message: msg) as Map<String, String>;
    Map<String, String> chatModel = await ApiService.callAPI(message: msg);
    print("[sendMessage] userId :: ${chatModel["userId"]}\n reqAnsGubun :: ${chatModel["reqAnsGubun"]}\n text :: ${chatModel["text"]}\n sendDt :: ${chatModel["sendDt"]}" );
    appendNewMessage(chatModel);
    reloadMessageView();
  }

  playMessage(){

  }
}