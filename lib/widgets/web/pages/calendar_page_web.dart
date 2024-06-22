import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;

import '../../../constants.dart';
import '../../../services/image_services.dart';
import '../../universal/buttons/circle_button.dart';
import '../cards/calendar_card_web.dart';
import 'web_scaffold.dart';

class CalendarPageWeb extends StatelessWidget {
  const CalendarPageWeb({super.key});

  List<String> _getMonth() {
    final currentMonths = DateTime.now().month;
    final remainingMonths = months.keys.toList().sublist(currentMonths - 1);
    return remainingMonths.map((month) => months[month]!).toList();
  }

  @override
  Widget build(BuildContext context) {
    return WebScaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Row(
              children: [
                const Text(
                  "Libatkan Dirimu Dalam Kemeriahan Bulan Ini!",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child:
                      Image(image: getLocalImage('assets/images/eol_cal.png')),
                ),
                CircleButton(
                  color: kPurpleColor,
                  text: const Text(
                    "CeK Tanggal",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    final dateFormat = intl.DateFormat('yyyy-MM-dd');
                    if (date != null) {
                      Modular.to.pushNamed(
                        '$eventListRoute?date=${dateFormat.format(date)}',
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image(
              image: getLocalImage('assets/images/border1.png'),
              height: 20.0,
              repeat: ImageRepeat.repeatX,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: _getMonth().length,
            itemBuilder: (context, index) {
              return CalendarCardWeb(
                month: _getMonth()[index],
                image: Image(
                  image: getLocalImage(
                    'assets/images/${_getMonth()[index].toLowerCase()}.png',
                  ),
                  errorBuilder: (context, error, stackTrace) => Stack(
                    children: [
                      Image(
                        image: getLocalImage(
                          'assets/images/placeholder_months.png',
                        ),
                        color: _placeholderColor(index),
                      ),
                      const Positioned.fill(
                        child: Center(
                          child: Text(
                            "Belum Ada Event\nCek Lagi Lain\nWaktu!",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
        ],
      ),
    );
  }

  Color _placeholderColor(index) {
    final colors = [
      kPurpleColor,
      kPinkColor,
      kYellowColor,
      const Color(0xFF00BBF9),
      const Color(0xFF00F5D4),
    ];
    return colors[index % 5];
  }
}
