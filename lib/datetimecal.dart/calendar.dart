import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _selectedDay.subtract(Duration(days: 27)): ['Event A1'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _selectedDay.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _selectedDay.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _selectedDay: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _selectedDay.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event C8',
        'Event D8'
      ],
      _selectedDay.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _selectedDay.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _selectedDay.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _selectedDay.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _selectedDay.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendarWithBuilders(),
          // const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return Container(
      color: Colors.black,
      child: TableCalendar(
        calendarController: _calendarController,
        events: _events,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          todayColor: Colors.amber,
          markersPositionBottom: -6,
          todayStyle: TextStyle(color: Colors.white),
          weekdayStyle: TextStyle(color: Colors.white),
          weekendStyle: TextStyle(color: Colors.white),
          outsideStyle: TextStyle(color: Colors.grey.shade900),
          unavailableStyle: TextStyle(color: Colors.grey.shade900),
          outsideWeekendStyle: TextStyle(color: Colors.grey.shade900),
        ),
        headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
          formatButtonDecoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onDaySelected: _onDaySelected,
        onVisibleDaysChanged: _onVisibleDaysChanged,
        onCalendarCreated: _onCalendarCreated,
      ),
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return Container(
      color: Colors.black,
      child: TableCalendar(
        // locale: 'pl_PL',
        headerVisible: true,

        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarController: _calendarController,
        events: _events,
        initialCalendarFormat: CalendarFormat.month,
        formatAnimation: FormatAnimation.slide,
        availableGestures: AvailableGestures.all,
        availableCalendarFormats: const {
          CalendarFormat.month: '',
          CalendarFormat.week: '',
        },
        calendarStyle: CalendarStyle(
          contentPadding: EdgeInsets.only(bottom: 10),
          markersPositionBottom: 0,
          outsideDaysVisible: false,
          todayColor: Colors.white,
          highlightToday: true,
          markersColor: Colors.amberAccent,
          todayStyle: TextStyle().copyWith(color: Colors.white),
          weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
          holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
        ),

        // daysOfWeekStyle: DaysOfWeekStyle(
        //   weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
        // ),
        headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
            decoration: BoxDecoration(color: Colors.white)),

        builders: CalendarBuilders(
          dayBuilder: (context, date, events) {
            return Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "${date.day < 10 ? 0 : ""}${date.day}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          selectedDayBuilder: (context, date, _) {
            return FadeTransition(
              opacity:
                  Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                margin: EdgeInsets.all(15),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          },
          todayDayBuilder: (context, date, _) {
            return Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 2),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          },
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];

            if (events.isNotEmpty) {
              children.add(
                Positioned(
                  right: 1,
                  bottom: -2,
                  child: _buildEventsMarker(date, events),
                ),
              );
            }

            if (holidays.isNotEmpty) {
              children.add(
                Positioned(
                  right: -2,
                  top: -2,
                  child: _buildHolidaysMarker(),
                ),
              );
            }
            return children;
          },
        ),
        // onDaySelected: (date, events) {
        //   _onDaySelected(date, events);
        //   _animationController.forward(from: 0.0);
        // },
        // onVisibleDaysChanged: _onVisibleDaysChanged,
        // onCalendarCreated: _onCalendarCreated,
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Center(
        child: Row(
          children: [
            Container(
              height: 8,
              width: 8,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 8,
              width: 8,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 8,
              width: 8,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 8,
              width: 8,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        // Text(
        //   '.',
        //   style: TextStyle().copyWith(
        //     color: Colors.white,
        //     fontSize: 12.0,
        //   ),
        // ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('Month'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            RaisedButton(
              child: Text('2 weeks'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Week'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map(
            (event) => Container(
              height: 100,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 2.0),
              child: Container(
               
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      
                      color: Colors.blue,
                      width: 6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                       margin: EdgeInsets.all(8),
                      child: Text(
                        event.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

