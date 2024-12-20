import 'package:flutter/material.dart';

class OfferedByButtons extends StatefulWidget {
  final Function(String) onOfferTypeSelected;
  const OfferedByButtons({super.key, required this.onOfferTypeSelected});

  @override
  State<OfferedByButtons> createState() => _OfferedByButtonsState();
}

class _OfferedByButtonsState extends State<OfferedByButtons> {
  bool isPressed = true;
  bool isPressed1 = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              if (isPressed == true) {
                return;
              } else {
                isPressed = !isPressed;
                isPressed1 = !isPressed1;
                setState(() {});
                widget.onOfferTypeSelected("SELL");
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: isPressed ? Colors.orange[200]! : Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
            ),
            child: SizedBox(
              child: Center(
                child: Text(
                  'Sale',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      color: isPressed ? Colors.black : Colors.grey[500]),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              if (isPressed1 == true) {
                return;
              } else {
                isPressed = !isPressed;
                isPressed1 = !isPressed1;
                setState(() {});
                widget.onOfferTypeSelected("RENT");
              }
            },
            style: TextButton.styleFrom(
                backgroundColor:
                    isPressed1 ? Colors.orange[200]! : Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                )),
            child: SizedBox(
              child: Center(
                child: Text(
                  'Rent',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      color: isPressed1 ? Colors.black : Colors.grey[500]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
