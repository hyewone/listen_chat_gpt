import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:litsen_chat_gpt/constants/api_consts.dart';
import 'package:litsen_chat_gpt/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litsen_chat_gpt/services/api_services.dart';

// import '../models/chat_models.dart';

class ApiService {
  // static Future<List<ModelsModel>> getModels() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse("$Base_url/models"),
  //       headers: {'Authorization': 'Bearer $Api_key'},
  //     );

  //     Map jsonResponse = jsonDecode(response.body);

  //     if (jsonResponse['error'] != null) {
  //       // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
  //       throw HttpException(jsonResponse['error']["message"]);
  //     }
  //     // print("jsonResponse $jsonResponse");
  //     List temp = [];
  //     for (var value in jsonResponse["data"]) {
  //       temp.add(value);
  //       // log("temp ${value["id"]}");
  //     }
  //     return ModelsModel.modelsFromSnapshot(temp);
  //   } catch (error) {
  //     //log("error $error");
  //     rethrow;
  //   }
  // }

  // Send Message fct
  static Future<Map<String, String>> callAPI({required String message}) async {
    try {
      //log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$Base_url/completions"),
        headers: {
          'Authorization': 'Bearer $Api_key',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      print("jsonResponse ::: " + jsonResponse.toString());
      print("jsonResponse['choices'].length ::: " +  jsonResponse["choices"].length.toString());

      Map<String, String> chatModel = {};

      if (jsonResponse['error'] == null) {
        if (jsonResponse["choices"].length > 0) {
          chatModel = ChatModel.makeMessage(reqAnsGubun: "a", text: jsonResponse["choices"][0]["text"]);
        }
      }else{
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      return chatModel;
      
      // List<ChatModel> chatList = [];
      // if (jsonResponse["choices"].length > 0) {
      //   // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
      //   chatList = List.generate(
      //     jsonResponse["choices"].length,
      //         (index) => ChatModel(
      //       msg: jsonResponse["choices"][index]["text"],
      //       chatIndex: 1,
      //     ),
      //   );
      // }
      // return chatList;
    } catch (error) {
      //log("error $error");
      rethrow;
    }
  }
}

// class ApiService {
//   static Future<List<ModelsModel>> getModels() async {
//     try {
//       var response = await http.get(
//         Uri.parse("$Base_url/models"),
//         headers: {'Authorization': 'Bearer $Api_key'},
//       );

//       Map jsonResponse = jsonDecode(response.body);

//       if (jsonResponse['error'] != null) {
//         // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
//         throw HttpException(jsonResponse['error']["message"]);
//       }
//       // print("jsonResponse $jsonResponse");
//       List temp = [];
//       for (var value in jsonResponse["data"]) {
//         temp.add(value);
//         // log("temp ${value["id"]}");
//       }
//       return ModelsModel.modelsFromSnapshot(temp);
//     } catch (error) {
//       //log("error $error");
//       rethrow;
//     }
//   }

//   // Send Message fct
//   static Future<List<ChatModel>> sendMessage(
//       {required String message, required String modelId}) async {
//     try {
//       //log("modelId $modelId");
//       var response = await http.post(
//         Uri.parse("$Base_url/completions"),
//         headers: {
//           'Authorization': 'Bearer $Api_key',
//           "Content-Type": "application/json"
//         },
//         body: jsonEncode(
//           {
//             "model": modelId,
//             "prompt": message,
//             "max_tokens": 300,
//           },
//         ),
//       );

//       Map jsonResponse = jsonDecode(response.body);

//       if (jsonResponse['error'] != null) {
//         // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
//         throw HttpException(jsonResponse['error']["message"]);
//       }
//       List<ChatModel> chatList = [];
//       if (jsonResponse["choices"].length > 0) {
//         // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
//         chatList = List.generate(
//           jsonResponse["choices"].length,
//               (index) => ChatModel(
//             msg: jsonResponse["choices"][index]["text"],
//             chatIndex: 1,
//           ),
//         );
//       }
//       return chatList;
//     } catch (error) {
//       //log("error $error");
//       rethrow;
//     }
//   }
// }