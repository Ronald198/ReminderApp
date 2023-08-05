class Event {
  final int? eventId;
  final String eventDate;
  final String eventDesc;

  Event({this.eventId, required this.eventDate, required this.eventDesc});

  factory Event.fromMap(Map<String, dynamic> json) => Event(
    eventId: json['eventId'],
    eventDate: json['eventDate'],
    eventDesc: json['eventDesc'],
  );

  Map<String, dynamic> toMap(){
    return {
      'eventId': eventId,
      'eventDate' : eventDate,
      'eventDesc' : eventDesc,
    };
  }
}
