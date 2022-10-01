import 'package:flutter/material.dart';
import 'detailsPage.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({
    super.key,
    required this.make,
    required this.model,
    required this.engineLocation,
    required this.engineType,
    required this.engineMaxPower,
    required this.drive,
    required this.engineFuelType,
    required this.fuelCapacity,
    required this.transmissionType,
  });

  final String make;
  final String model;
  final String engineLocation;
  final String engineType;
  final String engineMaxPower;
  final String drive;
  final String engineFuelType;
  final String fuelCapacity;
  final String transmissionType;

  @override
  Widget build(BuildContext context) {
    final carName = '$make - $model';
    final carListItem = CarListItem(
        make: make,
        model: model,
        engineLocation: engineLocation,
        engineType: engineType,
        engineMaxPower: engineMaxPower,
        drive: drive,
        engineFuelType: engineFuelType,
        fuelCapacity: fuelCapacity,
        transmissionType: transmissionType);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
                    info: carName,
                    carInfo: carListItem,
                  )),
        );
      },
      child: Container(
          height: 75,
          decoration: const BoxDecoration(
              color: Color(0xffe5e5e5),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 23),
          padding: const EdgeInsets.fromLTRB(0, 8, 15, 0),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "https://www.pngpix.com/wp-content/uploads/2016/06/PNGPIX-COM-McLaren-650S-Sprint-White-Car-PNG-Image-500x190.png",
                    fit: BoxFit.fitHeight,
                  )),
              Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width,
                  child: Text(carName,
                      style: const TextStyle(
                        fontFamily: 'sfPro',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )))
            ],
          )),
    );
  }
}
