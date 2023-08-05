import 'package:flutter/material.dart';
import 'package:reminderapp/databaseHelper.dart';
import 'package:reminderapp/models/event.dart';
import 'package:reminderapp/widgets/drawer.dart';
import 'package:reminderapp/widgets/header.dart';
import 'package:reminderapp/services/date_codes_helper.dart';

class ListAllEventsPage extends StatefulWidget {
  const ListAllEventsPage({super.key});

  @override
  State<ListAllEventsPage> createState() => _ListAllEventsPageState();
}

class _ListAllEventsPageState extends State<ListAllEventsPage> {
  Map<int, String> monthIntToString = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getHeader(context),
      drawer: getDrawer(context),
      body: getBody(),
    );
  }

  Future<List<Event>> getAllEvents() async {
    List<Event> allEvents = await DatabaseHelper.instance.getAllEventsSorted();
    return allEvents;
  }

  Widget getBody() {
    return FutureBuilder<dynamic>(
      future: getAllEvents(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData)
        {
          List<Event> allEvents = snapshot.data!;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("All events", style: TextStyle(fontSize: 22),)
                ),
              ),
              allEvents.isEmpty
              ?
                const Expanded(
                  child:  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 64),
                      child: Text("No events saved", style: TextStyle(fontSize: 24),),
                    ),
                  ),
                )
              :
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: allEvents.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            if(index == 0 || allEvents[index].eventDate.split("_")[0] != allEvents[index - 1].eventDate.split("_")[0])...[ //Prints every month
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(monthIntToString[int.parse(allEvents[index].eventDate.split("_")[0])]!),
                                )
                              ),
                            ],
                            Card(
                              child: ListTile(
                                leading: Text("${index + 1}."),
                                title: Text(allEvents[index].eventDesc),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () async {
                                    await DatabaseHelper.instance.deleteEventById(allEvents[index].eventId!);
                                    allEvents.remove(allEvents[index]);
                                    setState(() {});
                                  },
                                ),
                                subtitle: Text(codeToDate(allEvents[index].eventDate), style: const TextStyle(fontSize: 12),),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
            ],
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
              mainAxisSize: MainAxisSize.max,
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
}