import 'package:cubaros/ui/FloatingActionMenu/fam_main.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_menu_list.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_sliding_controller.dart';
import 'package:cubaros/ui/FloatingActionMenu/utils/fam_aligns.dart';
import 'package:cubaros/ui/FloatingActionMenu/utils/fam_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  SlidingOptionListController slidingOptionListController;
  bool animateUP;
  WidgetAlignment widgetAlignment;

  @override
  void initState() {
    super.initState();

    animateUP = false;

    widgetAlignment = WidgetAlignment.right;

    slidingOptionListController = new SlidingOptionListController(
        vsync: this,
        itemCount: menuOptionsListViewModel.options.length,
        animateDirection: AnimateDirection.UP)
      ..close()
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget configuration'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showModalBottomSheet<void>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return bottomSheet(animateUP);
                  });
            },
          ),
        ],
      ),
      drawerEnableOpenDragGesture: true,
      body: Stack(
        children: <Widget>[
          ListView(
            reverse: true,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Left to Right direction",
                  style: TextStyle(
                    color: FamColor.golden,
                  ),
                ),
                leading: alignSwitch(animateUP),
              ),
              ListTile(
                title: Text(
                  'WidgetAlignment',
                  style: TextStyle(
                    color: FamColor.golden,
                  ),
                ),
                leading: DropdownButton(
                  value: widgetAlignment,
                  onChanged: (value) {
                    setState(() {
                      widgetAlignment = value;
                    });
                  },
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'Right',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      value: WidgetAlignment.right,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Top',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      value: WidgetAlignment.top,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Down',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      value: WidgetAlignment.bottom,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'Left',
                        style: TextStyle(color: Colors.cyan),
                      ),
                      value: WidgetAlignment.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
          FloatingActionMenu(
            slidingOptionListController: slidingOptionListController,
            optionList: menuOptionsListViewModel,
            onMenuTap: () {
              setState(() {
                slidingOptionListController.isOpened()
                    ? slidingOptionListController.close()
                    : slidingOptionListController.open();
              });
            },
            widgetAlignment: widgetAlignment,
          ),
        ],
      ),
    );
  }

  Widget alignSwitch(bool animateUP) {
    return Switch(
      value: animateUP,
      onChanged: (value) {
        setState(() {
          this.slidingOptionListController = new SlidingOptionListController(
              vsync: this,
              itemCount: menuOptionsListViewModel.options.length,
              animateDirection:
                  value ? AnimateDirection.DOWN : AnimateDirection.UP)
            ..close()
            ..addListener(() => setState(() {}));
          changeAnimateDirection();
        });
      },
      inactiveThumbColor: Colors.white,
      activeColor: Colors.white,
      activeTrackColor: Colors.greenAccent,
      inactiveTrackColor: Colors.redAccent,
    );
  }

  changeAnimateDirection() {
    this.animateUP = !this.animateUP;
    print(this.animateUP);
  }

  bottomSheet(bool animateUP) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
        color: Color(0xff232f34),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 36.0,
          ),
          SizedBox(
            height: (49 * 6).toDouble(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Color(0xff344955),
              ),
              child: Stack(
                alignment: Alignment(0, 0),
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    top: -36,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Color(0xff232f34), width: 10),
                      ),
                      child: Center(
                        child: ClipOval(
                          child: Icon(
                            Icons.settings,
                            color: FamColor.golden,
                            size: 26.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "Alignment",
                            style: TextStyle(
                              color: FamColor.golden,
                            ),
                          ),
                          leading: alignSwitch(animateUP),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
