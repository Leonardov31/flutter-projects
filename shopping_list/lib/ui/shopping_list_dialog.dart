import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/models/shopping_list.dart';
import 'package:shopping_list/utils/dbhelper.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  Widget buildDialog(BuildContext context, ShoppingList list, bool isNew) {
    DbHelper helper = DbHelper();
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }

    return AlertDialog(
      title: Text((isNew) ? 'New Shopping list' : 'Edit shopping list'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: 'Shopping List Name',
              ),
            ),
            TextField(
              controller: txtPriority,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Shopping List Priority (1 - 3)',
              ),
            ),
            RaisedButton(
              child: Text('Save Shopping List'),
              onPressed: () {
                list.name = txtName.text;
                list.priority = int.parse(txtPriority.text);
                helper.insertList(list);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
