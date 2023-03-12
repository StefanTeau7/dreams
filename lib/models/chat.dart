/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

import 'package:amplify_core/amplify_core.dart';
// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:dream_catcher/models/chatRoleType.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the Chat type in your schema. */
@immutable
class Chat extends Model {
  static const classType = const _ChatModelType();
  final String id;
  final String? _text;
  final String? _dreamID;
  final int? _chatIndex;
  final ChatRoleType? _role;
  final String? _userID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @Deprecated(
      '[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;

  ChatModelIdentifier get modelIdentifier {
    return ChatModelIdentifier(id: id);
  }

  String? get text {
    return _text;
  }

  String get dreamID {
    try {
      return _dreamID!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  int? get chatIndex {
    return _chatIndex;
  }

  ChatRoleType? get role {
    return _role;
  }

  String get userID {
    try {
      return _userID!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const Chat._internal(
      {required this.id, text, required dreamID, chatIndex, role, required userID, createdAt, updatedAt})
      : _text = text,
        _dreamID = dreamID,
        _chatIndex = chatIndex,
        _role = role,
        _userID = userID,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory Chat(
      {String? id, String? text, required String dreamID, int? chatIndex, ChatRoleType? role, required String userID}) {
    return Chat._internal(
        id: id == null ? UUID.getUUID() : id,
        text: text,
        dreamID: dreamID,
        chatIndex: chatIndex,
        role: role,
        userID: userID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chat &&
        id == other.id &&
        _text == other._text &&
        _dreamID == other._dreamID &&
        _chatIndex == other._chatIndex &&
        _role == other._role &&
        _userID == other._userID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Chat {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("text=" + "$_text" + ", ");
    buffer.write("dreamID=" + "$_dreamID" + ", ");
    buffer.write("chatIndex=" + (_chatIndex != null ? _chatIndex!.toString() : "null") + ", ");
    buffer.write("role=" + (_role != null ? enumToString(_role)! : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Chat copyWith({String? text, String? dreamID, int? chatIndex, ChatRoleType? role, String? userID}) {
    return Chat._internal(
        id: id,
        text: text ?? this.text,
        dreamID: dreamID ?? this.dreamID,
        chatIndex: chatIndex ?? this.chatIndex,
        role: role ?? this.role,
        userID: userID ?? this.userID);
  }

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _text = json['text'],
        _dreamID = json['dreamID'],
        _chatIndex = (json['chatIndex'] as num?)?.toInt(),
        _role = enumFromString<ChatRoleType>(json['role'], ChatRoleType.values),
        _userID = json['userID'],
        _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
        _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': _text,
        'dreamID': _dreamID,
        'chatIndex': _chatIndex,
        'role': enumToString(_role),
        'userID': _userID,
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  Map<String, Object?> toMap() => {
        'id': id,
        'text': _text,
        'dreamID': _dreamID,
        'chatIndex': _chatIndex,
        'role': _role,
        'userID': _userID,
        'createdAt': _createdAt,
        'updatedAt': _updatedAt
      };

  static final QueryModelIdentifier<ChatModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ChatModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TEXT = QueryField(fieldName: "text");
  static final QueryField DREAMID = QueryField(fieldName: "dreamID");
  static final QueryField CHATINDEX = QueryField(fieldName: "chatIndex");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Chat";
    modelSchemaDefinition.pluralName = "Chats";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.PUBLIC,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ]),
      AuthRule(
          authStrategy: AuthStrategy.OWNER,
          ownerField: "owner",
          identityClaim: "cognito:username",
          provider: AuthRuleProvider.USERPOOLS,
          operations: [ModelOperation.CREATE, ModelOperation.UPDATE, ModelOperation.DELETE, ModelOperation.READ])
    ];

    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["dreamID"], name: "byDream"),
      ModelIndex(fields: const ["userID"], name: "byUser")
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Chat.TEXT, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Chat.DREAMID, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Chat.CHATINDEX, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.int)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Chat.ROLE, isRequired: false, ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Chat.USERID, isRequired: true, ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _ChatModelType extends ModelType<Chat> {
  const _ChatModelType();

  @override
  Chat fromJson(Map<String, dynamic> jsonData) {
    return Chat.fromJson(jsonData);
  }

  @override
  String modelName() {
    return 'Chat';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Chat] in your schema.
 */
@immutable
class ChatModelIdentifier implements ModelIdentifier<Chat> {
  final String id;

  /** Create an instance of ChatModelIdentifier using [id] the primary key. */
  const ChatModelIdentifier({required this.id});

  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{'id': id});

  @override
  List<Map<String, dynamic>> serializeAsList() =>
      serializeAsMap().entries.map((entry) => (<String, dynamic>{entry.key: entry.value})).toList();

  @override
  String serializeAsString() => serializeAsMap().values.join('#');

  @override
  String toString() => 'ChatModelIdentifier(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is ChatModelIdentifier && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
