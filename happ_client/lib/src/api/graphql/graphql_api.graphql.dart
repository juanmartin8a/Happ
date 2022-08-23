// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'graphql_api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class RefreshTokens$Mutation$TokenResponse extends JsonSerializable
    with EquatableMixin {
  RefreshTokens$Mutation$TokenResponse();

  factory RefreshTokens$Mutation$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RefreshTokens$Mutation$TokenResponseFromJson(json);

  late String refreshToken;

  late String accessToken;

  @override
  List<Object?> get props => [refreshToken, accessToken];
  @override
  Map<String, dynamic> toJson() =>
      _$RefreshTokens$Mutation$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokens$Mutation extends JsonSerializable with EquatableMixin {
  RefreshTokens$Mutation();

  factory RefreshTokens$Mutation.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokens$MutationFromJson(json);

  RefreshTokens$Mutation$TokenResponse? refreshTokens;

  @override
  List<Object?> get props => [refreshTokens];
  @override
  Map<String, dynamic> toJson() => _$RefreshTokens$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserAuthResponse$User extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$UserAuthResponse$User();

  factory SignIn$Mutation$UserAuthResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserAuthResponse$UserFromJson(json);

  late double id;

  late String name;

  late String username;

  @override
  List<Object?> get props => [id, name, username];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserAuthResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserAuthResponse$TokenResponse extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$UserAuthResponse$TokenResponse();

  factory SignIn$Mutation$UserAuthResponse$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserAuthResponse$TokenResponseFromJson(json);

  late String accessToken;

  late String refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserAuthResponse$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserAuthResponse$ErrorResponse extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$UserAuthResponse$ErrorResponse();

  factory SignIn$Mutation$UserAuthResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserAuthResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserAuthResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation$UserAuthResponse extends JsonSerializable
    with EquatableMixin {
  SignIn$Mutation$UserAuthResponse();

  factory SignIn$Mutation$UserAuthResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignIn$Mutation$UserAuthResponseFromJson(json);

  SignIn$Mutation$UserAuthResponse$User? user;

  SignIn$Mutation$UserAuthResponse$TokenResponse? tokens;

  List<SignIn$Mutation$UserAuthResponse$ErrorResponse>? errors;

  @override
  List<Object?> get props => [user, tokens, errors];
  @override
  Map<String, dynamic> toJson() =>
      _$SignIn$Mutation$UserAuthResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignIn$Mutation extends JsonSerializable with EquatableMixin {
  SignIn$Mutation();

  factory SignIn$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SignIn$MutationFromJson(json);

  SignIn$Mutation$UserAuthResponse? signIn;

  @override
  List<Object?> get props => [signIn];
  @override
  Map<String, dynamic> toJson() => _$SignIn$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignInInput extends JsonSerializable with EquatableMixin {
  SignInInput({required this.usernameOrEmail, required this.password});

  factory SignInInput.fromJson(Map<String, dynamic> json) =>
      _$SignInInputFromJson(json);

  late String usernameOrEmail;

  late String password;

  @override
  List<Object?> get props => [usernameOrEmail, password];
  @override
  Map<String, dynamic> toJson() => _$SignInInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUp$Mutation$UserAuthResponse$User extends JsonSerializable
    with EquatableMixin {
  SignUp$Mutation$UserAuthResponse$User();

  factory SignUp$Mutation$UserAuthResponse$User.fromJson(
          Map<String, dynamic> json) =>
      _$SignUp$Mutation$UserAuthResponse$UserFromJson(json);

  late double id;

  late String name;

  late String username;

  @override
  List<Object?> get props => [id, name, username];
  @override
  Map<String, dynamic> toJson() =>
      _$SignUp$Mutation$UserAuthResponse$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUp$Mutation$UserAuthResponse$TokenResponse extends JsonSerializable
    with EquatableMixin {
  SignUp$Mutation$UserAuthResponse$TokenResponse();

  factory SignUp$Mutation$UserAuthResponse$TokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignUp$Mutation$UserAuthResponse$TokenResponseFromJson(json);

  late String accessToken;

  late String refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];
  @override
  Map<String, dynamic> toJson() =>
      _$SignUp$Mutation$UserAuthResponse$TokenResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUp$Mutation$UserAuthResponse$ErrorResponse extends JsonSerializable
    with EquatableMixin {
  SignUp$Mutation$UserAuthResponse$ErrorResponse();

  factory SignUp$Mutation$UserAuthResponse$ErrorResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignUp$Mutation$UserAuthResponse$ErrorResponseFromJson(json);

  late String field;

  late String message;

  @override
  List<Object?> get props => [field, message];
  @override
  Map<String, dynamic> toJson() =>
      _$SignUp$Mutation$UserAuthResponse$ErrorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUp$Mutation$UserAuthResponse extends JsonSerializable
    with EquatableMixin {
  SignUp$Mutation$UserAuthResponse();

  factory SignUp$Mutation$UserAuthResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SignUp$Mutation$UserAuthResponseFromJson(json);

  SignUp$Mutation$UserAuthResponse$User? user;

  SignUp$Mutation$UserAuthResponse$TokenResponse? tokens;

  List<SignUp$Mutation$UserAuthResponse$ErrorResponse>? errors;

  @override
  List<Object?> get props => [user, tokens, errors];
  @override
  Map<String, dynamic> toJson() =>
      _$SignUp$Mutation$UserAuthResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUp$Mutation extends JsonSerializable with EquatableMixin {
  SignUp$Mutation();

  factory SignUp$Mutation.fromJson(Map<String, dynamic> json) =>
      _$SignUp$MutationFromJson(json);

  SignUp$Mutation$UserAuthResponse? signUp;

  @override
  List<Object?> get props => [signUp];
  @override
  Map<String, dynamic> toJson() => _$SignUp$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SignUpInput extends JsonSerializable with EquatableMixin {
  SignUpInput(
      {required this.name,
      required this.username,
      required this.email,
      required this.password,
      required this.birthday});

  factory SignUpInput.fromJson(Map<String, dynamic> json) =>
      _$SignUpInputFromJson(json);

  late String name;

  late String username;

  late String email;

  late String password;

  late String birthday;

  @override
  List<Object?> get props => [name, username, email, password, birthday];
  @override
  Map<String, dynamic> toJson() => _$SignUpInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserAccess$Query$User extends JsonSerializable with EquatableMixin {
  UserAccess$Query$User();

  factory UserAccess$Query$User.fromJson(Map<String, dynamic> json) =>
      _$UserAccess$Query$UserFromJson(json);

  late double id;

  late String name;

  late String username;

  @override
  List<Object?> get props => [id, name, username];
  @override
  Map<String, dynamic> toJson() => _$UserAccess$Query$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserAccess$Query extends JsonSerializable with EquatableMixin {
  UserAccess$Query();

  factory UserAccess$Query.fromJson(Map<String, dynamic> json) =>
      _$UserAccess$QueryFromJson(json);

  UserAccess$Query$User? userAccess;

  @override
  List<Object?> get props => [userAccess];
  @override
  Map<String, dynamic> toJson() => _$UserAccess$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RefreshTokensArguments extends JsonSerializable with EquatableMixin {
  RefreshTokensArguments({required this.token});

  @override
  factory RefreshTokensArguments.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokensArgumentsFromJson(json);

  late String token;

  @override
  List<Object?> get props => [token];
  @override
  Map<String, dynamic> toJson() => _$RefreshTokensArgumentsToJson(this);
}

final REFRESH_TOKENS_MUTATION_DOCUMENT_OPERATION_NAME = 'RefreshTokens';
final REFRESH_TOKENS_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'RefreshTokens'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'token')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'refreshTokens'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'token'),
                  value: VariableNode(name: NameNode(value: 'token')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'refreshToken'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'accessToken'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class RefreshTokensMutation
    extends GraphQLQuery<RefreshTokens$Mutation, RefreshTokensArguments> {
  RefreshTokensMutation({required this.variables});

  @override
  final DocumentNode document = REFRESH_TOKENS_MUTATION_DOCUMENT;

  @override
  final String operationName = REFRESH_TOKENS_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final RefreshTokensArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  RefreshTokens$Mutation parse(Map<String, dynamic> json) =>
      RefreshTokens$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SignInArguments extends JsonSerializable with EquatableMixin {
  SignInArguments({required this.input});

  @override
  factory SignInArguments.fromJson(Map<String, dynamic> json) =>
      _$SignInArgumentsFromJson(json);

  late SignInInput input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$SignInArgumentsToJson(this);
}

final SIGN_IN_MUTATION_DOCUMENT_OPERATION_NAME = 'SignIn';
final SIGN_IN_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignIn'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'SignInInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'signIn'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'tokens'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'accessToken'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'refreshToken'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class SignInMutation extends GraphQLQuery<SignIn$Mutation, SignInArguments> {
  SignInMutation({required this.variables});

  @override
  final DocumentNode document = SIGN_IN_MUTATION_DOCUMENT;

  @override
  final String operationName = SIGN_IN_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SignInArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SignIn$Mutation parse(Map<String, dynamic> json) =>
      SignIn$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SignUpArguments extends JsonSerializable with EquatableMixin {
  SignUpArguments({required this.input});

  @override
  factory SignUpArguments.fromJson(Map<String, dynamic> json) =>
      _$SignUpArgumentsFromJson(json);

  late SignUpInput input;

  @override
  List<Object?> get props => [input];
  @override
  Map<String, dynamic> toJson() => _$SignUpArgumentsToJson(this);
}

final SIGN_UP_MUTATION_DOCUMENT_OPERATION_NAME = 'SignUp';
final SIGN_UP_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'SignUp'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'input')),
            type: NamedTypeNode(
                name: NameNode(value: 'SignUpInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'signUp'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'input'),
                  value: VariableNode(name: NameNode(value: 'input')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'id'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'tokens'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'accessToken'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'refreshToken'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'errors'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'field'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'message'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class SignUpMutation extends GraphQLQuery<SignUp$Mutation, SignUpArguments> {
  SignUpMutation({required this.variables});

  @override
  final DocumentNode document = SIGN_UP_MUTATION_DOCUMENT;

  @override
  final String operationName = SIGN_UP_MUTATION_DOCUMENT_OPERATION_NAME;

  @override
  final SignUpArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SignUp$Mutation parse(Map<String, dynamic> json) =>
      SignUp$Mutation.fromJson(json);
}

final USER_ACCESS_QUERY_DOCUMENT_OPERATION_NAME = 'UserAccess';
final USER_ACCESS_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'UserAccess'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'userAccess'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'username'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class UserAccessQuery extends GraphQLQuery<UserAccess$Query, JsonSerializable> {
  UserAccessQuery();

  @override
  final DocumentNode document = USER_ACCESS_QUERY_DOCUMENT;

  @override
  final String operationName = USER_ACCESS_QUERY_DOCUMENT_OPERATION_NAME;

  @override
  List<Object?> get props => [document, operationName];
  @override
  UserAccess$Query parse(Map<String, dynamic> json) =>
      UserAccess$Query.fromJson(json);
}
