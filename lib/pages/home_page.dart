//fix not to update when clicking the same date more times
import 'package:flutter/material.dart';
import 'package:reminderapp/constants.dart';
import 'package:reminderapp/databaseHelper.dart';
import 'package:reminderapp/services/date_codes_helper.dart';
import 'package:reminderapp/models/event.dart';
import 'package:reminderapp/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  static String daySelected = "${DateTime.now().month}_${DateTime.now().day}"; //by default is the current day -> MM_DD format
  final String today = "${DateTime.now().month}_${DateTime.now().day}"; //by default is the current day
  final bool animateToSelectedDay;
  final bool animateToToday;
  static int lastMonth = DateTime.now().month;
  
  HomePage({super.key, required this.animateToSelectedDay, required this.animateToToday});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController monthScrollController = PageController(initialPage: DateTime.now().month - 1);
  TextEditingController eventDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.animateToSelectedDay)
    {
      monthScrollController = PageController(initialPage: HomePage.lastMonth);
    }

    if (widget.animateToToday)
    {
      monthScrollController = PageController(initialPage: DateTime.now().month - 1);
      changeDateToToday();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomHeader(),
      body: getBody(),
      drawer: getDrawer(context),
      floatingActionButton: getFloatingActionButton()
    );
  }

  PreferredSizeWidget getCustomHeader() {
    DateTime now = DateTime.now();

    return AppBar(
      title: const Text("Reminder"),
      backgroundColor: ReminderAppPalette.mainColor,
      actions: [
        Stack(
          alignment: Alignment.center, 
          children: [
            IconButton( //changes focus to today
              onPressed: () {
                focusToToday();
              }, 
              splashRadius: 23,
              icon: const Icon(Icons.calendar_today_rounded, size: 28,),
            ),
            Padding(padding: const EdgeInsets.only(top: 5), child:Text(now.day.toString())) 
          ],
        ),
      ],
    );
  }

  Widget getBody() {
    return FutureBuilder<dynamic>(
      future: DatabaseHelper.instance.getAllEventsOfOneDay(HomePage.daySelected),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData)
        {
          List<Event> eventsOfSelectedDay = snapshot.data!;

          return Center(
            child: Column(
              children: [
                Padding( // calendar itself
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox( 
                    height: 290,
                    child: PageView( // Months
                      controller: monthScrollController,
                      onPageChanged: (pageIndex) {
                        HomePage.lastMonth = pageIndex;
                      },
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        for(int i = 1; i < 13; i++) ...[
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(monthIntToString[i]!, style: const TextStyle(fontSize: 24),),
                                ),
                                Expanded(
                                  child: GridView(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                                    children: [
                                      for (int j = 1; j < monthPatternIntToString[i]! + 1; j++) ...[ // One more than the month's max
                                        Container( // Each day
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          margin: const EdgeInsets.all(5.0),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: 
                                                "${i}_$j" == widget.today
                                                ? 
                                                const MaterialStatePropertyAll(ReminderAppPalette.todaysColor)
                                                :
                                                  i %2 == 0
                                                  ?
                                                  const MaterialStatePropertyAll(ReminderAppPalette.evenMonthColor)
                                                  :
                                                  const MaterialStatePropertyAll(ReminderAppPalette.oddMonthColor)
                                            ),
                                            child: Align(
                                                alignment: Alignment.topLeft, 
                                                child: Text(
                                                  j.toString(),  
                                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                                ),
                                              ), 
                                              onPressed: () {
                                                changeDate(i, j);
                                              },
                                            ), 
                                        )
                                      ],
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ), 
                        ],  
                      ],
                    ),
                  ),
                ),
                Column( //listing day's event
                  children: [
                    if(eventsOfSelectedDay.isEmpty)...[
                      const Padding(
                        padding: EdgeInsets.only(top: 100),
                      ),
                      if(HomePage.daySelected == widget.today)...[
                        const Text("No events today")
                      ]
                      else...[
                        Text("No events on ${codeToDate(HomePage.daySelected)}", )
                      ],
                    ]
                    else ...[
                      if(HomePage.daySelected == widget.today)...[
                        const Text("Events today:")
                      ]
                      else...[
                        Text("Events on ${codeToDate(HomePage.daySelected)}:", )   
                      ],
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 447, //all height - previous height
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: eventsOfSelectedDay.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Text("${index + 1}.", ),
                              title: Text(eventsOfSelectedDay[index].eventDesc, ),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () async {
                                  await DatabaseHelper.instance.deleteEventById(eventsOfSelectedDay[index].eventId!);
                                  eventsOfSelectedDay.remove(eventsOfSelectedDay[index]);

                                  setState(() {});
                                },
                              ),
                            );
                          }
                        ),
                      )
                    ]
                  ],
                ),
              ],
            ),
          );
        }
        else if (snapshot.hasError)
        {
          return const Center(
            child: Text("Error while fetching data...", style: TextStyle(fontSize: 24),),
          );
        }
        else
        {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text("Loading events...", style: TextStyle(fontSize: 24),),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  FloatingActionButton getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Add a new event", style: TextStyle(color: Colors.white),),
              backgroundColor: ReminderAppPalette.mainColor,
              content: TextField(
                decoration: const InputDecoration(
                  hintText: "Add description",
                  hintStyle: TextStyle(color: Color.fromARGB(96, 236, 236, 236))
                ),
                style: const TextStyle(color: Colors.white),
                controller: eventDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
              actions: [
                TextButton(
                  onPressed: ()  {
                    eventDescriptionController.clear();
                    Navigator.pop(context);
                  }, 
                  child: const Text("Cancel")
                ),
                TextButton(
                  onPressed: () async {
                    Event event = Event(eventDate: HomePage.daySelected, eventDesc: eventDescriptionController.text);
                    eventDescriptionController.clear();
                    await DatabaseHelper.instance.insertNewEvent(event);
                    
                    setState(() {});

                    if (context.mounted)
                    {
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text("Add")
                ),
              ],
            );
          }
        );
      },
      backgroundColor: ReminderAppPalette.mainColor,
      child: const Icon(Icons.add),
    );
  }
  
  void focusToToday() {
    DateTime now = DateTime.now();

    monthScrollController.animateToPage(
      now.month - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut
    );

    changeDateToToday();
  }

  void changeDate(int month, int day) async {
    setState(() {
      HomePage.daySelected = "${month}_$day";
    });
  }

  void changeDateToToday() {
    setState(() {
      HomePage.daySelected = widget.today;
    });
  }
}