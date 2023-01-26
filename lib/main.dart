import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/setters.dart';
import 'package:dostavka/models/hive_connection/update.dart';
import 'package:dostavka/repositories/temporary_repository.dart';
import 'package:dostavka/screens/history.dart';
import 'package:dostavka/screens/map/google_map_screen_first.dart';
import 'package:dostavka/screens/pin/authentication_pin_page.dart';
import 'package:dostavka/screens/profile/profile.dart';
import 'package:dostavka/screens/registration/welcome/registration.dart';
import 'package:dostavka/widgets/bottom_nav.dart';
import 'package:dostavka/screens/sendings/tab.dart';
import 'package:dostavka/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dostavka/models/hive_connection/rep_data.dart';
import 'package:dostavka/models/hive_connection/getters.dart';
import 'package:dostavka/models/hive_connection/setters.dart';

import 'package:dostavka/blocs/bottom_nav/bottom_nav_bloc.dart';
import 'package:dostavka/blocs/bottom_nav/bottom_nav_events.dart';
import 'package:dostavka/blocs/bottom_nav/bottom_nav_states.dart';
import 'package:location/location.dart';
import 'package:logging/logging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


Map<int, Color> color = {
  50: const Color.fromRGBO(240, 103, 76, .1),
  100: const Color.fromRGBO(240, 103, 76, .2),
  200: const Color.fromRGBO(240, 103, 76, .3),
  300: const Color.fromRGBO(240, 103, 76, .4),
  400: const Color.fromRGBO(240, 103, 76, .5),
  500: const Color.fromRGBO(240, 103, 76, .6),
  600: const Color.fromRGBO(240, 103, 76, .7),
  700: const Color.fromRGBO(240, 103, 76, .8),
  800: const Color.fromRGBO(240, 103, 76, .9),
  900: const Color.fromRGBO(240, 103, 76, 1),
};
MaterialColor colorPrimary = MaterialColor(0xffF0674C, color);
bool val = false;

Location _location = Location();
User user = User();


