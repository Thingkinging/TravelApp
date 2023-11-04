import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String city;
  final List<dynamic> info;

  const DetailScreen({
    super.key,
    required this.city,
    required this.info,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isCheckedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.city),
      ),
      body: ListView.builder(
        itemCount: widget.info.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Switch(
                    value: isCheckedIn,
                    onChanged: (bool value) {
                      isCheckedIn = value;
                    },
                  ),
                  Text(
                    "체크인",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            );
          }
          return ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.info[index - 1]["name"] ?? "",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message: widget.info[index - 1]["cost"] ?? "",
                  child: Icon(Icons.attach_money),
                ),
              ],
            ),
            subtitle: Text(
                "${widget.info[index - 1]["description"] ?? ""}\n위치: ${widget.info[index - 1]["address"] ?? ""}"),
            trailing: SizedBox(
              width: 100.0,
              height: 100.0,
              child: Image.asset(
                "assets/images/${widget.info[index - 1]["image"] ?? "placeholder.png"}",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
