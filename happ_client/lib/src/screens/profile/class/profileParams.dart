import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/screens/profile/profile.dart';

class ProfileParams {
  final ProfileUserData user;
  const ProfileParams({
    required this.user,
  });
}