import 'dart:html';

import 'package:frontend/widgets/list_item.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class FileUploadWithHttp extends StatefulWidget {
  const FileUploadWithHttp({Key? key}) : super(key: key);

  @override
  _FileUploadWithHttpState createState() => _FileUploadWithHttpState();
}

class _FileUploadWithHttpState extends State<FileUploadWithHttp> {
  PlatformFile objFile = PlatformFile(name: 'no file', size: 0);
  bool _isLoadingList = false;
  var selectedCard;

  var files = [];

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
    }
  }

  void uploadSelectedFile() async {
//---Create http package multipart request object
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("http://127.0.0.1:5000/file"),
    );
    //-----add other fields if needed
    //request.fields["id"] = "abc";

    //-----add selected file with request
    if (objFile.readStream != null) {
      request.files.add(http.MultipartFile("file",
          objFile.readStream ?? http.ByteStream.fromBytes([]), objFile.size,
          filename: objFile.name));
    }

    //-------Send request
    var resp = await request.send();

    //------Read response
    String result = await resp.stream.bytesToString();

    //-------Your response
    print(result);
  }

  void updateFileList() async {
    setState(() {
      _isLoadingList = true;
    });
    try {
      final newFiles = await getFiles();
      if (newFiles.length > 0) {
        setState(() {
          files = newFiles;
          _isLoadingList = false;
        });
      } else {
        //TODO handle empty file list
      }
    } catch (e) {
      //TODO handle network error
    }
  }

  deleteEntry(toDelete) async {
    var statusCode = await deleteFile(toDelete);
    if (statusCode == 201) {
      setState(() {
        files.remove(toDelete);
      });
    }
    //TODO ADD ERROR MESSAGE
  }

  updateSelectedCard(newSelectedCard) {
    setState(() {
      selectedCard = newSelectedCard;
    });
  }

  @override
  void initState() {
    updateFileList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 350,
          child: _isLoadingList
              ? const Center(child: LinearProgressIndicator())
              : ListView(children: [
                  ...files.map((file) {
                    return ListItem(
                        file, selectedCard, updateSelectedCard, deleteEntry);
                  }).toList()
                ]),
        ),
        //------Button to choose file using file picker plugin
        TextButton(
            child: Text("Choose File"),
            onPressed: () => chooseFileUsingFilePicker()),
        //------Show file name when file is selected
        if (objFile != null) Text("File name : ${objFile.name}"),
        //------Show file size when file is selected
        if (objFile != null) Text("File size : ${objFile.size} bytes"),
        //------Show upload utton when file is selected
        TextButton(
            child: Text("Upload"), onPressed: () => uploadSelectedFile()),
      ],
    );
  }
}
