/*import 'package:schoolnotes/components/drawer.dart';
import 'package:schoolnotes/provider/SaveTopicProvider.dart';
import 'package:schoolnotes/provider/save_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnitPage extends StatelessWidget {
  final String title;
  const UnitPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<SaveTopicProvider>(context, listen: true);
    final saveProvider = Provider.of<SaveUserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title),
          GestureDetector(
            child: !topicProvider.isExist(title)
                ? Image.asset(
                    "assets/save-instagram.png",
                    scale: 1.5,
                  )
                : Image.asset(
                    "assets/save-instagram-black.png",
                    scale: 1.5,
                  ),
            onTap: () {
              topicProvider.addTopic(saveProvider.loginUser, title);

              print(topicProvider.isExist(title));
            },
          )
        ],
      )),
      endDrawer: drawerHomePage(context),
      body: Container(
        child: Center(
          child: Text("asd"),
        ),
      ),
    );
  }
}
*/

/*
import 'package:schoolnotes/components/app_bar.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';
import 'package:schoolnotes/provider/save_topic_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';

class UnitPage extends StatefulWidget {
  final String title_unit;
  final String path;
  UnitPage({Key? key, required this.path, required this.title_unit})
      : super(key: key);

  @override
  _UnitPageState createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  late PdfController _pdfController;
  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.path),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<SaveTopicProvider>(context, listen: true);
    final saveProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBarCustom(context, widget.title_unit),
      body: Container(
        child: PdfView(
          controller: _pdfController,
        ),
      ),
    );
  }
}
*/

import 'dart:io';

import 'package:schoolnotes/components/app_bar.dart';
import 'package:schoolnotes/provider/drawer_provider.dart';
import 'package:schoolnotes/provider/save_topic_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class UnitPage extends StatefulWidget {
  final File file;
  const UnitPage({super.key, required this.file});

  @override
  State<UnitPage> createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final topicProvider = Provider.of<SaveTopicProvider>(context, listen: true);
    final saveProvider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  name.substring(0, name.length - 4),
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              child: !topicProvider.isExist(name.substring(0, name.length - 4))
                  ? Image.asset(
                      "assets/save-instagram.png",
                      scale: 1.5,
                    )
                  : Image.asset(
                      "assets/save-instagram-black.png",
                      scale: 1.5,
                    ),
              onTap: () {
                topicProvider.addTopic(
                    saveProvider.loginUser, name.substring(0, name.length - 4));

                print(
                    topicProvider.isExist(name.substring(0, name.length - 4)));
              },
            )
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            String data = "";
            Provider.of<DrawerProvider>(context, listen: false)
                .changeStateClick(data);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