void main() async {
  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // OneSignal.shared.setAppId("af45fd43-b8e9-43b7-acd5-fc6370ce6efc");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
//   OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
//     print("Accepted permission: $accepted");
//   });

  WidgetsFlutterBinding.ensureInitialized();

  _setupLogging();

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(AuthAdapter());
  Hive.registerAdapter(CargoAdapter());
  Hive.registerAdapter(DraftAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(CookieAdapter());
  Hive.registerAdapter(SuggestAdapter());
  Hive.registerAdapter(SecurityAdapter());
  Hive.registerAdapter(CreateOrderAdapter());
  Hive.registerAdapter(OrdTakerAdapter());

  await Hive.openBox<User>('user');
  await Hive.openBox<Address>('address');
  await Hive.openBox<Auth>('auth');
  await Hive.openBox<Cargo>('cargo');
  await Hive.openBox<Draft>('draft');
  await Hive.openBox<Order>('order');
  await Hive.openBox<Cookie>('cookie');
  await Hive.openBox<Suggest>('suggest');
  await Hive.openBox<Security>('security');
  await Hive.openBox<CreateOrder>('create_order');
  await Hive.openBox<OrdTaker>('ord_taker');

  final usr = Getters.getUser().toMap();
  if (usr.isNotEmpty) {
    user = Getters.getUser().values.first;
  } else {
    Setters.addUser();
    user = Getters.getUser().values.first;
  }

  final addr = Getters.getAddress().toMap();
  if (addr.isEmpty) {
    Setters.addAddress();
  }

  final auth = Getters.getAuth().toMap();
  if (auth.isEmpty) {
    Setters.addAuth();
  }

  final cargo = Getters.getCargo().toMap();
  if (cargo.isEmpty) {
    Setters.addCargo();
  }

  final draft = Getters.getDraft().toMap();
  if (draft.isEmpty) {
    Setters.addDraft();
  }

  final ord = Getters.getOrder().toMap();
  if (ord.isEmpty) {
    Setters.addOrder();
  }

  final cookie = Getters.getCookie().toMap();
  if (cookie.isEmpty) {
    Setters.addCookie();
  }

  final suggest = Getters.getSuggest().toMap();
  if (suggest.isEmpty) {
    Setters.addSuggest();
  }

  final sec = Getters.getSecurity().toMap();
  if (sec.isEmpty) {
    Setters.addSecurity();
  }

  final croco = Getters.getCreateOrder().toMap();
  if (croco.isEmpty) {
    Setters.addCreateOrder();
  }

  final ordo = Getters.getOrdTaker().toMap();
  if (ordo.isEmpty) {
    Setters.addOrdTaker();
  }

  runMain(Getters.getUser().values.first.is_login);
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

runMain(bool b) {
  Widget app;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (b) {
    app = const AuthenticationPIN();
  } else {
    app = const Registration();
  }
  runApp(app);
}

void upd() async{
  await _location.getLocation().then((l) async {
    Update.EditUser(user, lat: l.latitude ?? 0.0, lon: l.longitude ?? 0.0);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.page = 0}) : super(key: key);

  final int page;

  static Route route(page) {
    return MaterialPageRoute<void>(builder: (_) => MyApp(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: colorPrimary,
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFFFFFFF),
        ),
        home: BlocProvider(
          create: (_) => BottomNavBloc(),
          child: Home(page: page),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.page}) : super(key: key);

  final int page;
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
  );

  @override
  Widget build(BuildContext context) {
    upd();
    switch(widget.page) {
      case 0:
        {
          BlocProvider.of<BottomNavBloc>(context).getItem(
              BottomNavEvents.sending);
          break;
        }
      case 1:
        {
          BlocProvider.of<BottomNavBloc>(context).getItem(
              BottomNavEvents.history);
          break;
        }
      case 2:
        {
          BlocProvider.of<BottomNavBloc>(context).getItem(
              BottomNavEvents.map);
          break;
        }
      case 3:
        {
          BlocProvider.of<BottomNavBloc>(context).getItem(
              BottomNavEvents.profile);
          break;
        }
      default:
        {
          BlocProvider.of<BottomNavBloc>(context).getItem(
              BottomNavEvents.sending);
          break;
        }
    }
    return BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
      String title;
      bool tabs;
      int? buttonLeft;
      int? buttonRight;
      int pageId;

      switch (state.page) {
        case BottomNavEvents.sending:
          {
            title = 'Мои посылки';
            buttonLeft = 1;
            buttonRight = 3;
            tabs = true;
            pageId = 0;
            break;
          }
        case BottomNavEvents.history:
          {
            title = 'История';
            buttonLeft = 1;
            buttonRight = null;
            tabs = true;
            pageId = 1;
            break;
          }
        case BottomNavEvents.map:
          {
            title = 'Карта отправлений';
            buttonLeft = null;
            buttonRight = null;
            tabs = false;
            pageId = 2;
            break;
          }
        case BottomNavEvents.profile:
          {
            title = 'Мой профиль';
            buttonLeft = null;
            buttonRight = null;
            tabs = false;
            pageId = 3;
            break;
          }
        default:
          title = '';
          buttonLeft = null;
          buttonRight = null;
          tabs = false;
          pageId = 0;
          break;
      }

      final pages = [
        Tab1(
          tabController: tabController,
        ),
        Tab2(
          tabController: tabController,
        ),
        GoogleMapScreenFirst(),
        const Profile(),
      ];

      return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: (pageId != 2)
                ? Navbar(
                    title: title,
                    buttonLeft: buttonLeft,
                    buttonRight: buttonRight,
                    tabs: tabs,
                    tabController: tabController,
                  )
                : null,
            bottomNavigationBar: const BottomNav(),
            body: pages[pageId],
          ));
    });
  }
}

// Home Tab
class Tab1 extends StatelessWidget {
  const Tab1({Key? key, required this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: const [
      Received(
        tab: 0,
      ),
      Received(
        tab: 1,
      ),
    ]);
  }
}

class Tab2 extends StatelessWidget {
  const Tab2({Key? key, required this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: const [
      History(
        tab: 0,
      ),
      History(
        tab: 1,
      ),
    ]);
  }
}