import 'package:bloc_flutter/app_router.dart';
import 'package:bloc_flutter/business_logic/cubit/charcaters_cubit.dart';
import 'package:bloc_flutter/constants/my_colors.dart';
import 'package:bloc_flutter/data/api/characters_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  CharactersApi.init();
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;
  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CharcatersCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          toolbarHeight: 70,
          backgroundColor: CustomColors.red,
          centerTitle: true,
          elevation: 0,
        )),
      ),
    );
  }
}
