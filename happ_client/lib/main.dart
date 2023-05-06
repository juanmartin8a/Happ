import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/events/event.dart';
import 'package:happ_client/src/screens/events/invitation/eventInvitation.dart';
import 'package:happ_client/src/screens/events/guestList/guestList.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsScreen.dart';
import 'package:happ_client/src/screens/events/scan/scanScreen.dart';
import 'package:happ_client/src/screens/search/class/SearchUserInviteResParams.dart';
import 'package:happ_client/src/screens/events/updateEvent/updateEvent.dart';
import 'package:happ_client/src/utils/getUserIdFromFBIDToken.dart';
import 'package:happ_client/src/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'src/client/client.dart';
import 'src/screens/events/newEvent/IScreen/newEventGuestList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await initHiveForFlutter();

  await Hive.openBox('myBox');

  final firebaseAuth = FirebaseAuth.instance;

  final HttpLink httpLink = HttpLink(
    'http://192.168.100.88:8080/query',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      String? token = await getUserIDToken(firebaseAuth);
      print("token: $token");
      return token != null ? "Bearer $token" : null;
    },
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );


  Client.client = client.value;

  // print(Client.client.);

  // print("hey");

  // await JWT().deleteAll();
  // final token = await JWT().getJWT();
  // print("token: $token");

  // await JWT().deleteAll();

  // final token2 = await JWT().getJWT();
  // print("token2: $token2");
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // // final SignInWithApple _appleSignIn = SignInWithApple.;
  // await _auth.signOut();
  // await _googleSignIn.signOut();
  // // await _appleSignIn.
  // print("aaaa");

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final router = ref.watch(routerProvider);

    return RefreshConfiguration(
      // footerTriggerDistance: 15,
      // dragSpeedRatio: 0.91,
      headerTriggerDistance: 60,
      headerBuilder: () => const MaterialClassicHeader(),
      footerBuilder: () => const ClassicFooter(),
      enableLoadingWhenNoData: false,
      enableRefreshVibrate: false,
      enableLoadMoreVibrate: false,
      shouldFooterFollowWhenNotFull: (state) {
        // If you want load more with noMoreData state ,may be you should return false
        return false;
      },
      child: MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        // rou
        // theme: theme.copyWith(
        //   colorScheme: theme.colorScheme.copyWith(
        //     primary: Colors.black,
        //     secondary: Colors.blue,
        //   ),
        // ),
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          fontFamily: "Inter",//"Montserrat"//"Rubik", //"Kumbh_Sans" //"Metropolis" // "Kumbh_Sans" // "Hind"//"MPlus1",
          // textTheme: GoogleFonts.mPlus1pTextTheme(
          //   Theme.of(context).textTheme,
          // ),
          // appBarTheme: const AppBarTheme(
          //   foregroundColor: Colors.black,
          //   systemOverlayStyle: SystemUiOverlayStyle(
          //     // statusBarColor: Colors.green, // <-- SEE HERE
          //     statusBarIconBrightness: Brightness.light, //<-- For Android SEE HERE (dark icons)
          //     statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
          //   ),
          // )
        ),
        title: 'Happ',
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const Wrapper(),
      ),
      // GoRoute(
      //   path: '/sign_in',
      //   builder: (BuildContext context, GoRouterState state) => const SignIn(),
      // ),
      // GoRoute(
      //   path: '/sign_up',
      //   builder: (BuildContext context, GoRouterState state) => const SignUp(),
      // ),
      // GoRoute(
      //   path: '/profile',
      //   builder: (BuildContext context, GoRouterState state) {
      //     final userAccessUser = UserTypesConverter().convertToUserAccessUser(state.extra);

      //     return Profile(
      //       user: userAccessUser,
      //       key: Key("user_id_${userAccessUser.id}")
      //     );
      //   }
      // ),
      GoRoute(
        path: '/new-event-guest-list',
        // name: "sample",
        builder: (BuildContext context, GoRouterState state) {
          NewEventInvitedFriendsListParams params = state.extra as NewEventInvitedFriendsListParams;
          return NewEventGuestList(
            users: params.selectedUsers,
            organizers: params.organizers,
            eventId: params.eventId,
            key: Key("guestList_eventId_${params.eventId}")
          );
        }
      ),
      GoRoute(
        path: '/event',
        builder: (BuildContext context, GoRouterState state) {
          EventParams params = state.extra as EventParams;
          
          return Event(
            inviteRes: params.inviteRes,
            key: Key("event_id_${params.inviteRes.event.id}")
          );
        }
      ),
      // EventInvitation
      GoRoute(
        path: '/event-invitation',
        builder: (BuildContext context, GoRouterState state) {

          InviteParams params = state.extra as InviteParams;
          
          return EventInvitation(
            event: params.event,
            cypherText: params.cypherText,
            key: Key("invitation_event_id_${params.event.id}")
          );
        }
      ),
      GoRoute(
        path: '/event-guest-list',
        builder: (BuildContext context, GoRouterState state) {

          EventGuestListParams params = state.extra as EventGuestListParams;
          
          return GuestList(
            eventId: params.eventId,
            isHost: params.isHost,
            isCreator: params.isCreator,
            paginatedHostsRes: params.paginatedHostsRes,
            paginatedGuestRes: params.paginatedGuestsRes,
            key: Key("event_guest_list_${params.eventId}")
          );
        }
      ),
      GoRoute(
        path: '/update-event',
        builder: (BuildContext context, GoRouterState state) {

          EventParams params = state.extra as EventParams;
          
          return UpdateEvent(
            inviteRes: params.inviteRes,
            key: Key("update_event_id_${params.inviteRes.event.id}")
          );
        }
      ),
      GoRoute(
        path: '/invite-guests',
        builder: (BuildContext context, GoRouterState state) {

          InviteGuestsScreenParams params = state.extra as InviteGuestsScreenParams;
          
          return InviteNewGuests(
            eventId: params.eventId,
            key: Key("invite_guests_${params.eventId}")
          );
        }
      ),
      GoRoute(
        path: '/scan-pass',
        builder: (BuildContext context, GoRouterState state) {

          InviteGuestsScreenParams params = state.extra as InviteGuestsScreenParams;
          
          return ScanScreen(
            eventId: params.eventId,
            key: Key("scan_screen_${params.eventId}")
          );
        }
      ),
    ],
  );
}
