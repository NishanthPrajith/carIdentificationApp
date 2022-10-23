// ignore: file_names
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class InfoCard extends StatefulWidget {
  const InfoCard(
      {Key? key,
      required this.fullscreen,
      required this.maxHeight,
      required this.prediction,
      required this.info,
      required this.onValueChanged})
      : super(key: key);

  final bool fullscreen;
  final double maxHeight;
  final String prediction;
  final Future<QuerySnapshot<Map<String, dynamic>>> info;
  final void Function() onValueChanged;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  Color infoColor = const Color(0xff242424);

  String getString(s) {
    String p = s.split(",")[0];
    if (p.substring(2,3).contains(RegExp(r'[a-zA-Z]'))) {
      return p.substring(2);
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.info,
      builder: (context, snapshot) {
        Map<String, dynamic> information = snapshot.data?.docs[0].data() as Map<String, dynamic>;

        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: widget.fullscreen ? Color(0xfff0f0f0) : Colors.transparent),
            child: Column(
              children: [
                Expanded(
                  flex: widget.fullscreen ? 1 : 2,
                  child: GestureDetector(
                      onTap: () => {
                            widget.fullscreen ? widget.onValueChanged() : null,
                          },
                      onVerticalDragUpdate: (details) => {
                            if (details.globalPosition.dy < widget.maxHeight &&
                                widget.fullscreen)
                              {
                                widget.fullscreen ? widget.onValueChanged() : null,
                              }
                          },
                      child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              bottom: widget.fullscreen ? 0 : 10, top: 0),
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            width: 30,
                            height: 5,
                            decoration: BoxDecoration(
                              color: const Color(0xffA8A6A7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ))),
                ),
                Expanded(
                  flex: widget.fullscreen ? 12 : 8,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: const BoxDecoration(
                        color: Color(0xfff0f0f0),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: ListView(
                      physics: widget.fullscreen
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        !widget.fullscreen
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                      getString(widget.prediction),
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
                                            information['Logo'] as String
                                        ),
                                      )),
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(
                            information['Image'] as String
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
                                getString(widget.prediction),
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
                                      information['Logo'] as String),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
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
                            firstValue: information['Engine Location'] as String,
                            secondCategory: "Engine Type",
                            secondValue: information['Engine Type'] as String),
                        const SizedBox(
                          height: 15,
                        ),
                        InformationDetail(
                            firstCategory: "Engine Max Power",
                            firstValue: information['Engine Max Power'] as String,
                            secondCategory: "Drive",
                            secondValue: information['Drive'] as String),
                        const SizedBox(
                          height: 15,
                        ),
                        InformationDetail(
                            firstCategory: "Engine Fuel Type",
                            firstValue: information['Engine Fuel Type'] as String,
                            secondCategory: "Fuel Capacity",
                            secondValue: information['Fuel Capacity'] as String),
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
                                          information["Transmission Type"] as String,
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
        );
      }
    );
  }
}

class CarInfoSingleBox extends StatelessWidget {
  const CarInfoSingleBox({
    super.key,
    required this.category,
    required this.value,
  });

  final String category;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 125,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'sfPro',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              category,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'sfPro', color: Color(0xff242424), fontSize: 13),
            ),
          ],
        ));
  }
}

class InformationDetail extends StatelessWidget {
  const InformationDetail(
      {Key? key,
      required this.firstCategory,
      required this.firstValue,
      required this.secondCategory,
      required this.secondValue})
      : super(key: key);

  final String firstCategory;
  final String firstValue;
  final String secondCategory;
  final String secondValue;

  @override
  Widget build(BuildContext context) {
    return (Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          child: CarInfoSingleBox(category: firstCategory, value: firstValue)),
      const SizedBox(
        width: 15,
      ),
      Expanded(
          child: CarInfoSingleBox(category: secondCategory, value: secondValue))
    ]));
  }
}

// Not used anymore, could be deleted
// class Categories extends StatelessWidget {
//   const Categories({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Container(
//           width: MediaQuery.of(context).size.width - 40,
//           height: 1.5,
//           margin: const EdgeInsets.only(bottom: 20, top: 15),
//           color: const Color(0xffE1E1E1),
//         ),
//         Row(
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const <Widget>[
//                   Text(
//                     "Production",
//                     style: TextStyle(
//                       fontFamily: 'sfPro',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     "2018-2022",
//                     style: TextStyle(
//                       fontFamily: 'sfPro',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const <Widget>[
//                   Text(
//                     "Class",
//                     style: TextStyle(
//                       fontFamily: 'sfPro',
//                       fontSize: 16,
//                       fontWeight: FontWeight.w300,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Text(
//                     "Sportcars",
//                     style: TextStyle(
//                       fontFamily: 'sfPro',
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//         Container(
//             width: MediaQuery.of(context).size.width - 40,
//             height: 1.5,
//             margin: const EdgeInsets.only(top: 20, bottom: 40),
//             color: const Color(0xffE1E1E1)),
//       ],
//     );
//   }
// }
