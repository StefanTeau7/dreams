import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/dream_card.dart';
import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DreamCollection extends StatefulWidget {
  const DreamCollection({super.key});

  @override
  State<DreamCollection> createState() => _DreamCollectionState();
}

class _DreamCollectionState extends State<DreamCollection> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<DreamService, ChatService>(
      builder: (context, dreamService, chatService, child) {
        List<Dream>? myDreams = dreamService.getAllMyDreams();
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Styles.deepOceanBlue, Styles.black],
            )),
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Styles.deepOceanBlue, Styles.black],
              )),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: ListView(
                  children: [
                    Text(
                      "My Dreams",
                      style: Styles.headlineLarge.copyWith(color: Styles.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildDreamGrid(myDreams, chatService),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SimpleButton(
                        height: 50,
                        label: "Logout",
                        onPressed: () {
                          Amplify.Auth.signOut();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: _getFloatingButton(),
        );
      },
    );
  }

  _getFloatingButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 60.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Styles.mistyBlue,
          child: const Icon(
            Icons.add,
            color: Styles.deepOceanBlue,
          ),
          onPressed: () => _pushNewDreamScreen(),
        ),
      ),
    );
  }

  _buildDreamGrid(List<Dream>? myDreams, ChatService chatService) {
    if (myDreams == null || myDreams.isEmpty) {
      return Center(
        child: Text(
          "No dreams yet",
          style: Styles.headlineLarge.copyWith(color: Styles.white),
        ),
      );
    }
    return GridView.builder(
      shrinkWrap: true,
      itemCount: myDreams.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
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
          color: Styles.mistyBlue.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  myDreams[i].title ?? '',
                  style: Styles.uiBoldLarge,
                ),
                Text(
                  "${dateTimeToMediumString(myDreams[i].updatedAt?.getDateTimeInUtc())}",
                  style: Styles.uiSmall,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static String? dateTimeToMediumString(DateTime? d) {
    if (d == null) return null;
    DateTime localTime = d.toLocal();
    String date = DateFormat('MMMM dd').format(localTime);
    return date;
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
