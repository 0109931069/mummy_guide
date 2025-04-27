import 'package:mummy_guide/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:mummy_guide/locale/app_locale.dart';
import 'package:mummy_guide/main.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:mummy_guide/providers/location_viewer_provider.dart';
import 'package:provider/provider.dart';

class LocationViewerScreen extends StatelessWidget {
  const LocationViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationViewerProvider = Provider.of<LocationViewerProvider>(
      context,
    );

    return Directionality(
      textDirection: localization.currentLocale.localeIdentifier == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Globals.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppLocale.location_viewer_label.getString(
              context,
            ),
            style: const TextStyle(color:Globals.btncolor),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              padding: const EdgeInsets.all(
                10,
              ),
              child: OSMFlutter(
                controller: locationViewerProvider.mapController,
                osmOption: OSMOption(
                  // userTrackingOption: UserTrackingOption(
                  //   enableTracking: true,
                  //   unFollowUser: false,
                  // ),
                  zoomOption: const ZoomOption(
                    initZoom: 12,
                    minZoomLevel: 3,
                    maxZoomLevel: 19,
                    stepZoom: 1.0,
                  ),
                  userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.location_pin,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.double_arrow,
                        color: Colors.blue,
                        size: 60,
                      ),
                    ),
                  ),
                  roadConfiguration: const RoadOption(
                    roadColor: Color.fromARGB(255, 169, 103, 142),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: const ButtonStyle(
                    backgroundColor:WidgetStatePropertyAll(Globals.btncolor)
                  ),
                  onPressed: () async {
                    await locationViewerProvider.setCurrentLocation();

                    Navigator.of(context).pop();
                  },
                  label: Text(
                    AppLocale.confirm_location_label.getString(
                      context,
                    ),
                    style: const TextStyle(color: Globals.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
