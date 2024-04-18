import 'package:schoolnotes/components/app_bar.dart';
import 'package:schoolnotes/components/drawer.dart';
import 'package:schoolnotes/pages/topic_list.dart';
import 'package:schoolnotes/provider/list_lessons_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lessons extends StatelessWidget {
  final String grade;
  const Lessons({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    final listLessonProvider =
        Provider.of<ListLessonsProvider>(context, listen: false);
    final lesson = listLessonProvider.getLessons(grade);

    Future<void> getPdf(String lessonName) async {
      Provider.of<ListLessonsProvider>(context, listen: false)
          .topicList
          .clear();
      Provider.of<ListLessonsProvider>(context, listen: false)
          .topicListPath
          .clear();
      if (lessonName == "Türkçe" && grade == "9. Sınıf") {
        Provider.of<ListLessonsProvider>(context, listen: false)
            .setTopics("Hikaye Nedir?");
        Provider.of<ListLessonsProvider>(context, listen: false)
            .setTopicsPath("Hikaye Nedir");
      }
      final storageRef =
          FirebaseStorage.instance.ref().child("${grade}/$lessonName/");
      final listResult = await storageRef.listAll();
      for (var item in listResult.items) {
        print("asdasdasdasdadasd -> ${item.fullPath}");
        Provider.of<ListLessonsProvider>(context, listen: false)
            .setTopics(item.name.substring(0, item.name.length - 4));
        Provider.of<ListLessonsProvider>(context, listen: false)
            .setTopicsPath(item.fullPath);
      }
    }

    return Scaffold(
      appBar: AppBarCustom(context, "Dersler"),
      endDrawer: drawerHomePage(context),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.82,
            child: ListView.builder(
              itemCount: listLessonProvider.lessons.length,
              itemBuilder: (context, index) {
                final gradeLesson = lesson[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                gradeLesson.values.first,
                                scale: 1,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    gradeLesson.keys.first,
                                    style: const TextStyle(fontSize: 20),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await getPdf(gradeLesson.keys.first);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TopicList(
                                  grade: grade,
                                  lessonName: gradeLesson.keys.first)));
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
}
