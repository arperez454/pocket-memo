import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OptionListItem extends StatelessWidget {
  final OptionsListItemViewModel listItem;

  const OptionListItem({Key key, this.listItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Transform(
      transform: Matrix4.translationValues(0, 0.0, 0.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: size.width / 7,
              height: size.width / 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: listItem.isSelected ? Colors.cyan : Colors.transparent,
                border: Border.all(
                  color: listItem.isSelected ? Colors.cyan : Colors.cyan,
                  width: 2.0,
                ),
              ),
              child: Icon(
                listItem.icon,
                color: listItem.isSelected ? Colors.white : Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionsListViewModel {
  final List<OptionsListItemViewModel> options;

  OptionsListViewModel({this.options = const []});
}

class OptionsListItemViewModel {
  final IconData icon;
  final String title;
  final bool isSelected;
  final onPressed;

  OptionsListItemViewModel(
      {this.icon, this.title = '', this.isSelected = false, this.onPressed});
}
