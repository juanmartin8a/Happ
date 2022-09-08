// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'graphql_api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokens$Mutation$TokenResponse
    _$RefreshTokens$Mutation$TokenResponseFromJson(Map<String, dynamic> json) =>
        RefreshTokens$Mutation$TokenResponse()
          ..refreshToken = json['refreshToken'] as String
          ..accessToken = json['accessToken'] as String;

Map<String, dynamic> _$RefreshTokens$Mutation$TokenResponseToJson(
        RefreshTokens$Mutation$TokenResponse instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };

RefreshTokens$Mutation _$RefreshTokens$MutationFromJson(
        Map<String, dynamic> json) =>
    RefreshTokens$Mutation()
      ..refreshTokens = json['refreshTokens'] == null
          ? null
          : RefreshTokens$Mutation$TokenResponse.fromJson(
              json['refreshTokens'] as Map<String, dynamic>);

Map<String, dynamic> _$RefreshTokens$MutationToJson(
        RefreshTokens$Mutation instance) =>
    <String, dynamic>{
      'refreshTokens': instance.refreshTokens?.toJson(),
    };

SignIn$Mutation$UserAuthResponse$User
    _$SignIn$Mutation$UserAuthResponse$UserFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserAuthResponse$User()
          ..id = (json['id'] as num).toDouble()
          ..name = json['name'] as String
          ..username = json['username'] as String;

Map<String, dynamic> _$SignIn$Mutation$UserAuthResponse$UserToJson(
        SignIn$Mutation$UserAuthResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
    };

SignIn$Mutation$UserAuthResponse$TokenResponse
    _$SignIn$Mutation$UserAuthResponse$TokenResponseFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserAuthResponse$TokenResponse()
          ..accessToken = json['accessToken'] as String
          ..refreshToken = json['refreshToken'] as String;

