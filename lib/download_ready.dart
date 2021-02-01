import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:theta/theta.dart';

import 'get_last_image_url.dart';

Future<String> isDone(String id) async {
  var url = 'http://192.168.1.1/osc/commands/status';
  var data = {'id': id};

  var payload = jsonEncode(data);

  var response = await http.post(url,
      headers: {'Content-Type': 'application/json;charset=utf-8'},
      body: payload);

  Map<String, dynamic> status = jsonDecode(response.body);
  String state = status['state'];

  return state;
}

Future<String> downloadReady() async {
  print(
      "Test of taking picture and then checking to see if picture is ready for download");
  print("---");
  var takePictureResponse = await takePicture();
  String id = takePictureResponse['id'];
  print('The status ID is $id');

  bool keepGoing = true;
  int elapsedSeconds = 0;

  while (keepGoing) {
    var currentStatus = await isDone(id);
    // print(currentStatus);

    await new Future.delayed(const Duration(seconds: 1));
    print("Elapsed time: $elapsedSeconds seconds. State: $currentStatus");
    elapsedSeconds++;
    if (currentStatus == "done") {
      keepGoing = false;
    }
  }

  String fileUrl = await getLastImageUrl();
  print("picture ready for download at $fileUrl");
  return 'ready';
}
