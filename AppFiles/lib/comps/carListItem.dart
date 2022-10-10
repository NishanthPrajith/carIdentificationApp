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
    required this.image,
    required this.logo,
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
  final String image;
  final String logo;

  @override
  Widget build(BuildContext context) {
    final carListItem = CarListItem(
      make: make,
      model: model,
      engineLocation: engineLocation,
      engineType: engineType,
      engineMaxPower: engineMaxPower,
      drive: drive,
      engineFuelType: engineFuelType,
      fuelCapacity: fuelCapacity,
      transmissionType: transmissionType,
      image: image,
      logo: logo,
    );

    return GestureDetector(
      onTap: () {
        print('tapped!!!!');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(
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
                  padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    image,
                    fit: BoxFit.fitHeight,
                  )),
              Container(
                alignment: Alignment.topRight,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        make,
                        style: const TextStyle(
                          color: Color(0xFF424242),
                          fontFamily: 'sfPro',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      model,
                      style: const TextStyle(
                        fontFamily: 'sfPro',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
