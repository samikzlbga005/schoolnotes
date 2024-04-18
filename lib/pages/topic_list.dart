import 'dart:io';

import 'package:schoolnotes/components/app_bar.dart';
import 'package:schoolnotes/components/drawer.dart';
import 'package:schoolnotes/pages/example_page.dart';
import 'package:schoolnotes/pages/unit_page.dart';
import 'package:schoolnotes/provider/list_lessons_provider.dart';
import 'package:schoolnotes/provider/save_topic_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:schoolnotes/service/pdf_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicList extends StatelessWidget {
  final String grade;
  final String lessonName;
  const TopicList({super.key, required this.grade, required this.lessonName});

  @override
  Widget build(BuildContext context) {
    List<String> topicListDefault =
        Provider.of<ListLessonsProvider>(context, listen: false).topicList;
    List<String> topicListDefaultPath =
        Provider.of<ListLessonsProvider>(context, listen: false).topicListPath;

    final topicProvider = Provider.of<SaveTopicProvider>(context, listen: true);
    final saveProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBarCustom(context, "Notlar"),
      endDrawer: drawerHomePage(context),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.9, // Adjust the width as needed
            child: ListView.builder(
              itemCount: topicListDefault.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                topicListDefault[index],
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  topicProvider.addTopic(
                                      context.read<UserProvider>().loginUser,
                                      topicListDefault[index]);
                                },
                                child: !topicProvider
                                        .isExist(topicListDefault[index])
                                    ? Image.asset(
                                        "assets/save-instagram.png",
                                        scale: 1.5,
                                      )
                                    : Image.asset(
                                        "assets/save-instagram-black.png",
                                        scale: 1.5,
                                      ),
                              )
                            ],
                          )),
                    ),
                    onTap: () async {
                      if (topicListDefault[index] == "Hikaye Nedir?") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExamplePage()));
                      } else {
                        final file = await PdfApi.loadFirebase(
                            topicListDefaultPath[index]);
                        if (file == null) return;
                        OpenPdf(context, file);
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void OpenPdf(BuildContext context, File file) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => UnitPage(file: file)));
}
