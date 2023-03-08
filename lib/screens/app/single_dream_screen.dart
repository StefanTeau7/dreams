import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dream_catcher/services/central_service.dart';
import 'package:dream_catcher/services/dependency_injection.dart';
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
  CentralService _centralService = getIt<CentralService>();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    if (widget.dreamId != null) {
      _centralService.currentDreamId = widget.dreamId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CentralService>(
      builder: (context, centralService, child) {
        // Get Dream getDreamById();
        dreamId = centralService.currentDreamId;
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
                          sendMessage(centralService);
                        },
                      ),
                      // result
                      dreamId != null
                          ? Flexible(
                              child: ListView.builder(
                                  // controller: _listScrollController,
                                  itemCount: centralService.getChatListById(dreamId)?.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: DreamCard(
                                        width: 600,
                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                          Text(
                                            centralService.getChatListById(dreamId)![index].text ?? '',
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
                      // clear data button
                      SimpleButton(label: "",)
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
  // function to send message with string "123" added at end
  
  // function to find prime 


  Future<void> sendMessage(CentralService centralService) async {
    await centralService.handleMessageSend(_textEditingController.text);

    setState(() {
      _textEditingController.clear();
      _focusNode.unfocus();
    });
  }
}
