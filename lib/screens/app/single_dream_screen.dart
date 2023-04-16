import 'dart:async';

import 'package:dream_catcher/di/dependency_injection.dart';
import 'package:dream_catcher/models/Chat.dart';
import 'package:dream_catcher/models/ChatRoleType.dart';
import 'package:dream_catcher/models/Dream.dart';
import 'package:dream_catcher/services/api_service.dart';
import 'package:dream_catcher/services/chat_service.dart';
import 'package:dream_catcher/services/dream_service.dart';
import 'package:dream_catcher/styles/styles.dart';
import 'package:dream_catcher/utils/utils.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentDreamId = widget.dreamId;
    Dream? dream = _dreamService.getDreamById(widget.dreamId);

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
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Styles.deepOceanBlue, Styles.black],
                  )),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: SpacedColumn(
                        height: 20,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Styles.sidePadding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Styles.white,
                                    )),
                                if (_currentDreamId != null)
                                  InkWell(
                                      onTap: () {
                                        _deleteDream(dreamService, _currentDreamId);
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Styles.white,
                                      )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Styles.sidePadding),
                            child: SizedBox(
                                width: 400,
                                child: SelfSavingTextField(
                                  _titleEditingController,
                                  focusNode: _titleFocusNode,
                                  onChanged: (value) => _onTitleChanged(_titleEditingController.text),
                                  hintText: "Dream Title",
                                )),
                          ),
                          Container(
                            height: 1,
                            color: Styles.white,
                          ),
                          // result
                          chatList.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Styles.sidePadding),
                                  child: Flexible(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: chatList.length,
                                          itemBuilder: (context, index) {
                                            bool isMe = chatList[index].role == ChatRoleType.USER;
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _getRoleLabel(chatList[index].role) + chatList[index].text ?? '',
                                                    style: isMe
                                                        ? Styles.uiSemiBoldMedium.copyWith(color: Styles.mistyBlue)
                                                        : Styles.uiSemiBoldMedium,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            );
                                          })),
                                )
                              : Container(),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: Styles.sidePadding),
                              width: 400,
                              child: LabeledTextField(
                                minLines: 1,
                                focusNode: _focusNode,
                                controller: _textEditingController,
                                onChanged: (String s) {
                                  setState(() {});
                                },
                                label: '',
                                hint: chatList.isNotEmpty ? "Reply.." : "Write your dream",
                              )),

                          _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : _textEditingController.text.isEmpty
                                  ? Container()
                                  : Center(
                                      child: AsyncActionButton(
                                        width: 200,
                                        height: 50,
                                        label: "Analyze",
                                        buttonVariant: ButtonVariant.PRIMARY,
                                        onPressed: () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await _saveChat(_textEditingController.text, chatService);
                                          List<Chat> chatList = chatService.getChatListById(_currentDreamId) ?? [];
                                          if (chatList.isNotEmpty) {
                                            analyzeDream(chatList);
                                          }
                                        },
                                      ),
                                    ),
                        ],
                      ),
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

  Future<void> _saveChat(String value, ChatService chatService) async {
    String text = _textEditingController.text;

    if (_currentChatId != null) {
      await _chatService.updateChat(_currentChatId!, _currentDreamId!, text);
    } else {
      _currentChatId = await _chatService.createChat(
        _currentDreamId!,
        text,
        ChatRoleType.USER,
      );
    }
    _clearStuff();
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
      _isLoading = false;
    });
  }

  _onTitleChanged(String value) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (_currentDreamId != null) {
        await _dreamService.updateDream(
          _currentDreamId!,
          _titleEditingController.text,
        );
      } else {
        String? dreamId = await _dreamService.createDream(_titleEditingController.text);
        setState(() {
          _currentDreamId = dreamId;
        });
      }
    });
  }

  _deleteDream(DreamService dreamService, String? dreamId) async {
    await Utils.showConfirmCancelDialog(
      context: context,
      title: 'Delete this dream?',
      customConfirmLabel: 'Delete',
      customCancelLabel: 'Cancel',
      confirmFunction: () async {
        final navigator = Navigator.of(context);
        await dreamService.deleteDream(dreamId!);
        navigator.pop();
        navigator.pop();
      },
      customCancelFunction: () {
        Navigator.of(context).pop();
      },
    );
  }

  _clearStuff() {
    setState(() {
      _currentChatId = null;
      _textEditingController.clear();
      _focusNode.unfocus();
      _titleFocusNode.unfocus();
      _titleFocusNode.unfocus();
    });
  }
}
