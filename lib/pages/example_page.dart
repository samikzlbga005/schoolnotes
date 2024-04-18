import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  List<String> titles = [
    "Olaylar ve Durumlar",
    "İlk Hikaye Örneği",
    "Yapı Unsurları",
    "Kişi Sayısı",
    "Mekan",
    "Zaman"
  ];

  List<String> newTitles = [
    "Olay",
    "Mekan",
    "Zaman",
    "Kişiler",
  ];

  List<Map<String, dynamic>> list = [
    {
      "Olaylar ve Durumlar":
          "Hikaye, genellikle yaşanmış ya da yaşanması muhtemel olayları anlatır. Olaylar romanlara göre daha kısa sürede anlatılır ve okuyucuya derin bir etki bırakacak şekilde düzenlenir. Ayrıca, hikayelerde olay ve durum olmak üzere iki farklı tür bulunabilir."
    },
    {
      "İlk Hikaye Örneği":
          "Hikayenin edebi tür olarak kabul edilmesinden önce, Boccaccio’nun “Decameron” adlı eseri ilk hikaye örneği olarak kabul edilir. Türk edebiyatındaki ilk hikaye kitabı ise Ahmet Mithat Efendi’nin “Letaif-i Rivayat”tır."
    },
    {
      "Yapı Unsurları":
          "Hikayeler, olay, kişi, zaman ve mekan olmak üzere dört temel yapı unsurunu içerir. Olaylar, genellikle belirli bir plana göre ilerler: serim, düğüm ve çözüm."
    },
    {
      "Kişi Sayısı":
          "Hikayelerde romana göre daha az sayıda karakter bulunur. Kişiler genellikle “tip” olarak tanıtılır ve karakterin sadece hikaye boyunca önemli olan özellikleri vurgulanır."
    },
    {
      "Mekan":
          "Hikayeler, sınırlı bir çevre içinde geçer. Mekanın detayları genellikle kısa ve öz bir şekilde ifade edilir."
    },
    {
      "Zaman":
          "Hikayeler, genellikle kısa bir zaman diliminde geçer. Zaman, geçmiş zamana göre anlatılır ve konu genellikle olayın sona ermesinden başlayarak geriye doğru anlatılır."
    }
  ];

  List<Map<String, String>> newList = [
    {
      "Olay":
          "Hikayenin temel öğesi veya durumudur. Hikaye, kahramanın başından geçen olayları ya da durumları anlatır. Yardımcı olaylar da bazen asıl olayı tamamlar."
    },
    {
      "Mekan":
          "Hikayede sınırlı bir çevre bulunur. Mekanın tasviri genellikle kısa ve öz olup, okuyucuya ipuçları verir."
    },
    {
      "Zaman":
          "Hikaye, kısa bir zaman diliminde geçer ve genellikle geçmiş zamana göre anlatılır. Zamanın düzeni olayın anlatımına göre şekillenir."
    },
    {
      "Kişiler":
          "Hikayede az sayıda karakter bulunur. Bu karakterler genellikle “tip” olarak tanıtılır ve belirli özellikleriyle vurgulanır."
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hikaye Nedir?"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Hikaye Nedir?",
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  "Hikaye, yaşanmış veya yaşanması muhtemel olayların okuyucuya haz verecek şekilde anlatıldığı kısa edebi yazılara denir. Hikaye, olaylarını kısa ve etkileyici bir şekilde sunarak okuyucunun duygusal bir deneyim yaşamasını amaçlar. İşte hikayenin bazı özellikleri:",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  softWrap: true, // Enable text wrapping
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < list.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${i + 1}. ${titles[i]}:", // Display index number and title
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${list[i]["${titles[i]}"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  "Hikayeyi Oluşturan Unsurlar:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  softWrap: true, // Enable text wrapping
                  textAlign: TextAlign.justify,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < newList.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${i + 1}. ${newTitles[i]}:", // Display index number and title
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${newList[i]["${newTitles[i]}"]}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  "Hikaye, okuyucuya kısa ve etkili bir deneyim sunarak, duygusal bir bağ kurmasını amaçlar. Hikayenin kurgusu, yaratıcılık ve etkileyici anlatımıyla öne çıkar.",
                  style: TextStyle(fontSize: 16),
                  softWrap: true, // Enable text wrapping
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
