import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/dream.dart';
import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/dream_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamCollection extends StatefulWidget {
  const DreamCollection({super.key});

  @override
  State<DreamCollection> createState() => _DreamCollectionState();
}

class _DreamCollectionState extends State<DreamCollection> {
  final DreamService dreamService = getIt<DreamService>();

  @override
  Widget build(BuildContext context) {
    return Consumer<DreamService>(
      builder: (context, dreamService, child) {
        List<Dream>? myDreams = dreamService.getAllMyDreams();
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
                  child: _buildDreamGrid(myDreams),
                ),
                _getFloatingButton(),
              ],
            ),
          ),
        );
      },
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
        onPressed: () => _pushNewDreamScreen(),
      ),
    );
  }

  _buildDreamGrid(List<Dream>? myDreams) {
    if (myDreams == null || myDreams.isEmpty) {
      return Center(
        child: Text(
          "No dreams yet",
          style: Styles.headlineLarge.copyWith(color: Styles.white),
        ),
      );
    }
    return GridView.builder(
      itemCount: myDreams.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300, mainAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemBuilder: (context, i) {
        return DreamCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (newContext) => SingleDreamScreen(
                  dreamId: myDreams[i].id,
                ),
              ),
            );
          },
          height: 200,
          color: Styles.wine.withOpacity(0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myDreams[i].title ?? '',
                style: Styles.uiBoldLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Text(
                  myDreams[i].conversation?.first.text ?? '',
                  style: Styles.uiMedium,
                  overflow: TextOverflow.fade,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _pushNewDreamScreen({String? dreamId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SingleDreamScreen(
                dreamId: dreamId,
              )),
    );
  }
}
