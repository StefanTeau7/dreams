import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/dream_card.dart';
import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DreamCollection extends StatefulWidget {
  const DreamCollection({super.key});

  @override
  State<DreamCollection> createState() => _DreamCollectionState();
}

class _DreamCollectionState extends State<DreamCollection> {
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
            colors: [Styles.deepOceanBlue, Styles.black],
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
        backgroundColor: Styles.mistyBlue,
        child: const Icon(
          Icons.add,
          color: Styles.deepOceanBlue,
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
      itemCount: myDreams.length + 1,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemBuilder: (context, i) {
        if (i == myDreams.length) {
          return SimpleButton(
            height: 20,
            label: "Logout",
            onPressed: () {
              Amplify.Auth.signOut();
            },
          );
        }
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
          color: Styles.mistyBlue.withOpacity(0.3),
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
