import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/models/chat.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/model_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/dream_card.dart';
import 'package:dream_catcher/widgets/labeled_text_field.dart';
import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:dream_catcher/widgets/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleDreamScreen extends StatefulWidget {
  String? dreamId;
  SingleDreamScreen({super.key, this.dreamId});

  @override
  State<SingleDreamScreen> createState() => _SingleDreamScreenState();
}

class _SingleDreamScreenState extends State<SingleDreamScreen> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  String? dreamId;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    dreamId = widget.dreamId;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatService, ModelService>(
      builder: (context, chatService, modelService, child) {
        // Get Dream getDreamById();
        return Material(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Styles.wine, Styles.blue],
                  )),
                  child: SpacedColumn(
                    height: 20,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Styles.white,
                          )),
                      // textfield
                      SizedBox(
                          width: 400,
                          child: LabeledTextField(
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            onChanged: (value) {
                              print(value);
                            },
                            label: "Write your dream",
                          )),
                      // button
                      SimpleButton(
                        width: 200,
                        label: "Analyze",
                        buttonVariant: ButtonVariant.PRIMARY,
                        onPressed: () {
                          //        DreamService.createDream();
                          sendMessage(modelService, chatService);
                        },
                      ),
                      // result
                      dreamId != null
                          ? Flexible(
                              child: ListView.builder(
                                  // controller: _listScrollController,
                                  itemCount: chatService.getChatListById(dreamId)?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DreamCard(
                                        width: 600,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            chatService.getChatListById(dreamId)![index].text ?? '',
                                            style: Styles.uiSemiBoldMedium,
                                            textAlign: TextAlign.start,
                                          ),
                                        ]),
                                      ),
                                    );
                                  }))
                          : Container(),
                      SimpleButton(
                        label: "Logout",
                        onPressed: () {
                          Amplify.Auth.signOut();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> sendMessage(ModelService modelService, ChatService chatService) async {
    setState(() {
      chatService.addUserMessage(dreamID: dreamId!, text: _textEditingController.text);
    });

    List<Chat>? list = chatService.getChatListById(widget.dreamId);

    if (list != null) {
      await ApiService.sendMessage(
        dreamId: widget.dreamId!,
        list: list,
      );
    }

    setState(() {
      _textEditingController.clear();
      _focusNode.unfocus();
    });
  }
}
