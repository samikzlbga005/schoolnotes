import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:schoolnotes/provider/drag_drop_provider.dart';

class SampleDragAndDrop extends StatefulWidget {
  const SampleDragAndDrop({Key? key}) : super(key: key);
  @override
  _SampleDragAndDropState createState() => _SampleDragAndDropState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class _SampleDragAndDropState extends State<SampleDragAndDrop> {
  List<String> list = [
    "Na",
    "Cl",
    "O",
    "H\u2082",
    "O\u2082",
    "S",
    "O\u2084",
    "Ca",
    "C",
    "O\u2083",
    "OH",
    "H",
    "N",
    "(OH)\u2082",
    "K",
    "H\u2083"
  ];
  List<String> compounds = [
    "H\u2082O",
    "H\u2082SO\u2084",
    "CaCO\u2083",
    "NaOH",
    "HCl",
    "NaCl",
    "Ca(OH)\u2082",
    "KOH",
    "HNO\u2083",
  ];

  List<String> resultList = [
    "Su",
    "Zaç Yağı",
    "Kireç Taşı",
    "Sud Kostik",
    "Tuz Ruhu",
    "Yemek Tuzu",
    "Sönmüş Kireç",
    "Potas Kostik",
    "Kezzap"
  ];
  var addedItems = <String>[];

  List<Widget> asd = [
    Lottie.asset(
      'assets/boom.json',
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    ),
    Lottie.asset(
      'assets/first_cauldron.json',
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    ),
    Lottie.asset(
      'assets/done_compound.json',
      width: 300,
      height: 300,
      fit: BoxFit.cover,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kimya Laboratuvarı"),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.reset_tv,
                color: Colors.white,
              ),
              onPressed: () {
                clearAll();
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Text("Diğer bileşikler sağa için kaydır"),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      padding: EdgeInsets.all(3),
                      child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return compoundsWidget(list[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                "Bileşik: " + context.watch<DragProvider>().coumpoundString,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              context.watch<DragProvider>().isBom != "Bileşik Bulunamadı"
                  ? Text(
                      "Sonuç: ${context.watch<DragProvider>().resultval}",
                      style: TextStyle(fontSize: 20),
                    )
                  : Text(
                      "Bileşik Bulunamadı",
                      style: TextStyle(fontSize: 20),
                    ),
              DragTarget<String>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: getBow(addedItems),
                    ),
                  );
                },
                onWillAccept: (data) {
                  if (list.contains(data)) {
                    return true;
                  } else {
                    return false;
                  }
                },
                onAccept: (data) {
                  setState(() {
                    if (!addedItems.contains(data)) {
                      addedItems.add(data);
                      Provider.of<DragProvider>(context, listen: false)
                          .coumpoundString += data;
                    }
                  });
                },
                onLeave: (data) {},
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        clearAll();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                    ),
                    child: Text("Sıfırla"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      search(context.read<DragProvider>().coumpoundString);
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                    ),
                    child: Text("Araştır"),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  void clearAll() {
    setState(() {
      addedItems.clear();
      Provider.of<DragProvider>(context, listen: false).coumpoundString = "";
      Provider.of<DragProvider>(context, listen: false).stateCompound = false;
      Provider.of<DragProvider>(context, listen: false).isSearch = false;
      Provider.of<DragProvider>(context, listen: false).resultval = "";
      Provider.of<DragProvider>(context, listen: false).isBom = "";
    });
  }

  void result() {}

  bool search(String val) {
    if (compounds.contains(val)) {
      int index = compounds.indexOf(val);
      Provider.of<DragProvider>(context, listen: false).resultval =
          resultList[index];
      Provider.of<DragProvider>(context, listen: false).isBom = "";

      Provider.of<DragProvider>(context, listen: false).stateCompound = true;
      Provider.of<DragProvider>(context, listen: false).isSearch = false;

      return true;
    } else {
      Provider.of<DragProvider>(context, listen: false).stateCompound = false;
      Provider.of<DragProvider>(context, listen: false).isSearch = true;
      Provider.of<DragProvider>(context, listen: false).isBom =
          "Bileşik Bulunamadı";
      return false;
    }
  }

  Widget getBow(List<String> selectedData) {
    if (selectedData.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.green[200], borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text("Buraya Bırakın"),
        ),
      );
    } else {
      if (context.watch<DragProvider>().isSearch) {
        return middle(asd[0]);
      }
      if (context.watch<DragProvider>().stateCompound) {
        return middle(asd[2]);
      } else {
        return middle(asd[1]);
      }
    }
    /*if (selectedData.contains("Na") && selectedData.contains("Cl")) {
      return middle(asd[2], selectedData[0] + selectedData[1]);
    } else if (selectedData.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.green[200], borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text("Buraya Bırakın"),
        ),
      );
    } else {
      return middle(asd[1], "");
    }*/
  }

  Widget middle(Widget url) {
    return Stack(
      children: [
        url,
      ],
    );
  }

  Widget compundsItem(String str) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(
              50,
            )),
        child: Center(child: Text(str)),
      ),
    );
  }

  Widget compoundsWidget(String str) {
    return Visibility(
      visible: !addedItems.contains(str),
      child: Draggable<String>(
        data: str,
        child: compundsItem(str),
        feedback: compundsItem(str),
        childWhenDragging: compundsItem(str),
      ),
    );
  }
}
