import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

void downloadFile() async {
  var httpClient = new HttpClient();
  String url='https://i.postimg.cc/3Rn7cRrb/hasher-happy-sticker.gif';
  String filename='sticker.gif';
  var request = await httpClient.getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  // String? dir = (await getExternalStorageDirectory())?.path;
  Directory dir = Directory('/storage/emulated/0/Download/update');
  var savePath = dir.path;
  File file = new File('$savePath/$filename');
  await file.writeAsBytes(bytes);
}
