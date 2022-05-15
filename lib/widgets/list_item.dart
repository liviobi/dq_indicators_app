import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final filename;
  var selectedCard;
  var isLoadingCard;
  List errorFiles;
  Function updateSelectedCard;
  Function deleteEntry;

  ListItem(this.filename, this.selectedCard, this.isLoadingCard,
      this.errorFiles, this.updateSelectedCard, this.deleteEntry,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => updateSelectedCard(filename),
      child: Container(
        child: Card(
          elevation: filename == selectedCard ? 5 : 1,
          child: ListTile(
            leading: LayoutBuilder(builder: (context, constraints) {
              if (filename == isLoadingCard) {
                return const CircularProgressIndicator();
              } else if (errorFiles.contains(filename)) {
                return const Icon(
                  Icons.error,
                  color: Colors.redAccent,
                );
              } else {
                return const Icon(
                  Icons.check,
                  color: Colors.green,
                );
              }
            }),
            title: Text(filename),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete),
              iconSize: 20,
              onPressed: () => deleteEntry(filename),
            ),
          ),
        ),
      ),
    );
  }
}
