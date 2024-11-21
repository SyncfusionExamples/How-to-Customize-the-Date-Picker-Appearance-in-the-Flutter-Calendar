import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String? _headerText;
  DateTime? _selectedDate;

  final CalendarController _calendarController = CalendarController();
  final DateRangePickerController _datePickerController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: TextButton(child: Text(
                    _headerText ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: (){
                    _datePickerController.displayDate = _selectedDate;
                    showDateRangePickerDialog(context);
                  },),
                ),)
              ],
            ),
            Expanded( child: SfCalendar(
              controller: _calendarController,
              headerHeight: 0,
              view: CalendarView.day,
              showDatePickerButton: true,
              todayHighlightColor: const Color.fromRGBO(35, 188, 1, 1),
              backgroundColor: Colors.white,
              selectionDecoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(35, 188, 1, 1), width: 2),
              ),
              onViewChanged: (viewChangedDetails) => {
                if(viewChangedDetails.visibleDates.isNotEmpty){
                  _headerText = DateFormat('MMMM yyyy')
                  .format(viewChangedDetails.visibleDates[0])
                },
                SchedulerBinding.instance.addPostFrameCallback(
                  (duration){
                    setState(() {
                      
                    });
                  },
                ),
              },
            ),
            ),
          ],
        ),
      ),
    );
  }

void showDateRangePickerDialog(BuildContext context) {
  showDialog(context: context, builder: (context){
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: SfDateRangePickerTheme(data: const SfDateRangePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: Colors.white,
          selectionColor: Color.fromRGBO(35, 188, 1, 1),
          todayHighlightColor: Color.fromRGBO(35, 188, 1, 1),
          todayCellTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          todayTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ), child: SfDateRangePicker(
          controller: _datePickerController,
          onSelectionChanged: (dateRangePickerSelectionChangedArgs) => {
            _selectedDate = dateRangePickerSelectionChangedArgs.value,
            _calendarController.displayDate = _selectedDate,
            Navigator.pop(context)
          },
        )),
      ),
    );
  });
}
}
