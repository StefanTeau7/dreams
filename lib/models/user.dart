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

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _first;
  final String? _email;
  final String? _phone;
  final List<Dream>? _mind;
  final List<Chat>? _thoughts;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  UserModelIdentifier get modelIdentifier {
      return UserModelIdentifier(
        id: id
      );
  }
  
  String? get first {
    return _first;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phone {
    return _phone;
  }
  
  List<Dream>? get mind {
    return _mind;
  }
  
  List<Chat>? get thoughts {
    return _thoughts;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, first, email, phone, mind, thoughts, createdAt, updatedAt}): _first = first, _email = email, _phone = phone, _mind = mind, _thoughts = thoughts, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, String? first, String? email, String? phone, List<Dream>? mind, List<Chat>? thoughts}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      first: first,
      email: email,
      phone: phone,
      mind: mind != null ? List<Dream>.unmodifiable(mind) : mind,
      thoughts: thoughts != null ? List<Chat>.unmodifiable(thoughts) : thoughts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _first == other._first &&
      _email == other._email &&
      _phone == other._phone &&
      DeepCollectionEquality().equals(_mind, other._mind) &&
      DeepCollectionEquality().equals(_thoughts, other._thoughts);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("first=" + "$_first" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? first, String? email, String? phone, List<Dream>? mind, List<Chat>? thoughts}) {
    return User._internal(
      id: id,
      first: first ?? this.first,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mind: mind ?? this.mind,
      thoughts: thoughts ?? this.thoughts);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _first = json['first'],
      _email = json['email'],
      _phone = json['phone'],
      _mind = json['mind'] is List
        ? (json['mind'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Dream.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _thoughts = json['thoughts'] is List
        ? (json['thoughts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Chat.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'first': _first, 'email': _email, 'phone': _phone, 'mind': _mind?.map((Dream? e) => e?.toJson()).toList(), 'thoughts': _thoughts?.map((Chat? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'first': _first, 'email': _email, 'phone': _phone, 'mind': _mind, 'thoughts': _thoughts, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<UserModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<UserModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField FIRST = QueryField(fieldName: "first");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField MIND = QueryField(
    fieldName: "mind",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Dream'));
  static final QueryField THOUGHTS = QueryField(
    fieldName: "thoughts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Chat'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FIRST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.MIND,
      isRequired: false,
      ofModelName: 'Dream',
      associatedKey: Dream.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.THOUGHTS,
      isRequired: false,
      ofModelName: 'Chat',
      associatedKey: Chat.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'User';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [User] in your schema.
 */
@immutable
class UserModelIdentifier implements ModelIdentifier<User> {
  final String id;

  /** Create an instance of UserModelIdentifier using [id] the primary key. */
  const UserModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'UserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is UserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}