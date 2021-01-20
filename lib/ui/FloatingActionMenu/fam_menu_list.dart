import 'package:cubaros/ui/FloatingActionMenu/fam_item_position.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_menu_list_item.dart';
import 'package:cubaros/ui/FloatingActionMenu/fam_sliding_controller.dart';
import 'package:cubaros/ui/FloatingActionMenu/utils/fam_aligns.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final OptionsListViewModel menuOptionsListViewModel = new OptionsListViewModel(
  options: [
    new OptionsListItemViewModel(
      icon: Icons.format_bold,
      title: 'Bold',
      isSelected: false,
      onPressed: () {},
    ),
    new OptionsListItemViewModel(
      icon: Icons.format_italic,
      title: 'Italic',
      isSelected: false,
      onPressed: () {},
    ),
    new OptionsListItemViewModel(
      icon: Icons.format_underlined,
      title: 'Underline',
      isSelected: false,
      onPressed: () {},
    ),
    new OptionsListItemViewModel(
      icon: Icons.format_color_fill,
      title: 'Color Fill',
      isSelected: true,
      onPressed: () {},
    ),
    new OptionsListItemViewModel(
      icon: Icons.format_color_text,
      title: 'Color Text',
      isSelected: false,
      onPressed: () {},
    ),
  ],
);

class OptionList extends StatelessWidget {
  final OptionsListViewModel optionsList;
  final SlidingOptionListController controller;
  final WidgetAlignment widgetAlignment;

  const OptionList({
    Key key,
    this.optionsList,
    this.controller,
    this.widgetAlignment,
  }) : super(key: key);

  List<Widget> _getOptionsItems() {
    int index = 0;
    return optionsList.options.map((OptionsListItemViewModel viewModel) {
      final listItem = _listItem(viewModel, controller.getItemAngle(index));
      ++index;
      return listItem;
    }).toList();
  }

  Widget _listItem(OptionsListItemViewModel viewModel, double angle) {
    return OptionPosition(
      radius: 130.0,
      angle: angle,
      alignment: widgetAlignment,
      child: new OptionListItem(
        listItem: viewModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return new Stack(
          children: _getOptionsItems(),
        );
      },
    );
  }
}
