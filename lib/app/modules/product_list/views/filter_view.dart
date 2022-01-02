import 'package:custom_utils/spacing_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/app/core/global_widgets/buttons.dart';
import 'package:shopping_app/app/core/theme/color_theme.dart';
import 'package:shopping_app/app/core/utils/helper.dart';
import 'package:shopping_app/app/core/values/strings.dart';
import 'package:shopping_app/app/modules/product_list/controllers/filter_controller.dart';
import 'package:shopping_app/app/modules/product_list/controllers/filters_sheet_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:shopping_app/app/core/theme/sizing_theme.dart';

class FilterBar extends StatelessWidget {
  final Filters filters;

  FilterBar({Key? key, required this.filters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FiltersSheetController(filters));
    return BottomSheet(
      onClosing: () {},
      enableDrag: false,
      shape: RoundedRectangleBorder(borderRadius: Sizing.borderRadiusXL),
      builder: (context) {
        return Padding(
          padding: Sizing.sidePadding,
          child: _Filters().py16(),
        );
      },
    );
  }
}

class _Filters extends GetView<FiltersSheetController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        "Filters"
            .text
            .bold
            .size(24)
            .color(ColorTheme.headerColor)
            .textStyle(GoogleFonts.varelaRound())
            .makeCentered(),
        verSpacing20,
        if (controller.filters.minPrice != controller.filters.maxPrice)
          ...priceWidgets,
        if (controller.sizeList.isNotEmpty) ...sizeWidgets,
        if (controller.colorList.isNotEmpty) ...colorWidgets,
        verSpacing16,
        AppTextButton(
          onTap: controller.onSaveFilterTap,
          child: ("Save Filter").text.size(16).bold.make(),
        ),
        verSpacing16,
        AppOutlinedButton(
          onTap: controller.onClearFilters,
          child: ("Clear Filter").text.size(16).bold.make(),
        ),
      ],
    );
  }

  List<Widget> get colorWidgets {
    return [
      verSpacing16,
      _subHeading("Color"),
      verSpacing8,
      _ColorGroup(),
    ];
  }

  List<Widget> get sizeWidgets {
    return [
      _subHeading("Size"),
      verSpacing8,
      _SizeGroup(),
    ];
  }

  List<Widget> get priceWidgets {
    return [
      _subHeading("Price"),
      verSpacing8,
      _PriceRangeSlider(),
      _MinMaxPrice(),
      verSpacing16,
    ];
  }

  Widget _subHeading(String label) {
    return label.text.size(18).color(ColorTheme.headerColor).make();
  }
}

class _MinMaxPrice extends GetView<FiltersSheetController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var _minPrice = controller.minPrice.value;
      var _maxPrice = controller.maxPrice.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          "$rsSign$_minPrice".text.size(16).bold.make(),
          "$rsSign$_maxPrice".text.size(16).bold.make(),
        ],
      ).px16();
    });
  }
}

class _PriceRangeSlider extends GetView<FiltersSheetController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RangeSlider(
        min: controller.filters.minPrice!,
        max: controller.filters.maxPrice!,
        values: controller.priceRange.value,
        onChanged: controller.onPriceChange,
      ),
    );
  }
}

class _SizeGroup extends GetView<FiltersSheetController> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        for (final size in controller.sizeList)
          Obx(
            () => CustomChip(
              isSelected: controller.size.value == size,
              label: size,
              onSelected: (_) => controller.changeSelectedSize(size),
            ),
          )
      ],
    );
  }
}

class _ColorGroup extends GetView<FiltersSheetController> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        for (final color in controller.colorList)
          Obx(
            () => CustomChip(
              isSelected: controller.color.value == color,
              label: color,
              onSelected: (_) => controller.changeSelectedColor(color),
            ),
          )
      ],
    );
  }
}

class CustomChip extends StatelessWidget {
  final void Function(bool)? onSelected;

  final bool isSelected;

  final String label;

  CustomChip({
    Key? key,
    required this.isSelected,
    required this.label,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      padding: const EdgeInsets.all(8),
      labelStyle: TextStyle(
        fontSize: 18,
        color: MaterialStateColor.resolveWith(
          (state) {
            if (state.contains(MaterialState.selected)) {
              return Vx.white;
            } else {
              return Vx.black;
            }
          },
        ),
      ),
      selectedColor: primaryColor(context),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}

// class CustomChip extends GetView<FiltersSheetController> {
//   final SortBy sortBy;
//   final String label;
//   CustomChip(this.sortBy, this.label);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ChoiceChip(
//         onSelected: (v) => controller.changeSorting(sortBy),
//         label: label.text.make(),
//         selected: controller.sortBy.value == sortBy,
//       ),
//     );
//   }
// }
