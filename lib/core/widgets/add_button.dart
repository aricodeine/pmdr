import 'package:flutter/material.dart';
import 'package:pmdr/core/constants.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: size.width,
        child: ElevatedButton(
            onPressed: widget.onTap,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Add Task',
                    style: kButtonTextStyle,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
