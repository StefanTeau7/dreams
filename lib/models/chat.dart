class Chat {
  final String text;
  final int chatIndex;
  final ChatRoleType role;

  Chat({required this.text, required this.chatIndex, required this.role});

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        text: json["msg"],
        role: json["role"],
        chatIndex: json["chatIndex"],
      );
}

class ChatRoleType {
  final String _value;
  const ChatRoleType._internal(this._value);
  @override
  toString() {
    return _value.toLowerCase();
  }

  factory ChatRoleType.fromString(String value) {
    switch (value) {
      case 'SYSTEM':
        return SYSTEM;
      case 'USER':
        return USER;
      case 'ASSISTANT':
        return ASSISTANT;
      default:
        throw Exception("Invalid char role type");
    }
  }

  static const SYSTEM = ChatRoleType._internal('SYSTEM');
  static const USER = ChatRoleType._internal('USER');
  static const ASSISTANT = ChatRoleType._internal('ASSISTANT');

 // static const Strings = ['SYSTEM', 'USER', 'ASSISTANT'];
}
