import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/dream_card.dart';
import 'package:flutter/material.dart';

class DreamCollection extends StatefulWidget {
  const DreamCollection({super.key});

  @override
  State<DreamCollection> createState() => _DreamCollectionState();
}

class _DreamCollectionState extends State<DreamCollection> {
  List<String> titles = ['scheme dream', 'fun dream', "scary dream"];
  List<String> dreams = [
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
    'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Styles.wine, Styles.black],
      )),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Dreams",
              style: Styles.headlineLarge.copyWith(color: Styles.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _buildDreamGrid(),
            ),
            _getFloatingButton(),
          ],
        ),
      ),
    );
  }

  _getFloatingButton() {
    return Center(
      child: FloatingActionButton(
          backgroundColor: Styles.blueLight,
          child: const Icon(
            Icons.add,
            color: Styles.wine,
          ),
          onPressed: () {
            DreamService.queryListItems();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (newContext) => SingleDreamScreen()),
            );
            // get dream creation
          }),
    );
  }

  _buildDreamGrid() {
    return GridView.builder(
        itemCount: titles.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, mainAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, i) {
          return DreamCard(
            height: 200,
            color: Styles.wine.withOpacity(0.7),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                titles[i],
                style: Styles.uiBoldLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  dreams[i],
                  style: Styles.uiMedium,
                  overflow: TextOverflow.fade,
                ),
              )
            ]),
          );
        });
  }
}
