import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_app/views/navigation_drawer.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const NavigationDrawerWidget(),
        appBar: AppBar(
          leading: (ModalRoute.of(context)?.canPop ?? false)
              ? const BackButton()
              : null, // Backbutton
          title: const Text('News'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: const ListViewNews(),
      );
}

// scrollable ListView
class ListViewNews extends StatelessWidget {
  const ListViewNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const Card(
            child: ListTile(
          title: Text('Fußball wird Olympisch'),
          subtitle: Text(
              'Nach langen Verhandlungen durch Helge Schneider mit dem Olympischen Kommitee wird Fußball...'),
        )),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News2'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News3'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News4'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News5'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News6'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News7'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News8'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News9'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News10'))),
        const Divider(color: Colors.white70),
        const Card(child: ListTile(title: Text('News11'))),
      ],
    );
  }
}
