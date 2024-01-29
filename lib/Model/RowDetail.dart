import 'package:flutter/material.dart';

class RowDetail extends StatefulWidget {
  RowDetail({
    super.key,
    required this.title,
    required this.body,
    required this.iconrow,
    Widget? child
  }) : this.child = child ?? Icon(Icons.arrow_forward_ios, color: Colors.black);

  String title;
  String body;
  IconData iconrow;
  Widget child;

  @override
  State<RowDetail> createState() => _RowDetailState();
}

class _RowDetailState extends State<RowDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 70,
          color: Colors.grey[50],
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.lightBlue[200], //Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5), //Colors.red,
                width: 70,
                height: 70,
                child: Icon(
                    widget.iconrow,
                    color: Colors.white
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(widget.body,
                        style: const TextStyle(
                          fontSize: 10,
                            color: Colors.grey
                        )
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: widget.child,
                // Icon(
                //     Icons.arrow_forward_ios,
                //     color: Colors.black
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
