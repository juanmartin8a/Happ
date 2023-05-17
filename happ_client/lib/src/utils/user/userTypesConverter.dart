import 'package:happ_client/src/api/graphql/graphql_api.dart';

class UserTypesConverter {
  SearchUsers$Query$User convertToSearchUser(user) {
    var userToJson = user.toJson();
    var newUser = SearchUsers$Query$User.fromJson(userToJson);

    return newUser;
  }
}