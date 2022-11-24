import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/mapview.dart';
import 'package:tapit/controller/LocationController.dart';

import '../images.dart';
import '../widgets/Map_Screen/cutomlayer.dart';
import '../widgets/Map_Screen/gesture.dart';
import '../widgets/Map_Screen/search.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SearchExample? _searchExample;
  final LocationController controller = Get.put(LocationController());

  Position? _currentAddress;
  CustomRasterLayersExample? _customRasterLayersExample;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocaiton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: AlignmentDirectional.bottomCenter,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                  height: constraints.maxHeight / 1.2,
                  child: HereMap(
                    onMapCreated: _onMapCreated,
                  ));
            },
          ),
          Column(
            children: [
              // button('Search', _searchButtonClicked),
              // button('Enable', _enableButtonClicked),
              // button('Disable', _disableButtonClicked),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: .1,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return bottomSheet();
            },
          )
        ],
      ),
    );
  }

  Widget emergency_button(String image, String Name) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)]),
      child: Container(
        height: 106.h,
        width: 97.w,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 70.h,
            ),
            Text(
              Name,
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 287.h,
      width: double.infinity,
      // color: Colors.black,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.sp), topRight: Radius.circular(50.sp))),
      child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  logoUnderheadDark,
                  height: 52.48.h,
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                emergency_button(ambulanceLogo, "Ambulance"),
                emergency_button(fireLogo, "Fire"),
                emergency_button(policeLogo, "Police"),
              ],
              // emergency_button(ambulanceLogo,"Ambulance");
            ),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Theme.of(context).primaryColor;
                })),
                onPressed: () {},
                child: Text("Other Emergency"))
          ],
        ),
      ),
    );
  }

  // GeoCoordinates? currentPostion;

  // void _getUserLocation() async {
  //   var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  //   setState(() {
  //     currentPostion = GeoCoordinates(position.latitude, position.longitude);
  //   });
  // }
  // Future<Position> getLocaiton() async{
  //   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   controller.getLocation(position);
  //   return position;
  // }

  void _onMapCreated(HereMapController hereMapController) {
    // Position location = getLocaiton() as Position;

    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error == null) {
        _searchExample = SearchExample(_showDialog, hereMapController);
        GesturesExample(_showDialog, hereMapController);

        _addLocationIndicator(GeoCoordinates(controller.langitude.value, controller.langitude.value),
            LocationIndicatorIndicatorStyle.navigation, hereMapController);
        hereMapController.mapScene.enableFeatures({MapFeatures.trafficFlow: MapFeatureModes.trafficFlowWithFreeFlow});
        hereMapController.mapScene.enableFeatures({MapFeatures.trafficIncidents: MapFeatureModes.defaultMode});
        // hereMapController.mapScene.enableFeatures({MapFeatures.safetyCameras: MapFeatureModes.defaultMode});
        // hereMapController.mapScene.enableFeatures({MapFeatures.vehicleRestrictions: MapFeatureModes.defaultMode});
        // hereMapController.mapScene.enableFeatures({MapFeatures.landmarks: MapFeatureModes.landmarksTextured});
        hereMapController.mapScene.enableFeatures({MapFeatures.extrudedBuildings: MapFeatureModes.defaultMode});
        hereMapController.mapScene.enableFeatures({MapFeatures.buildingFootprints: MapFeatureModes.defaultMode});

        _customRasterLayersExample = CustomRasterLayersExample(hereMapController);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }

  void _addLocationIndicator(GeoCoordinates geoCoordinates, LocationIndicatorIndicatorStyle indicatorStyle,
      HereMapController hereMapController) {
    LocationIndicator locationIndicator = LocationIndicator();
    locationIndicator.locationIndicatorStyle = indicatorStyle;

    // A LocationIndicator is intended to mark the user's current location,
    // including a bearing direction.
    // For testing purposes, we create a Location object. Usually, you may want to get this from
    // a GPS sensor instead.
    Location location = Location.withCoordinates(geoCoordinates);
    location.time = DateTime.now();
    location.bearingInDegrees = 90;

    locationIndicator.updateLocation(location);

    // A LocationIndicator listens to the lifecycle of the map view,
    // therefore, for example, it will get destroyed when the map view gets destroyed.
    hereMapController.addLifecycleListener(locationIndicator);
  }

  void _searchButtonClicked() {
    _searchExample?.searchButtonClicked();
  }

  void _enableButtonClicked() {
    _customRasterLayersExample?.enableButtonClicked();
  }

  void _disableButtonClicked() {
    _customRasterLayersExample?.disableButtonClicked();
  }

  @override
  void dispose() {
    // Free HERE SDK resources before the application shuts down.
    SDKNativeEngine.sharedInstance?.dispose();
    SdkContext.release();
    super.dispose();
  }

  Future<void> _showDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Align button(String buttonLabel, Function callbackFunction) {
    return Align(
      alignment: Alignment.topCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () => callbackFunction(),
        child: Text(buttonLabel, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
