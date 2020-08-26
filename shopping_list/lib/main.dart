import 'package:flutter/material.dart';
import 'package:shopping_list/ui/items_screen.dart';
import './utils/dbhelper.dart';
import './models/list_items.dart';
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
      home: Scaffold(
        appBar: AppBar(title: Text('Shopping List')),
        body: Shlist(),
      ),
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
    return ListView.builder(
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
        );
      },
    );
  }
}
