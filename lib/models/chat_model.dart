class ChatModel {
  static Map<String, String> makeMessage({required String reqAnsGubun, 
                                  required String text}) {
    // 추후 userId는 session에서 가져오도록
    String userId = "1";
    // 추후 sendDt Common 함수 호출하여 가져오도록
    String sendDt = "20230227";

    Map<String, String> map = {};
    map["userId"] = reqAnsGubun == "r" ? userId : "API_CHAT_GPT";
    map["reqAnsGubun"] = reqAnsGubun;
    map["text"] = text;
    map["sendDt"] = sendDt;
    return map;
  }
}

