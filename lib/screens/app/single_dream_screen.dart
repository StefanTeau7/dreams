import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/ChatRoleType.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
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
  late TextEditingController _titleEditingController;
  late TextEditingController _textEditingController;

  late FocusNode _focusNode;
  late FocusNode _titleFocusNode;
  Timer? _debounce;
  Timer? _chatDebounce;

  String? currentDreamId;
  final DreamService _dreamService = getIt<DreamService>();
  final ChatService _chatService = getIt<ChatService>();

  @override
  void initState() {
    super.initState();
    currentDreamId = widget.dreamId;
    _chatService.fetchDreamChats(currentDreamId);
    _textEditingController = TextEditingController();
    _titleEditingController = TextEditingController();
    _focusNode = FocusNode();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _chatDebounce?.cancel();
    _textEditingController.dispose();
    _titleEditingController.dispose();
    _focusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatService>(
      builder: (context, chatService, child) {
        List<Chat>? chatList = chatService.getChatListById(widget.dreamId);

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
                      SizedBox(
                          width: 400,
                          child: LabeledTextField(
                            color: Styles.yellow,
                            focusNode: _titleFocusNode,
                            controller: _titleEditingController,
                            onChanged: (value) => _onTitleChanged(value),
                            label: "Dream Title",
                          )),
                      // textfield
                      SizedBox(
                          width: 400,
                          child: LabeledTextField(
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            onChanged: (value) => _onTextChanged(value),
                            label: "Write your dream",
                          )),
                      // button
                      SimpleButton(
                        width: 200,
                        label: "Analyze",
                        buttonVariant: ButtonVariant.PRIMARY,
                        onPressed: () {
                          //   analyzeDream(dreamService);
                        },
                      ),
                      // result
                      chatList != null && chatList.isNotEmpty
                          ? Flexible(
                              child: ListView.builder(
                                  itemCount: chatList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DreamCard(
                                        color: Styles.wine,
                                        width: 600,
                                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            "${chatList[index].role} : ",
                                            style: Styles.uiMediumItalic,
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            chatList[index].text ?? '',
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

  _onTitleChanged(String value) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      String? dreamId = await _dreamService.createOrUpdateDream(
        currentDreamId,
        _titleEditingController.text,
      );
      setState(() {
        currentDreamId = dreamId;
      });
    });
  }

  _onTextChanged(String value) async {
    if (_chatDebounce?.isActive ?? false) _chatDebounce!.cancel();
    _chatDebounce = Timer(const Duration(milliseconds: 500), () async {
      String? dreamId = currentDreamId;
      if (currentDreamId == null) {
        dreamId = await _dreamService.createOrUpdateDream(
          currentDreamId,
          _titleEditingController.text,
        );
      }
      _chatService.createChat(
        dreamId!,
        _textEditingController.text,
        ChatRoleType.USER,
      );
    });
  }

  Future<void> analyzeDream(List<Chat> chatList) async {
    String? response = await ApiService.sendMessage(list: chatList);
    if (response != null && response.isNotEmpty) {
      _chatService.createChat(
        currentDreamId!,
        response,
        ChatRoleType.ASSISTANT,
      );
    }
    setState(() {
      _titleEditingController.clear();
      _textEditingController.clear();
      _focusNode.unfocus();
      _titleFocusNode.unfocus();
    });
  }
}
