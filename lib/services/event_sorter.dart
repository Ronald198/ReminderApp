import 'package:reminderapp/models/event.dart';

class EventSorter {
  static List<Event> sortEvents(List<Event> eventsListToSort) { //Helpful in list all events page
    // An event date can come in those formats:
    //  1 - MM_DD
    //  2 - M_D
    //  3 - MM_D
    //  4 - M_DD
    //
    // Nr 1 is the easist to deal with because it can be sorted immediately. (12_11 > 10_22)
    // Other fomrats can get probelems when being compared for example:
    //  - 5_7 is bigger string than 10_7 
    //  - 12_6 is bigger string than 12_10
    // In order to compare dates correctly, the code below adds zero to the other 
    // formats to fit accordingly with format nr 1. So:
    //  M_D becomes 0M_0D, MM_D becomes MM_0D and M_DD becomes 0M_DD

    for (int i = 0; i < eventsListToSort.length; i++) {
      if(eventsListToSort[i].eventDate.length == 3)
      {
        Event newEvent = Event(
          eventId: eventsListToSort[i].eventId,
          eventDate: "0${eventsListToSort[i].eventDate.split("_")[0]}_0${eventsListToSort[i].eventDate.split("_")[1]}", 
          eventDesc: eventsListToSort[i].eventDesc
        );

        eventsListToSort[i] = newEvent;
      }

      if(eventsListToSort[i].eventDate.length == 4)
      {
        Event newEvent;

        if(eventsListToSort[i].eventDate.split("_")[0].length == 2)
        {
          newEvent = Event(
            eventId: eventsListToSort[i].eventId,
            eventDate: "${eventsListToSort[i].eventDate.split("_")[0]}_0${eventsListToSort[i].eventDate.split("_")[1]}", 
            eventDesc: eventsListToSort[i].eventDesc
          );
        }
        else
        {
          newEvent = Event(
            eventId: eventsListToSort[i].eventId,
            eventDate: "0${eventsListToSort[i].eventDate.split("_")[0]}_${eventsListToSort[i].eventDate.split("_")[1]}", 
            eventDesc: eventsListToSort[i].eventDesc
          );
        }

        eventsListToSort[i] = newEvent;
      }
    }

    //sorts events
    eventsListToSort.sort((a, b) => a.eventDate.compareTo(b.eventDate));

    // In order to display the dates correctly after being sorted, the code below 
    // removes zeros we added previously:
    //  0M_0D becomes M_D, MM_0D becomes MM_D and 0M_DD becomes M_DD

    for (int i = 0; i < eventsListToSort.length; i++) {
      Event newEvent = eventsListToSort[i];

      if(eventsListToSort[i].eventDate.split("_")[0][0] == "0" || eventsListToSort[i].eventDate.split("_")[1][0] == "0")
      {
        newEvent = Event(
          eventId: eventsListToSort[i].eventId,
          eventDate: "${eventsListToSort[i].eventDate.split("_")[0][1]}_${eventsListToSort[i].eventDate.split("_")[1]}", 
          eventDesc: eventsListToSort[i].eventDesc
        );
      }

      if(eventsListToSort[i].eventDate.split("_")[1][0] == "0")
      {
        newEvent = Event(
          eventId: eventsListToSort[i].eventId,
          eventDate: "${newEvent.eventDate.split("_")[0]}_${eventsListToSort[i].eventDate.split("_")[1][1]}", 
          eventDesc: eventsListToSort[i].eventDesc
        );
      }

      eventsListToSort[i] = newEvent;
    }

    return eventsListToSort;
  }
}