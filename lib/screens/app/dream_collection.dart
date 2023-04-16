import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/screens/app/single_dream_screen.dart';
import 'package:dream_catcher/services/chat_service.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer2<DreamService, ChatService>(
      builder: (context, dreamService, chatService, child) {
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
          child: SafeArea(
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
                    child: _buildDreamGrid(myDreams, chatService),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(20),
                  //   child: SimpleButton(
                  //     height: 50,
                  //     label: "Logout",
                  //     onPressed: () {
                  //       Amplify.Auth.signOut();
                  //     },
                  //   ),
                  // ),
                  _getFloatingButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _getFloatingButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
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
      itemCount: myDreams.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200, crossAxisSpacing: 20, mainAxisSpacing: 20),
      itemBuilder: (context, i) {
        String firstChat = '';
        List<Chat>? chats = chatService.getChatListById(myDreams[i].id);
        if (chats != null && chats.isNotEmpty && chats.first.text != null) {
          firstChat = chats.first.text!;
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
                  firstChat,
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
