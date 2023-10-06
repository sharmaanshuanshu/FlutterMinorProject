import 'dart:io';
import 'package:file_picker/file_picker.dart';
class MultiFileUpload {
  pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      // Allow the selection of multiple files
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'jpg',
        'png',
        'jpeg'
      ], // Specify the allowed file types
    );
    return result?.paths.map((path) => File(path!)).toList();
  }
}