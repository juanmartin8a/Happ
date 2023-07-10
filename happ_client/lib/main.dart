import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:happ_client/src/screens/events/class/eventAndInviteParams.dart';
import 'package:happ_client/src/screens/events/event.dart';
import 'package:happ_client/src/screens/events/invitation/eventInvitation.dart';
import 'package:happ_client/src/screens/events/guestList/guestList.dart';
import 'package:happ_client/src/screens/events/guestList/inviteGuestsScreen.dart';
import 'package:happ_client/src/screens/events/scan/scanScreen.dart';
import 'package:happ_client/src/screens/profile/class/profileParams.dart';
import 'package:happ_client/src/screens/profile/profile.dart';
import 'package:happ_client/src/screens/profile/updateUser/updateUser.dart';
import 'package:happ_client/src/screens/profile/widgets/addedMeScreen.dart';
import 'package:happ_client/src/screens/profile/widgets/friendsScreen.dart';
import 'package:happ_client/src/screens/profile/widgets/mutualFriendsScreen.dart';
import 'package:happ_client/src/screens/search/class/SearchUserInviteResParams.dart';
import 'package:happ_client/src/screens/events/updateEvent/updateEvent.dart';
import 'package:happ_client/src/screens/settings/settings.dart';
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
    // 'https://api.happ.rsvp/query'
    'http://192.168.100.234:8080/query'
  );

  final AuthLink authLink = AuthLink(
    getToken: () async {
      String? token = await getUserIDToken(firebaseAuth);
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

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);

    return RefreshConfiguration(
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Inter",
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent, //top status bar
              systemNavigationBarColor: Colors.transparent, // navigation bar color, the one Im looking for
              statusBarIconBrightness: Brightness.dark, // status bar icons' color
              systemNavigationBarIconBrightness:
                  Brightness.light, //navigation bar icons' color
              statusBarBrightness: Brightness.light
            ),
          )
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
      GoRoute(
        path: '/new-event-guest-list',
        // name: "sample",
        pageBuilder: (BuildContext context, GoRouterState state) {
          NewEventInvitedFriendsListParams params = state.extra as NewEventInvitedFriendsListParams;

          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: NewEventGuestList(
              users: params.selectedUsers,
              organizers: params.organizers,
              eventId: params.eventId,
              key: Key("guestList_eventId_${params.eventId}")
            )
          );
          // return NewEventGuestList(
          //   users: params.selectedUsers,
          //   organizers: params.organizers,
          //   eventId: params.eventId,
          //   key: Key("guestList_eventId_${params.eventId}")
          // );
        }
      ),
      GoRoute(
        path: '/event',
        pageBuilder: (context, state) {
          EventParams params = state.extra as EventParams;

          // return MaterialPage(
          //   child: Event(
          //     inviteRes: params.inviteRes,
          //     key: Key("event_id_${params.inviteRes.event.id}")
          //   )
          // );

          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state, 
            child: Event(
              inviteRes: params.inviteRes,
              key: Key("event_id_${params.inviteRes.event.id}")
            )
          );
        }
      ),
      // EventInvitation
      GoRoute(
        path: '/event-invitation',
        pageBuilder: (BuildContext context, GoRouterState state) {

          InviteParams params = state.extra as InviteParams;
          
          // return EventInvitation(
          //   event: params.event,
          //   cypherText: params.cypherText,
          //   key: Key("invitation_event_id_${params.event.id}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: EventInvitation(
              event: params.event,
              cypherText: params.cypherText,
              image: params.image,
              key: Key("invitation_event_id_${params.event.id}")
            )
          );
        }
      ),
      GoRoute(
        path: '/event-guest-list',
        pageBuilder: (BuildContext context, GoRouterState state) {

          EventGuestListParams params = state.extra as EventGuestListParams;
          
          // return GuestList(
          //   eventId: params.eventId,
          //   isHost: params.isHost,
          //   isCreator: params.isCreator,
          //   paginatedHostsRes: params.paginatedHostsRes,
          //   paginatedGuestRes: params.paginatedGuestsRes,
          //   key: Key("event_guest_list_${params.eventId}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: GuestList(
              eventId: params.eventId,
              isHost: params.isHost,
              isCreator: params.isCreator,
              paginatedHostsRes: params.paginatedHostsRes,
              paginatedGuestRes: params.paginatedGuestsRes,
              key: Key("event_guest_list_${params.eventId}")
            )
          );
        }
      ),
      GoRoute(
        path: '/update-event',
        pageBuilder: (BuildContext context, GoRouterState state) {

          EventParams params = state.extra as EventParams;
          
          // return UpdateEvent(
          //   inviteRes: params.inviteRes,
          //   key: Key("update_event_id_${params.inviteRes.event.id}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: UpdateEvent(
              inviteRes: params.inviteRes,
              key: Key("update_event_id_${params.inviteRes.event.id}")
            )
          );
        }
      ),
      GoRoute(
        path: '/invite-guests',
        pageBuilder: (BuildContext context, GoRouterState state) {

          InviteGuestsScreenParams params = state.extra as InviteGuestsScreenParams;
          
          // return InviteNewGuests(
          //   eventId: params.eventId,
          //   key: Key("invite_guests_${params.eventId}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: InviteNewGuests(
              eventId: params.eventId,
              key: Key("invite_guests_${params.eventId}")
            )
          );
        }
      ),
      GoRoute(
        path: '/scan-pass',
        pageBuilder: (BuildContext context, GoRouterState state) {

          InviteGuestsScreenParams params = state.extra as InviteGuestsScreenParams;
          
          // return ScanScreen(
          //   eventId: params.eventId,
          //   key: Key("scan_screen_${params.eventId}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: ScanScreen(
              eventId: params.eventId,
              key: Key("scan_screen_${params.eventId}")
            )
          );
        }
      ),
      GoRoute(
        path: '/profile',
        pageBuilder: (BuildContext context, GoRouterState state) {

          ProfileParams params = state.extra as ProfileParams;
          
          // return Profile(
          //   user: params.user,
          //   key: Key("profie_screen_${params.user.id}")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: Profile(
              user: params.user,
              key: Key("profie_screen_${params.user.id}")
            )
          );
        }
      ),
      GoRoute(
        path: '/update-user',
        pageBuilder: (BuildContext context, GoRouterState state) {

          ProfileParams params = state.extra as ProfileParams;
          
          // return UpdateUser(
          //   user: params.user,
          //   key: const Key("update_user_screen")
          // );
          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: UpdateUser(
              user: params.user,
              key: const Key("update_user_screen")
            )
          );
        }
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (BuildContext context, GoRouterState state) {

          // return const Settings();

          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: const Settings()
          );
        }
      ),
      GoRoute(
        path: '/added-me',
        pageBuilder: (BuildContext context, GoRouterState state) {

          AddedMeParams params = state.extra as AddedMeParams;

          // return AddedMeScreen(
          //   addedMeUsers: params.addedMeUsers,
          //   uuid: params.uuid,
          //   hasMore: params.hasMore,
          //   key: const Key("addedMe")
          // );

          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: AddedMeScreen(
              addedMeUsers: params.addedMeUsers,
              uuid: params.uuid,
              hasMore: params.hasMore,
              key: const Key("addedMe")
            )
          );
        }
      ),
      GoRoute(
        path: '/my-friends',
        pageBuilder: (BuildContext context, GoRouterState state) {

          MyFriendsParams params = state.extra as MyFriendsParams;

          // return FriendsScreen(
          //   users: params.users, 
          //   hasMore: params.hasMore, 
          //   uuid: params.uuid,
          //   key: const Key("friends")
          // );

          return buildPageWithDefaultTransition<void>(
            context: context, 
            state: state,
            child: FriendsScreen(
              users: params.users, 
              hasMore: params.hasMore, 
              uuid: params.uuid,
              key: const Key("friends")
            )
          );
        }
      ),
      GoRoute(
        path: '/mutual-friends',
        pageBuilder: (BuildContext context, GoRouterState state) {

          MutualFriendsParams params = state.extra as MutualFriendsParams;

          // return MutualFriendsScreen(
          //   userId: params.userId,
          //   users: params.users,
          //   hasMore: params.hasMore,
          //   uuid: params.uuid,
          //   key: const Key("friends")
          // );

          return buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: MutualFriendsScreen(
              userId: params.userId,
              users: params.users,
              hasMore: params.hasMore,
              uuid: params.uuid,
              key: const Key("friends")
            )
          );
        }
      ),
    ],
  );
}

dynamic buildPageWithDefaultTransition<T>({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {

  if (Platform.isIOS) {
    return MaterialPage(
      child: child
    );
  }

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      )), child: child);
    }
  );
}
