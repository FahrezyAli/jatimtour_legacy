import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart' as intl;
import 'package:jatimtour/constants.dart';
import 'package:jatimtour/widgets/universal/buttons/circle_button.dart';
import 'package:jatimtour/widgets/universal/cards/calendar_card.dart';

class CalendarViewMobile extends StatelessWidget {
  const CalendarViewMobile({super.key});

  List<String> _getMonth() {
    final currentMonths = DateTime.now().month;
    final remainingMonths = months.keys.toList().sublist(currentMonths - 1);
    return remainingMonths.map((month) => months[month]!).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          'assets/images/leading.png',
          repeat: ImageRepeat.repeatX,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Stack(
            children: [
              const Text(
                "Libatkan Dirimu\nDalam Kemeriahan\nBulan Ini!",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Positioned(
                bottom: 4.0,
                left: 140.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Image.asset('assets/images/eol_cal.png'),
                ),
              ),
              Positioned(
                bottom: 10.0,
                left: 190.0,
                child: CircleButton(
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
                    Modular.to.pushNamed(
                      '$eventListRoute?date=${dateFormat.format(date!)}',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Positioned.fill(
            child: Image.asset(
              'assets/images/border1.png',
              repeat: ImageRepeat.repeatX,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: _getMonth().length,
          itemBuilder: (context, index) {
            return CalendarCard(
              month: _getMonth()[index],
              image: Image.asset(
                'assets/images/${_getMonth()[index].toLowerCase()}.png',
                errorBuilder: (context, error, stackTrace) => Stack(
                  children: [
                    Image.asset(
                      'assets/images/placeholder_months.png',
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
