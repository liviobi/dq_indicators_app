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
  //PlatformFile objFile = PlatformFile(name: 'no file', size: 0);
  bool _isLoadingList = false;
  String _isLoadingCard = "";

  var selectedCard;

  var files = [];

  void chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var response = await FilePicker.platform.pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    );
    //if I don't pick a file result is null
    if (response != null) {
      PlatformFile objFile = response.files.single;
      setState(() {
        _isLoadingCard = objFile.name;
        files.add(objFile.name);
      });
      var uploadStatusCode = await uploadSelectedFile(objFile);
      if (uploadStatusCode == 201) {
        //change the status
      } else {
        //TODO HANDLE ERROR
      }
    }
  }

  uploadSelectedFile(PlatformFile objFile) async {
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

    return resp.statusCode;

    //------The response message
    //return resp.stream.bytesToString();
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

        //todo send also file size
        //if (objFile != null) Text("File size : ${objFile.size} bytes"),
        //------Show upload utton when file is selected
      ],
    );
  }
}
