
import 'package:flutter/material.dart';

import 'comps/detailsPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String _searchQuery = "";

  final fieldText = TextEditingController();
  
  void clearText() {
    fieldText.clear();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox (
            height: 60,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: const Color(0xffC5C5C5),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    onChanged: (text) {
                      setState(() {
                        _searchQuery = text;
                      });
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration.collapsed(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        fontFamily: 'sfPro',
                        decoration: TextDecoration.none,
                        color: Color(0xff464646),
                      ),
                    ),
                    controller: fieldText,
                  ),
                ),
                if (_searchQuery != "")
                  GestureDetector(
                    onTap: () {
                      clearText();
                      setState(() {
                        _searchQuery = "";
                      });
                    },
                    child: const Icon(
                      Icons.close
                    ),
                  ),
              ],
            ),
          ),
          const Expanded(
            flex: 2,
            child: SizedBox (
              height:0,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: const Text(
                "Search Results..",
                style: TextStyle(
                  fontFamily: 'sfPro',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                )
              )
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox (
              height:0,
            ),
          ),
          Expanded(
            flex: 20,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context,int index){
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailsPage(info: {"hello": "1", "world": 2})),
                    );
                  },
                  child: Container(
                    height: 75,
                    decoration: const BoxDecoration(
                      color: Color(0xffEAEAEA),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
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
                          )
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          child: const Text(
                            "McLaren 650S Sprint",
                            style: TextStyle(
                              fontFamily: 'sfPro',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )
                          )
                        )
                      ],
                    )
                  ),
                );
              }
            )
          ),
          const Expanded(
            flex: 1,
            child: SizedBox (
              height:0,
            ),
          ),
        ],
      ),
    );
  }
}

