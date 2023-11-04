import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_korea_app/components/list_item.dart';

class DetailScreen extends StatefulWidget {
  final String city;
  final List<dynamic> info;
  final bool isCheckIn;
  final Function(bool) onCheckInChanged;

  const DetailScreen({
    super.key,
    required this.city,
    required this.info,
    required this.isCheckIn,
    required this.onCheckInChanged,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference rootRef = FirebaseDatabase.instance.ref();

  int checkInCount = 0;
  bool isCheckedIn = false;

  void getCheckInCount() async {
    if (!mounted) return;

    final snapshot = await rootRef.get();

    if (snapshot.exists) {
      final data = snapshot.value as Map;
      setState(() {
        checkInCount = data[widget.city] ?? 0;
      });
    }
  }

  void incrementCheckInCount() async {
    if (!mounted) return;
    rootRef.child(widget.city).set(ServerValue.increment(1));
  }

  void decrementCheckInCount() async {
    if (!mounted) return;
    rootRef.child(widget.city).set(ServerValue.increment(-1));
  }

  @override
  void initState() {
    super.initState();
    isCheckedIn = widget.isCheckIn;
    getCheckInCount();
    rootRef.onValue.listen((DatabaseEvent event) {
      if (!mounted) return;
      final data = event.snapshot.value as Map;
      setState(() {
        checkInCount = data[widget.city] ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.city,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.info.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                children: [
                  Text(
                    "현재 체크인한 사람: $checkInCount명",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Switch(
                        value: isCheckedIn,
                        onChanged: (bool value) {
                          setState(() {
                            isCheckedIn = value;
                          });
                          widget.onCheckInChanged(value);
                          if (value) {
                            incrementCheckInCount();
                          } else {
                            decrementCheckInCount();
                          }
                        },
                      ),
                      Text(
                        "체크인",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return ListItem(
            data: widget.info[index - 1],
          );
        },
      ),
    );
  }
}
