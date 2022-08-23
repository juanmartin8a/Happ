import 'package:happ_client/src/api/graphql/graphql_api.dart';

class UserTypesConverter {
  UserAccess$Query$User convertSignUserToUserAccessUser(SignIn$Mutation$UserAuthResponse$User user) {
    var userToJson = user.toJson();
    var newUser = UserAccess$Query$User.fromJson(userToJson);

    return newUser;
  }

  UserAccess$Query$User convertCreateUserToUserAccessUser(SignUp$Mutation$UserAuthResponse$User user) {
    var userToJson = user.toJson();
    var newUser = UserAccess$Query$User.fromJson(userToJson);

    return newUser;
  }
}