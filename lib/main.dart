import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/bloc_observer.dart';
import 'package:flutter_tasks_app/blocs/bloc_export.dart';
import 'package:flutter_tasks_app/utils/app_router.dart';
import 'package:flutter_tasks_app/utils/app_theme.dart';
import 'package:flutter_tasks_app/widgets/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // initializing the widget bindings to do the native calls with hydrated bloc
  WidgetsFlutterBinding.ensureInitialized();

  // created the storage variable instance to store the data in local storage
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  // using the HydratedBloc to implement the Hydrated bloc storage
  HydratedBloc.storage = storage;

  // using the BLOC observer to listen to the states
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksBloc()),
        BlocProvider(create: (_) => ThemeSwitchBloc()),
      ],
      child: BlocBuilder<ThemeSwitchBloc, ThemeSwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Tasks App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const BottomNavBar(),
            onGenerateRoute: appRouter.onGeneratedRoute,
          );
        },
      ),
    );
  }
}
