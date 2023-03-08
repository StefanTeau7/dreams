import 'package:dream_catcher/models/dream.dart';
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (newContext) => SingleDreamScreen()),
            );
          }),
    );
  }

  _buildDreamGrid() {
    List<Dream> myDreams = DreamService.getAllMyDreams();
    return GridView.builder(
        itemCount: myDreams.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300, mainAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemBuilder: (context, i) {
          return DreamCard(
            height: 200,
            color: Styles.wine.withOpacity(0.7),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Text(
              //   myDreams[i].subject,
              //   style: Styles.uiBoldLarge,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Expanded(
              //   child: Text(
              //     myDreams[i].summary ?? '',
              //     style: Styles.uiMedium,
              //     overflow: TextOverflow.fade,
              //   ),
              // )
            ]),
          );
        });
  }
}
