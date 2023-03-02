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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Dream type in your schema. */
@immutable
class Dream extends Model {
  static const classType = const _DreamModelType();
  final String id;
  final String? _subject;
  final String? _summary;
  final bool? _archived;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  DreamModelIdentifier get modelIdentifier {
      return DreamModelIdentifier(
        id: id
      );
  }
  
  String get subject {
    try {
      return _subject!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get summary {
    return _summary;
  }
  
  bool? get archived {
    return _archived;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Dream._internal({required this.id, required subject, summary, archived, createdAt, updatedAt}): _subject = subject, _summary = summary, _archived = archived, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Dream({String? id, required String subject, String? summary, bool? archived, TemporalDateTime? createdAt}) {
    return Dream._internal(
      id: id == null ? UUID.getUUID() : id,
      subject: subject,
      summary: summary,
      archived: archived,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Dream &&
      id == other.id &&
      _subject == other._subject &&
      _summary == other._summary &&
      _archived == other._archived &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Dream {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("subject=" + "$_subject" + ", ");
    buffer.write("summary=" + "$_summary" + ", ");
    buffer.write("archived=" + (_archived != null ? _archived!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Dream copyWith({String? subject, String? summary, bool? archived, TemporalDateTime? createdAt}) {
    return Dream._internal(
      id: id,
      subject: subject ?? this.subject,
      summary: summary ?? this.summary,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Dream.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _subject = json['subject'],
      _summary = json['summary'],
      _archived = json['archived'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'subject': _subject, 'summary': _summary, 'archived': _archived, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'subject': _subject, 'summary': _summary, 'archived': _archived, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<DreamModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<DreamModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SUBJECT = QueryField(fieldName: "subject");
  static final QueryField SUMMARY = QueryField(fieldName: "summary");
  static final QueryField ARCHIVED = QueryField(fieldName: "archived");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Dream";
    modelSchemaDefinition.pluralName = "Dreams";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.READ,
          ModelOperation.UPDATE
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Dream.SUBJECT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Dream.SUMMARY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Dream.ARCHIVED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Dream.CREATEDAT,
      isRequired: false,
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

class _DreamModelType extends ModelType<Dream> {
  const _DreamModelType();
  
  @override
  Dream fromJson(Map<String, dynamic> jsonData) {
    return Dream.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Dream';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Dream] in your schema.
 */
@immutable
class DreamModelIdentifier implements ModelIdentifier<Dream> {
  final String id;

  /** Create an instance of DreamModelIdentifier using [id] the primary key. */
  const DreamModelIdentifier({
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
  String toString() => 'DreamModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is DreamModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}