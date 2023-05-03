
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/constant/colurs.dart';
import 'package:pharma_go_v2_app/constant/fonts.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: screenSize.height * .1,
          width: screenSize.width,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(40)),
            gradient: vimo(),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(.4),
                blurRadius: 5,
                spreadRadius: .1,
              ),
            ],
          ),
          //* Main column
          child: Column(
            children: [
              //* first row
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: cardText('City Pharmacy', vertical: 6.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IonIcons.location,
                          color: Color(0xFFbc4e9c),
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
              //* second Row
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:
                                      cardText('Availability', vertical: 5.0),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: cardText('All available'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Bootstrap.menu_down,
                                color: Color(0xFFbc4e9c),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: cardText('Total:- 1,250/='),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color(0xFF6441A5),
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Bootstrap.cart_plus_fill,
                color: Color(0xFFbc4e9c),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
