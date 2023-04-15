import 'dart:async';

import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/ChatRoleType.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/widgets/async_action_button.dart';
import 'package:dream_catcher/widgets/labeled_text_field.dart';
import 'package:dream_catcher/widgets/self_saving_text_field.dart';
import 'package:dream_catcher/widgets/simple_button.dart';
import 'package:dream_catcher/widgets/spaced_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleDreamScreen extends StatefulWidget {
  final String? dreamId;
  const SingleDreamScreen({super.key, this.dreamId});

  @override
  State<SingleDreamScreen> createState() => _SingleDreamScreenState();
}

class _SingleDreamScreenState extends State<SingleDreamScreen> {
  late TextEditingController _titleEditingController;
  late TextEditingController _textEditingController;

  late FocusNode _focusNode;
  late FocusNode _titleFocusNode;
  Timer? _debounce;

  String? _currentDreamId;
  String? _currentChatId;
  final DreamService _dreamService = getIt<DreamService>();
  final ChatService _chatService = getIt<ChatService>();

  @override
  void initState() {
    super.initState();
    _currentDreamId = widget.dreamId;
    Dream? dream = _dreamService.getDreamById(widget.dreamId);
    _chatService.fetchDreamChats(_currentDreamId);
    _textEditingController = TextEditingController();
    _titleEditingController = TextEditingController(text: dream?.title ?? '');
    _focusNode = FocusNode();
    _titleFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textEditingController.dispose();
    _titleEditingController.dispose();
    _focusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatService, DreamService>(
      builder: (context, chatService, dreamService, child) {
        List<Chat> chatList = chatService.getChatListById(_currentDreamId) ?? [];
        return Material(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Styles.deepOceanBlue, Styles.black],
                  )),
                  child: SingleChildScrollView(
                    child: SpacedColumn(
                      height: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Styles.white,
                            )),
                        SizedBox(
                            width: 400,
                            child: SelfSavingTextField(
                              _titleEditingController,
                              focusNode: _titleFocusNode,
                              onChanged: (value) => _onTitleChanged(value),
                              hintText: "Dream Title",
                            )),
                        // result
                        chatList.isNotEmpty
                            ? Flexible(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: chatList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                          children: [
                                            Wrap(children: [
                                              Text(
                                                _getRoleLabel(chatList[index].role),
                                                style: Styles.uiMediumItalic,
                                                textAlign: TextAlign.start,
                                              ),
                                              Center(
                                                child: Text(
                                                  chatList[index].text ?? '',
                                                  style: Styles.uiSemiBoldMedium,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ]),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      );
                                    }))
                            : Container(),
                        SizedBox(
                            width: 400,
                            height: 100,
                            child: LabeledTextField(
                              focusNode: _focusNode,
                              controller: _textEditingController,
                              label: '',
                              hint: chatList.isNotEmpty ? "Reply.." : "Write your dream",
                            )),
                        AsyncActionButton(
                          width: 200,
                          height: 50,
                          label: "Analyze",
                          buttonVariant: ButtonVariant.PRIMARY,
                          onPressed: () async {
                            await _saveChat(_textEditingController.text, chatService);
                            List<Chat> chatList = chatService.getChatListById(_currentDreamId) ?? [];
                            if (chatList.isNotEmpty) {
                              analyzeDream(chatList);
                            }
                          },
                        ),
               
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _getRoleLabel(ChatRoleType? type) {
    if (type == ChatRoleType.ASSISTANT) {
      return "Wizard : ";
    } else {
      return "Me : ";
    }
  }

  _onTitleChanged(String value) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      String? dreamId = await _dreamService.createOrUpdateDream(
        _currentDreamId,
        _titleEditingController.text,
      );
      setState(() {
        _currentDreamId = dreamId;
      });
    });
  }

  Future<void> _saveChat(String value, ChatService chatService) async {
    String? dreamId = _currentDreamId;
    if (_currentDreamId == null) {
      dreamId = await _dreamService.createOrUpdateDream(
        _currentDreamId,
        _titleEditingController.text,
      );
    }
    if (_currentChatId != null) {
      await _chatService.updateChat(
        _currentChatId!,
        dreamId!,
        _textEditingController.text,
      );
    } else {
      _currentChatId = await _chatService.createChat(
        dreamId!,
        _textEditingController.text,
        ChatRoleType.USER,
      );
    }
    return;
  }

  Future<void> analyzeDream(List<Chat> chatList) async {
    String? response = await ApiService.sendMessage(list: chatList);
    if (response != null && response.isNotEmpty) {
      _chatService.createChat(
        _currentDreamId!,
        response,
        ChatRoleType.ASSISTANT,
      );
    }
    setState(() {
      _currentChatId = null;
      _textEditingController.clear();
      _focusNode.unfocus();
      _titleFocusNode.unfocus();
      _titleFocusNode.unfocus();
    });
  }
}
