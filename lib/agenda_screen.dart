import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  DateTime _selectedDate = DateTime.now();
  int _currentDay = DateTime.now().day;
  int _currentMonth = DateTime.now().month;
  int _currentYear = DateTime.now().year;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário'),
      ),
      body: Column(
        children: [
          // Cabeçalho com mês e ano
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      _currentMonth--;
                      if (_currentMonth == 0) {
                        _currentMonth = 12;
                        _currentYear--;
                      }
                    });
                  },
                ),
                Text(
                  '${DateFormat('MMMM').format(DateTime(_currentYear, _currentMonth))} - $_currentYear',
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    setState(() {
                      _currentMonth++;
                      if (_currentMonth == 13) {
                        _currentMonth = 1;
                        _currentYear++;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          // Grid do Calendário
          Expanded(
            child: CalendarGridView(
              selectedDate: _selectedDate,
              currentDay: _currentDay,
              currentMonth: _currentMonth,
              currentYear: _currentYear,
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarGridView extends StatelessWidget {
  final DateTime selectedDate;
  final int currentDay;
  final int currentMonth;
  final int currentYear;

  const CalendarGridView({
    Key? key,
    required this.selectedDate,
    required this.currentDay,
    required this.currentMonth,
    required this.currentYear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(currentYear, currentMonth);
    final firstDayOfMonthWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    return GridView.count(
      crossAxisCount: 7,
      children: List.generate(42, (index) {
        final day = index - firstDayOfMonthWeekday + 1;
        if (day > 0 && day <= daysInMonth) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: selectedDate == DateTime(currentYear, currentMonth, day) ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
