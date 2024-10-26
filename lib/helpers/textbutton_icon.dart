import 'package:client/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeButton extends StatelessWidget {
  final label;
  const CustomeButton({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Visibility(
            visible: menuController.isHoveinrg(label) ||
                menuController.isActive(label),
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: Container(
              color: Colors.black,
              width: 6,
              height: 35,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(() => menuController.returnIconfor(label)),
        const SizedBox(
          width: 14,
        ),
        TextButton(
          onHover: (value) {
            if (value) {
              menuController.onHoverItem(label);
            } else {
              menuController.onHoverItem('no hover');
            }
          },
          onPressed: () {
            navigationController.navigateTo(label, '');
            menuController.changeActiveItemTo(label);
          },
          child: Obx(
            () => Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: menuController.isHoveinrg(label) ||
                            menuController.isActive(label)
                        ? Colors.black
                        : Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
