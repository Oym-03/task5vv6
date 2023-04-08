import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class light extends StatelessWidget {
  const light({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => english(),
        '/second': (context) => arabic(),
      },
    );
  }
}

class english extends StatelessWidget {
  const english({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Column(
        children: <Widget>[
          Container(height: 40,),
          Row(children: [
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/second');
              },
              child: Text('Eng',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),),
            ),

            Container(width: 20,)
          ],),
          Container(height: 500,width: 400,
            child: CalendarWidget(),
          ),
        ],
      ),
    );
  }
}

class arabic extends StatelessWidget {
  const arabic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Container(height: 38,),
          Row(children: [
            Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text('عربي',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),)
            ),

            Container(width: 20,)
          ],),
          Container(height: 500,width: 400,
            child: CalendarAWidget(),
          ),
        ],
      ),
    );
  }
}

void main() {
  return runApp(light());
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override

  _CalendarWidgetState createState() => _CalendarWidgetState();
}

enum DayColor { normal, red, green }

Map<int, DayColor> _dayColor = {};

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _selectedDate = DateTime.now();

  List<String> _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  List<String> monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  get daysInMonth =>  DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2023),
      locale: Locale('ar', 'AE'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),

        Row(
          children: [
            Container(width: 10,),
            Text('not available',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            Icon( Icons.circle , color: Colors.red,size: 20,),
            Container(width: 10,),
            Text('availabe',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            Icon( Icons.circle , color: Colors.green,size: 20,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                });
              },
            ),

            Text(
              '${monthNames[_selectedDate.month-1]}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                });
              },
            ),
          ],
        ),
        SizedBox(
          height: 6.0,
        ),
        Row(
          children: List.generate(7, (index) {
            return Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    _dayNames[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: daysInMonth + _selectedDate.weekday ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final dayOfWeek = (index - _selectedDate.weekday + 1) % 7;
              final date = DateTime(_selectedDate.year, _selectedDate.month, index + 1 - _selectedDate.weekday);
              if (index < _selectedDate.weekday ) {
                return Container();
              }
              final isSelected = date == _selectedDate;
              final textColor = isSelected ? Colors.white : Theme.of(context).textTheme.bodyText1?.color;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                    _dayColor[date.day] = _dayColor.containsKey(date.day) ? DayColor.values[(_dayColor[date.day]!.index + 1) % DayColor.values.length] : DayColor.red;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: _dayColor[date.day] == DayColor.red ? Colors.red
                        : _dayColor[date.day] == DayColor.green ? Colors.green : null,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: isSelected ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                ),
              );
            },



          ),
        ),
      ],
    );
  }
}

class CalendarAWidget extends StatefulWidget {
  const CalendarAWidget({super.key});

  @override
  _CalendarAWidgetState createState() => _CalendarAWidgetState();
}

class _CalendarAWidgetState extends State<CalendarAWidget> {
  DateTime _selectedDate = DateTime.now();

  List<String> _AdayNames = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
  List<String> _AmonthNames = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];

  int get AdaysInMonth => DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2023),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50.0,
        ),
        Row(
          children: [
            Container(width: 10,),
            Text('غير متوفر',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            Icon( Icons.circle , color: Colors.red,size: 20,),
            Container(width: 10,),
            Text('متوفر',style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
            Icon( Icons.circle , color: Colors.green,size: 20,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
                });
              },
            ),

            Text(
              '${_AmonthNames[_selectedDate.month-1]}',
              // '${monthNames[_selectedDate.month-1]}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
                });
              },
            ),
          ],
        ),

        Row(
          children: List.generate(7, (index) {
            return Expanded(
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    _AdayNames[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: AdaysInMonth + _selectedDate.weekday ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              final dayOfWeek = (index - _selectedDate.weekday+1) % 7;
              final dayOfMonth = index - _selectedDate.weekday + 1;
              final isToday = DateTime.now().day == dayOfMonth && DateTime.now().month == _selectedDate.month && DateTime.now().year == _selectedDate.year;
              DayColor dayColor = _dayColor[dayOfMonth] ?? DayColor.normal;
              return InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(

                    color: dayColor == DayColor.normal ? Colors.transparent : dayColor == DayColor.red ? Colors.red : Colors.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${dayOfMonth <= 0 || dayOfMonth > AdaysInMonth ? '' : dayOfMonth}',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.black : dayColor == DayColor.normal ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
