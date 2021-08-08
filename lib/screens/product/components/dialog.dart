import 'package:flutter/material.dart';

class OrderDialog extends StatefulWidget {
  final String tag;
  final String title;
  final String description;
  final String actionButtonTitle;
  final Function actionButtonFunction;

  const OrderDialog({
     this.tag,
     this.title,
     this.description,
     this.actionButtonTitle,
     this.actionButtonFunction,
  });

  @override
  _OrderDialogState createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog>
    with SingleTickerProviderStateMixin {
    AnimationController _controller;
    Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    _slideAnimation = Tween(begin: Offset(0.0, 2.0), end: Offset(0.0, 0.0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: Colors.green),
              child: Image.asset(
                widget.tag,
                height: 80.0,
                width: 80.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
        content: Text(
          widget.description,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.green),
              child: TextButton(
                onPressed: () {
                  _controller.reverse();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'حسنا',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
//          TextButton(
//            onPressed: () {
//              widget.actionButtonFunction();
//            },
//            child: Text(
//              widget.actionButtonTitle,
//            ),
//          ),
        ],
      ),
    );
  }
}
