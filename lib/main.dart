import 'package:bee/screens/login_screen/cubit/login_cubit.dart';
import 'package:bee/screens/register_screen/cubit/register_cubit.dart';
import 'package:bee/screens/splash_screen/splash_screen.dart';
import 'package:bee/shared/bloc_observer/bloc_observer.dart';
import 'package:bee/shared/components/const.dart';
import 'package:bee/shared/cubit/app_cubit.dart';
import 'package:bee/shared/network/local/cash_helper.dart';
import 'package:bee/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  token = CashHelper.getCashedData(key: 'token');
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarContrastEnforced: true,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  BlocOverrides.runZoned(
    () {
      LoginCubit();
      RegisterCubit();
      AppCubit();
      runApp(MyApp());
    },
    blocObserver: MyBlocObserver(),
  );

  print(token);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit()
          ..getUser()
          ..getHome()..getFavorites()
          ..getCart()
          ..getOrdars()
          ..getCategory()
          ..getQuestions(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
            home: SplashScreen(),
          ),
        ));
  }
}
