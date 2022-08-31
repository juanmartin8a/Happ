import 'package:happ_client/src/api/graphql/graphql_api.dart';
import 'package:happ_client/src/client/customLink.dart';
import 'package:happ_client/src/screens/auth/signIn.dart';
import 'package:happ_client/src/screens/auth/signUp.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/search/search.dart';
import 'package:happ_client/src/utils/jwt.dart';
import 'package:happ_client/src/utils/user/userTypesConverter.dart';
import 'package:happ_client/src/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'src/client/client.dart';

void main() async {

  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'http://localhost:8080/query',
  );

  final Link link;
  final CustomLink customLink = CustomLink();
  link = customLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  print(Client.client);

  Client.client = client.value;

  // print("hey");

  // await JWT().deleteAll();
  // final token = await JWT().getJWT();
  // print("token: $token");

  // await JWT().deleteAll();

  // final token2 = await JWT().getJWT();
  // print("token2: $token2");

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      // theme: theme.copyWith(
      //   colorScheme: theme.colorScheme.copyWith(
      //     primary: Colors.black,
      //     secondary: Colors.blue,
      //   ),
      // ),
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        fontFamily: "Inter"//"Montserrat"//"Rubik", //"Kumbh_Sans" //"Metropolis" // "Kumbh_Sans" // "Hind"//"MPlus1",
        // textTheme: GoogleFonts.mPlus1pTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      title: 'Clivy',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const Wrapper(),
      ),
      GoRoute(
        path: '/sign_in',
        builder: (BuildContext context, GoRouterState state) => const SignIn(),
      ),
      GoRoute(
        path: '/sign_up',
        builder: (BuildContext context, GoRouterState state) => const SignUp(),
      ),
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          final userAccessUser = UserTypesConverter().convertToUserAccessUser(state.extra);

          return Profile(
            user: userAccessUser,
            key: Key("user_id_${userAccessUser.id}")
          );
        }
      ),
    ],
  );
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Wrapper(),
    );
  }
}
