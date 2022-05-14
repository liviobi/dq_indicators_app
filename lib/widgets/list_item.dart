import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final text;
  var selectedCard;
  Function updateSelectedCard;
  Function deleteEntry;

  ListItem(
      this.text, this.selectedCard, this.updateSelectedCard, this.deleteEntry,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => updateSelectedCard(text),
      child: Container(
        child: Card(
          elevation: text == selectedCard ? 5 : 1,
          child: ListTile(
            leading: const Icon(
              Icons.check,
              color: Colors.green,
            ),
            title: Text(text),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete),
              iconSize: 20,
              onPressed: () => deleteEntry(text),
            ),
          ),
        ),
      ),
    );
  }
}
