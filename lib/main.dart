import 'package:best_news/bloc/cubit.dart';
import 'package:best_news/bloc/states.dart';
import 'package:best_news/network/cache_helper.dart';
import 'package:best_news/pages/home.dart';
import 'package:best_news/pages/serach_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Observer.dart';
import 'network/Dio.dart';

void main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();
  bool? isDark = CachHelper.get(key: 'isDark');
  BlocOverrides.runZoned(
        () {
          runApp( MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
}
class MyApp extends StatelessWidget {
  bool? isDark;
    MyApp(this.isDark,  {Key? key,  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context)=> NewsCubit()..getBusiness()..changemode(
        fromShared: isDark,
      ),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: ( context, state) {  },
        builder: ( context,  state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              floatingActionButtonTheme: const FloatingActionButtonThemeData(),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.red,
                elevation: 20.0,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.red,
                    statusBarBrightness: Brightness.light,
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                      color: Colors.red,
                      size: 30
                  )
              ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )
                )
            ),
            darkTheme: ThemeData(
                primarySwatch: Colors.red,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(),
                bottomNavigationBarTheme:  BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.red,
                    elevation: 20.0,
                    backgroundColor: Colors.grey[800],
                    unselectedItemColor: Colors.white
                ),
                scaffoldBackgroundColor: Colors.grey[800],
                appBarTheme:  AppBarTheme(
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.grey,
                      statusBarBrightness: Brightness.dark,
                    ),
                    elevation: 0.0,
                    backgroundColor: Colors.grey[800],
                    titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                    iconTheme: const IconThemeData(
                        color: Colors.white,
                        size: 30
                    )
                ),
                textTheme: const TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                )
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: 'Intro',
            routes: {
              'Intro' :(context) => const Home(),
              'Search' :(context) =>  Search(),
            },
          );
        },
      ),
    );
  }
}
