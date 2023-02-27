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
  const SingleDreamScreen({super.key});

  @override
  State<SingleDreamScreen> createState() => _SingleDreamScreenState();
}

class _SingleDreamScreenState extends State<SingleDreamScreen> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatService, ModelService>(
      builder: (context, chatService, modelService, child) {
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
                            onSubmitted: (value) async {
                              await sendMessage(
                                modelService,
                                chatService,
                              );
                            },
                          )),
                      // button
                      SimpleButton(
                        width: 200,
                        label: "Analyze",
                        buttonVariant: ButtonVariant.PRIMARY,
                        onPressed: () {
                          sendMessage(modelService, chatService);
                        },
                      ),
                      // result
                      Flexible(
                        child: ListView.builder(
                            // controller: _listScrollController,
                            itemCount: chatService.getChatList.length, //chatList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DreamCard(
                                  width: 600,
                                  child: Column(children: [
                                    Text(
                                      chatService.getChatList[index].msg,
                                      style: Styles.headlineLarge,
                                    ),
                                  ]),
                                ),
                              );
                            }),
                      ),
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
      // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
      chatService.addUserMessage(msg: _textEditingController.text);
    });
    await chatService.sendMessageAndGetAnswers(
        msg: _textEditingController.text, chosenModelId: modelService.getCurrentModel);

    setState(() {
      _textEditingController.clear();
      _focusNode.unfocus();
    });
  }
}
