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

  var selectedCard = "";

  var allFiles = [];
  var loadedFiles = [];
  var errorFiles = [];

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
        if (!allFiles.contains(objFile.name)) {
          allFiles.add(objFile.name);
        }
      });
      try {
        var uploadStatusCode = await uploadSelectedFile(objFile);
        if (uploadStatusCode == 201) {
          setState(() => _isLoadingCard = "");
        } else {
          //to catch network and sever errors in the same basket
          throw Error();
        }
      } catch (e) {
        setState(() {
          errorFiles.add(objFile.name);
          _isLoadingCard = "";
        });
      }
    }
  }

  void updateFileList() async {
    setState(() {
      _isLoadingList = true;
    });
    try {
      final newFilesNames = await getFiles();
      if (newFilesNames.length > 0) {
        setState(() {
          loadedFiles = newFilesNames;
          //if a file previously gave error but not now remove it
          for (var filename in errorFiles) {
            if (loadedFiles.contains(filename)) {
              errorFiles.remove(filename);
            }
          }
          allFiles = List.from(loadedFiles)..addAll(errorFiles);
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
        allFiles.remove(toDelete);
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
                  ...allFiles.map((file) {
                    return ListItem(file, selectedCard, _isLoadingCard,
                        errorFiles, updateSelectedCard, deleteEntry);
                  }).toList()
                ]),
        ),
        //------Button to choose file using file picker plugin
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                child: Text(
                  "Upload File",
                ),
                onPressed: _isLoadingCard == "" && !_isLoadingList
                    ? () => chooseFileUsingFilePicker()
                    : null),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Tooltip(
                message: _isLoadingCard == "" &&
                        selectedCard != "" &&
                        !errorFiles.contains(selectedCard)
                    ? ""
                    : "Select a file",
                child: ElevatedButton(
                  // or _isLoadingCard != selectedCard if I want to go to the next page without waiting for upload
                  onPressed: _isLoadingCard == "" &&
                          selectedCard != "" &&
                          !errorFiles.contains(selectedCard)
                      ? () => chooseFileUsingFilePicker()
                      : null,
                  child: Text(
                    "Get Results",
                  ),
                ),
              ),
            )
          ],
        ),

        //todo send also file size
        //if (objFile != null) Text("File size : ${objFile.size} bytes"),
        //------Show upload utton when file is selected
      ],
    );
  }
}
