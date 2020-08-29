import 'package:flutter/material.dart';
import 'package:shopping_list/ui/items_screen.dart';
import 'package:shopping_list/ui/shopping_list_dialog.dart';
import './utils/dbhelper.dart';
import './models/shopping_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoppping List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Shlist(),
    );
  }
}

class Shlist extends StatefulWidget {
  @override
  _ShlistState createState() => _ShlistState();
}

class _ShlistState extends State<Shlist> {
  DbHelper helper = DbHelper();
  List<ShoppingList> shoppingList;
  ShoppingListDialog dialog;

  @override
  void initState() {
    dialog = ShoppingListDialog();
    super.initState();
  }

  Future showData() async {
    await helper.openDb();
    shoppingList = await helper.getLists();

    setState(() {
      shoppingList = shoppingList;
    });
  }

  @override
  Widget build(BuildContext context) {
    showData();
    return Scaffold(
      appBar: AppBar(title: Text('Shopping List')),
      body: ListView.builder(
        itemCount: (shoppingList != null) ? shoppingList.length : 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(shoppingList[index].name),
            leading: CircleAvatar(
              child: Text(shoppingList[index].priority.toString()),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemsScreen(
                    shoppingList: shoppingList[index],
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => dialog.buildDialog(
                    context,
                    shoppingList[index],
                    false,
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => dialog.buildDialog(
              context,
              ShoppingList(0, "", 0),
              true,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
