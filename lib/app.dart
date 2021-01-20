import 'package:cubaros/ui/FloatingActionMenu/utils/fam_colors.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  final Widget initPage;

  App({
    @required this.initPage,
  });

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getApp();
  }

  Widget getApp({String localeCode}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cubaros',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: FamColor.deep_blue,
        unselectedWidgetColor: FamColor.light_blue,
        appBarTheme: AppBarTheme(
          color: FamColor.blue,
        ),
      ),
      home: widget.initPage,
    );
  }
}
