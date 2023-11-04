import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListItem extends StatelessWidget {
  final dynamic data;
  const ListItem({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = <Marker>{
      Marker(
        markerId: MarkerId(
          data["name"] ?? "",
        ),
        position: LatLng(
          data["lat"] ?? 37.495361,
          data["logt"] ?? 127.033079,
        ),
        infoWindow: InfoWindow(
          title: data["name"] ?? "",
          snippet: data["address"] ?? "",
        ),
      ),
    };
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data["name"] ?? "",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: data["cost"] ?? "",
                child: Icon(
                  Icons.attach_money,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 140.0,
                child: Text(
                    "${data["description"] ?? ""}\n위치: ${data["address"] ?? ""}"),
              ),
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.asset(
                  "assets/images/${data["image"] ?? "placeholder.png"}",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          SizedBox(
            height: 200.0,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  data["lat"] ?? 37.495361,
                  data["logt"] ?? 127.033079,
                ),
                zoom: 15.0,
              ),
              markers: markers,
              compassEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              buildingsEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (controller) {
                markers.forEach((marker) {
                  controller.showMarkerInfoWindow(marker.markerId);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
