import 'package:cubaros/ui/FloatingActionMenu/fam_menu_list.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_menu_list_item.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_sliding_controller.dart';
import 'package:cubaros/ui/FloatingActionMenu/utils/fam_aligns.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionMenu extends StatelessWidget {
  final OptionsListViewModel optionList;
  final List<Widget> children;
  final SlidingOptionListController slidingOptionListController;
  final Function onMenuTap;
  final WidgetAlignment widgetAlignment;

  const FloatingActionMenu({
    Key key,
    @required this.optionList,
    @required this.slidingOptionListController,
    @required this.onMenuTap,
    this.widgetAlignment,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Matrix4 transformation = new Matrix4.translationValues(size.width * 0.50, 0.0, 0.0);

    switch (widgetAlignment) {
      case WidgetAlignment.right:
        transformation =
            new Matrix4.translationValues(size.width * 0.50, 0.0, 0.0);
        break;
      case WidgetAlignment.left:
        transformation =
            new Matrix4.translationValues(-size.width * 0.50, 0.0, 0.0);
        break;
      case WidgetAlignment.top:
        transformation =
            new Matrix4.translationValues(0.0, -size.height * 0.45, 0.0);
        break;
      case WidgetAlignment.bottom:
        transformation =
            new Matrix4.translationValues(0.0, size.height * 0.45, 0.0);
        break;
    }

    return Center(
      child: Transform(
        transform: transformation,
        child: Stack(
          children: <Widget>[
            Container(
              width: size.width / 6,
              height: size.width / 6,
              decoration:
                  BoxDecoration(color: Colors.cyan, shape: BoxShape.circle),
              child: InkWell(
                onTap: onMenuTap,
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                    size: size.width / 9,
                  ),
                ),
              ),
            ),
            OptionList(
              controller: slidingOptionListController,
              optionsList: optionList,
              widgetAlignment: widgetAlignment,
            ),
          ],
        ),
      ),
    );
  }
}
