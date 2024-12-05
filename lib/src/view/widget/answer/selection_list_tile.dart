import 'package:flutter/material.dart';

class SelectionListTile extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isSelected;

  const SelectionListTile({
    Key? key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isSelected ? Theme.of(context).primaryColor : null,
                  fontWeight: isSelected ? FontWeight.w600 : null,
                ),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check,
                  size: 32,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                )
              : Container(
                  width: 32,
                  height: 32,
                ),
          onTap: onTap,
        ),
        const Divider(
          color: Colors.grey,
          height: 0,
        ),
      ],
    );
  }
}
