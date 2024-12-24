import 'package:flutter/material.dart';

class OfferedByButtons extends StatefulWidget {
  final Function(String) onOfferTypeSelected;
  bool isPressed;
  bool isPressed1;
  OfferedByButtons(
      {super.key,
      required this.onOfferTypeSelected,
      required this.isPressed,
      required this.isPressed1});

  @override
  State<OfferedByButtons> createState() => _OfferedByButtonsState();
}

class _OfferedByButtonsState extends State<OfferedByButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              if (widget.isPressed == true) {
                return;
              } else {
                widget.isPressed = !widget.isPressed;
                widget.isPressed1 = !widget.isPressed1;
                setState(() {});
                widget.onOfferTypeSelected("SELL");
              }
            },
            style: TextButton.styleFrom(
              backgroundColor:
                  widget.isPressed ? Colors.orange[200]! : Colors.white,
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
                      color:
                          widget.isPressed ? Colors.black : Colors.grey[500]),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              if (widget.isPressed1 == true) {
                return;
              } else {
                widget.isPressed = !widget.isPressed;
                widget.isPressed1 = !widget.isPressed1;
                setState(() {});
                widget.onOfferTypeSelected("RENT");
              }
            },
            style: TextButton.styleFrom(
                backgroundColor:
                    widget.isPressed1 ? Colors.orange[200]! : Colors.white,
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
                      color:
                          widget.isPressed1 ? Colors.black : Colors.grey[500]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
