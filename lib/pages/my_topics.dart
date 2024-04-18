import 'package:schoolnotes/components/app_bar.dart';
import 'package:schoolnotes/components/drawer.dart';
import 'package:schoolnotes/pages/unit_page.dart';
import 'package:schoolnotes/provider/save_topic_provider.dart';
import 'package:schoolnotes/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTopics extends StatelessWidget {
  const MyTopics({super.key});

  @override
  Widget build(BuildContext context) {
    final topicProvider = Provider.of<SaveTopicProvider>(context, listen: true);
    print(context.read<UserProvider>().loginUser.notes);
    return Scaffold(
      appBar: AppBarCustom(context, "Kaydedilen Notlar"),
      endDrawer: drawerHomePage(context),
      body: SafeArea(
        child: FutureBuilder<List<String>?>(
          future: topicProvider
              .listMyTopics(context.read<UserProvider>().loginUser),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final topics = snapshot.data ?? [];
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.8, // Adjust the width as needed
                child: ListView.builder(
                  itemCount: topics.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(topics[index]),
                                GestureDetector(
                                  child: !topicProvider.isExist(topics[index])
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
                                        context.read<UserProvider>().loginUser,
                                        topics[index]);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UnitPage(
                                title_unit: "Konu Adı",
                                path: "assets/bio.pdf",
                              ),
                            ),
                          );*/
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
