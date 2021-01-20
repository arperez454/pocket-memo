import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FamAppBar extends StatelessWidget with PreferredSizeWidget {
  final Function setState;
  final Function alignSwitch;

  FamAppBar({@required this.setState, this.alignSwitch});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