Map<String, dynamic> _$SignIn$Mutation$UserAuthResponse$TokenResponseToJson(
        SignIn$Mutation$UserAuthResponse$TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

SignIn$Mutation$UserAuthResponse$ErrorResponse
    _$SignIn$Mutation$UserAuthResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        SignIn$Mutation$UserAuthResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic> _$SignIn$Mutation$UserAuthResponse$ErrorResponseToJson(
        SignIn$Mutation$UserAuthResponse$ErrorResponse instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

SignIn$Mutation$UserAuthResponse _$SignIn$Mutation$UserAuthResponseFromJson(
        Map<String, dynamic> json) =>
    SignIn$Mutation$UserAuthResponse()
      ..user = json['user'] == null
          ? null
          : SignIn$Mutation$UserAuthResponse$User.fromJson(
              json['user'] as Map<String, dynamic>)
      ..tokens = json['tokens'] == null
          ? null
          : SignIn$Mutation$UserAuthResponse$TokenResponse.fromJson(
              json['tokens'] as Map<String, dynamic>)
      ..errors = (json['errors'] as List<dynamic>?)
          ?.map((e) => SignIn$Mutation$UserAuthResponse$ErrorResponse.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SignIn$Mutation$UserAuthResponseToJson(
        SignIn$Mutation$UserAuthResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'tokens': instance.tokens?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

SignIn$Mutation _$SignIn$MutationFromJson(Map<String, dynamic> json) =>
    SignIn$Mutation()
      ..signIn = json['signIn'] == null
          ? null
          : SignIn$Mutation$UserAuthResponse.fromJson(
              json['signIn'] as Map<String, dynamic>);

Map<String, dynamic> _$SignIn$MutationToJson(SignIn$Mutation instance) =>
    <String, dynamic>{
      'signIn': instance.signIn?.toJson(),
    };

SignInInput _$SignInInputFromJson(Map<String, dynamic> json) => SignInInput(
      usernameOrEmail: json['usernameOrEmail'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SignInInputToJson(SignInInput instance) =>
    <String, dynamic>{
      'usernameOrEmail': instance.usernameOrEmail,
      'password': instance.password,
    };

SignUp$Mutation$UserAuthResponse$User
    _$SignUp$Mutation$UserAuthResponse$UserFromJson(
            Map<String, dynamic> json) =>
        SignUp$Mutation$UserAuthResponse$User()
          ..id = (json['id'] as num).toDouble()
          ..name = json['name'] as String
          ..username = json['username'] as String;

Map<String, dynamic> _$SignUp$Mutation$UserAuthResponse$UserToJson(
        SignUp$Mutation$UserAuthResponse$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
    };

SignUp$Mutation$UserAuthResponse$TokenResponse
    _$SignUp$Mutation$UserAuthResponse$TokenResponseFromJson(
            Map<String, dynamic> json) =>
        SignUp$Mutation$UserAuthResponse$TokenResponse()
          ..accessToken = json['accessToken'] as String
          ..refreshToken = json['refreshToken'] as String;

Map<String, dynamic> _$SignUp$Mutation$UserAuthResponse$TokenResponseToJson(
        SignUp$Mutation$UserAuthResponse$TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };

SignUp$Mutation$UserAuthResponse$ErrorResponse
    _$SignUp$Mutation$UserAuthResponse$ErrorResponseFromJson(
            Map<String, dynamic> json) =>
        SignUp$Mutation$UserAuthResponse$ErrorResponse()
          ..field = json['field'] as String
          ..message = json['message'] as String;

Map<String, dynamic> _$SignUp$Mutation$UserAuthResponse$ErrorResponseToJson(
        SignUp$Mutation$UserAuthResponse$ErrorResponse instance) =>
    <String, dynamic>{
      'field': instance.field,
      'message': instance.message,
    };

SignUp$Mutation$UserAuthResponse _$SignUp$Mutation$UserAuthResponseFromJson(
        Map<String, dynamic> json) =>
    SignUp$Mutation$UserAuthResponse()
      ..user = json['user'] == null
          ? null
          : SignUp$Mutation$UserAuthResponse$User.fromJson(
              json['user'] as Map<String, dynamic>)
      ..tokens = json['tokens'] == null
          ? null
          : SignUp$Mutation$UserAuthResponse$TokenResponse.fromJson(
              json['tokens'] as Map<String, dynamic>)
      ..errors = (json['errors'] as List<dynamic>?)
          ?.map((e) => SignUp$Mutation$UserAuthResponse$ErrorResponse.fromJson(
              e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SignUp$Mutation$UserAuthResponseToJson(
        SignUp$Mutation$UserAuthResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'tokens': instance.tokens?.toJson(),
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
    };

SignUp$Mutation _$SignUp$MutationFromJson(Map<String, dynamic> json) =>
    SignUp$Mutation()
      ..signUp = json['signUp'] == null
          ? null
          : SignUp$Mutation$UserAuthResponse.fromJson(
              json['signUp'] as Map<String, dynamic>);

Map<String, dynamic> _$SignUp$MutationToJson(SignUp$Mutation instance) =>
    <String, dynamic>{
      'signUp': instance.signUp?.toJson(),
    };

SignUpInput _$SignUpInputFromJson(Map<String, dynamic> json) => SignUpInput(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      birthday: json['birthday'] as String,
    );

Map<String, dynamic> _$SignUpInputToJson(SignUpInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'birthday': instance.birthday,
    };

UserFromId$Query$User _$UserFromId$Query$UserFromJson(
        Map<String, dynamic> json) =>
    UserFromId$Query$User()
      ..id = (json['id'] as num).toDouble()
      ..name = json['name'] as String
      ..username = json['username'] as String
      ..email = json['email'] as String;

Map<String, dynamic> _$UserFromId$Query$UserToJson(
        UserFromId$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
    };

UserFromId$Query _$UserFromId$QueryFromJson(Map<String, dynamic> json) =>
    UserFromId$Query()
      ..userFromId = json['userFromId'] == null
          ? null
          : UserFromId$Query$User.fromJson(
              json['userFromId'] as Map<String, dynamic>);

Map<String, dynamic> _$UserFromId$QueryToJson(UserFromId$Query instance) =>
    <String, dynamic>{
      'userFromId': instance.userFromId?.toJson(),
    };

UserAccess$Query$User _$UserAccess$Query$UserFromJson(
        Map<String, dynamic> json) =>
    UserAccess$Query$User()
      ..id = (json['id'] as num).toDouble()
      ..name = json['name'] as String
      ..username = json['username'] as String;

Map<String, dynamic> _$UserAccess$Query$UserToJson(
        UserAccess$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
    };

UserAccess$Query _$UserAccess$QueryFromJson(Map<String, dynamic> json) =>
    UserAccess$Query()
      ..userAccess = json['userAccess'] == null
          ? null
          : UserAccess$Query$User.fromJson(
              json['userAccess'] as Map<String, dynamic>);

Map<String, dynamic> _$UserAccess$QueryToJson(UserAccess$Query instance) =>
    <String, dynamic>{
      'userAccess': instance.userAccess?.toJson(),
    };

SearchUsers$Query$User _$SearchUsers$Query$UserFromJson(
        Map<String, dynamic> json) =>
    SearchUsers$Query$User()
      ..id = (json['id'] as num).toDouble()
      ..username = json['username'] as String
      ..name = json['name'] as String;

Map<String, dynamic> _$SearchUsers$Query$UserToJson(
        SearchUsers$Query$User instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
    };

SearchUsers$Query _$SearchUsers$QueryFromJson(Map<String, dynamic> json) =>
    SearchUsers$Query()
      ..searchUsers = (json['searchUsers'] as List<dynamic>)
          .map(
              (e) => SearchUsers$Query$User.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SearchUsers$QueryToJson(SearchUsers$Query instance) =>
    <String, dynamic>{
      'searchUsers': instance.searchUsers.map((e) => e.toJson()).toList(),
    };

AddOrRemoveUser$Mutation$AddResponse
    _$AddOrRemoveUser$Mutation$AddResponseFromJson(Map<String, dynamic> json) =>
        AddOrRemoveUser$Mutation$AddResponse()
          ..value = json['value'] as int
          ..isFriend = json['isFriend'] as bool;

Map<String, dynamic> _$AddOrRemoveUser$Mutation$AddResponseToJson(
        AddOrRemoveUser$Mutation$AddResponse instance) =>
    <String, dynamic>{
      'value': instance.value,
      'isFriend': instance.isFriend,
    };

AddOrRemoveUser$Mutation _$AddOrRemoveUser$MutationFromJson(
        Map<String, dynamic> json) =>
    AddOrRemoveUser$Mutation()
      ..addOrRemoveUser = AddOrRemoveUser$Mutation$AddResponse.fromJson(
          json['addOrRemoveUser'] as Map<String, dynamic>);

Map<String, dynamic> _$AddOrRemoveUser$MutationToJson(
        AddOrRemoveUser$Mutation instance) =>
    <String, dynamic>{
      'addOrRemoveUser': instance.addOrRemoveUser.toJson(),
    };

RefreshTokensArguments _$RefreshTokensArgumentsFromJson(
        Map<String, dynamic> json) =>
    RefreshTokensArguments(
      token: json['token'] as String,
    );

Map<String, dynamic> _$RefreshTokensArgumentsToJson(
        RefreshTokensArguments instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

SignInArguments _$SignInArgumentsFromJson(Map<String, dynamic> json) =>
    SignInArguments(
      input: SignInInput.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignInArgumentsToJson(SignInArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

SignUpArguments _$SignUpArgumentsFromJson(Map<String, dynamic> json) =>
    SignUpArguments(
      input: SignUpInput.fromJson(json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpArgumentsToJson(SignUpArguments instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

UserFromIdArguments _$UserFromIdArgumentsFromJson(Map<String, dynamic> json) =>
    UserFromIdArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$UserFromIdArgumentsToJson(
        UserFromIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

SearchUsersArguments _$SearchUsersArgumentsFromJson(
        Map<String, dynamic> json) =>
    SearchUsersArguments(
      search: json['search'] as String,
    );

Map<String, dynamic> _$SearchUsersArgumentsToJson(
        SearchUsersArguments instance) =>
    <String, dynamic>{
      'search': instance.search,
    };

AddOrRemoveUserArguments _$AddOrRemoveUserArgumentsFromJson(
        Map<String, dynamic> json) =>
    AddOrRemoveUserArguments(
      followUserId: json['followUserId'] as int,
    );

Map<String, dynamic> _$AddOrRemoveUserArgumentsToJson(
        AddOrRemoveUserArguments instance) =>
    <String, dynamic>{
      'followUserId': instance.followUserId,
    };
