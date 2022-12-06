import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layouts/news_app/news_layout.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'layouts/news_app/cubit/cubit.dart';
import 'layouts/news_app/cubit/dark_mode_cubit.dart';
import 'layouts/news_app/cubit/dark_mode_states.dart';
import 'shared/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  BlocOverrides.runZoned(
        () async{
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      isDark = CacheHelper.getData(key: 'isDark');
      runApp(MyApp(isDark: isDark));
    },
  );
}

class MyApp extends StatelessWidget{
  bool? isDark;

  MyApp({this.isDark});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness(),),
        BlocProvider(create: (context) => DarkModeCubit()..changeAppMode(fromShared: isDark)),
      ],
      child: BlocConsumer<DarkModeCubit,DarkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DarkModeCubit cubit = DarkModeCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:Builder(
              builder: (context) {
                return NewsLayout();
              },
            ),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:DarkModeCubit.get(context).isDark == true ? ThemeMode.dark:ThemeMode.light,
          );
        },
      ),
    );
  }
}
