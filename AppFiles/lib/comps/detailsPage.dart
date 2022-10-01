import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'infoCard.dart';
import 'carListItem.dart';

class DetailsPage extends StatelessWidget {
  final String info;
  final CarListItem carInfo;

  const DetailsPage({super.key, required this.info, required this.carInfo});

  final Color infoColor = const Color(0xff242424);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xfff0f0f0)),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.black,
                            size: 32,
                          ),
                        )),
                    const Expanded(
                        flex: 6,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Search Result",
                            style: TextStyle(
                                fontFamily: 'sfPro',
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        )),
                    const Expanded(
                        flex: 2,
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Color(0xfff0f0f0),
                        ))
                  ],
                )),
            Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color(0xfff0f0f0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: <Widget>[
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        "https://www.pngpix.com/wp-content/uploads/2016/06/PNGPIX-COM-Red-Porsche-911-Carrera-Car-PNG-Image-500x255.png",
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(
                            info,
                            style: const TextStyle(
                              fontFamily: 'sfPro',
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.maxFinite,
                              child: Image.network(
                                  scale: 0.5,
                                  "https://www.autocarbrands.com/wp-content/uploads/2014/04/porsche.png"),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    const Categories(),
                    const Text(
                      "placeholder text",
                      style: TextStyle(
                        fontFamily: 'sfPro',
                        color: Color(0xff242424),
                        fontSize: 21,
                        letterSpacing: 0.2,
                        height: 1.75,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Row(
                      children: const [
                        Icon(
                          color: Color(0xffA0A0A0),
                          Icons.info_outline,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Information",
                          style: TextStyle(
                              fontFamily: 'sfPro',
                              color: Color(0xffA0A0A0),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.6),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InformationDetail(
                        firstCategory: "Engine Location",
                        firstValue: carInfo.engineLocation,
                        secondCategory: "Engine Type",
                        secondValue: carInfo.engineType),
                    const SizedBox(
                      height: 15,
                    ),
                    InformationDetail(
                        firstCategory: "Engine Max Power",
                        firstValue: carInfo.engineMaxPower,
                        secondCategory: "Drive",
                        secondValue: carInfo.drive),
                    const SizedBox(
                      height: 15,
                    ),
                    InformationDetail(
                        firstCategory: "Engine Fuel Type",
                        firstValue: carInfo.engineFuelType,
                        secondCategory: "Fuel Capacity",
                        secondValue: carInfo.fuelCapacity),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                                height: 130,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: infoColor,
                                ),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      carInfo.transmissionType,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontFamily: 'sfPro',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    const Text(
                                      "Transmission Type",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'sfPro',
                                          color: Color(0xffA0A0A0),
                                          fontSize: 13),
                                    ),
                                  ],
                                )),
                          ),
                        ]),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
