import 'package:flutter/material.dart';
import 'package:proofhubmobileapplication/projects/ProjectSideMenu.dart';
import 'package:proofhubmobileapplication/projects/ProjectsSection.dart';

import '../channel/AddChannel.dart';

class AllProjects extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AllProjectsState();
}

class _AllProjectsState extends State<AllProjects> {
  @override
  Widget build(BuildContext context) {
    // var prjocetColor = [Colors.green,Colors.blue,Colors.amber,Colors.purple,Colors.greenAccent];
    // var projectTitle = [Text('First'),Text('Second'),Text('Third'),Text('Fourth'),Text('Fifth')];

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
          Row(
          children: [
          InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProjectSection()));
          },
          child: Container(
          color: Colors.grey,
          margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Row(
          children: [
          CircleAvatar(
          backgroundColor: Colors.green,
          ),
          Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
          'ProofHubDevelopment',
          style: TextStyle(fontSize: 20),
          ),
          )
          ],
          )),
          ),
          ],
          ),
              Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
        child: Text('ADD CHANNEL'),
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddChannel()));
        },
        ),
        )
            ],
          );
        },
        itemCount: 1,
      ),
    );
  }
}