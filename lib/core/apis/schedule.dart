import 'dart:math';

Random rand = Random();

Map<String, dynamic> getScheduleAPI(String scheduleId) {
  return {
    'id': 's009003',
    'lectureIds': List.generate(5, (i) => 'l0090' + i.toString()),
    'eventIds': List.generate(4, (i) => 'e0090' + i.toString()),
  };
}

Map<String, dynamic> getLectureAPI(String lectureId) {
  int k = int.parse(lectureId[lectureId.length - 1]);
  return {
    'id': lectureId,
    'parentId': 's009003', //schedule
    'title': [
      'Computer Architecture',
      'System Programming',
      'Philosophy',
      'Data Structure',
      'Algorithm'
    ][k % 5],
    'rate': 3.8,
    'notification': rand.nextBool(),
    'description': """Computer Science is so interesting!
I love CSE!
This Lecture page is board Level page.
You can talk with classmates.
Ask and Answer about lecture!""",
    'professor': 'Daewoong Ko',
    'room': 'Klaus 314',
    'grade': 'Absolute',
    'exam': '3 times',
    'attendance': 'check',
    'book': 'The Art of Computer Science 2ed',
    'times': [
      ['Mon | 09:30 ~ 11:00', 'Wed | 09:30 ~ 11:00'],
      ['Tue | 10:45 ~ 12:15', 'Thu | 10:45 ~ 12:15'],
      ['Fri | 09:00 ~ 12:00'],
      ['Mon | 12:30 ~ 15:00'],
      ['Tue | 13:30 ~ 15:45', 'Thu | 13:30 ~ 15:45'],
    ][k % 5]
  };
}

Map<String, dynamic> getEvent(String id) {
  return {
    'title': 'Birthday',
    'timeRange': '00:00 ~ 24:00',
    'date': '03/21/2021',
    'rate': 4.5,
    'infos': {
      'Periodicity': 'Annual',
      'Alerts': '00:00',
    }
  };
} // PREVIOUS

Map<String, dynamic> getEventAPI(String eventId) {
  int k = int.parse(eventId[eventId.length - 1]);
  return {
    'id': eventId,
    'parentId': 's009003', //schedule
    'title': [
      'Interview', // none
      'Internship', // weekly
      'Birth Day', // annually
      'volunteer' // monthly
    ][k % 4],
    'description': [
      'Google Job Interview! *final',
      'Going Home~~',
      "It's my BIRTH DAY! yeah",
      'Teaching children'
    ][k % 4],
    'periodicity': ['none', 'Weekly', 'Annually', 'Monthly'][k % 4],
    'times': [
      ['02/24/2021 | 12:00 ~ 13:15'],
      ['03/13/2021 | 07:00 ~ 08:00'],
      ['03/21/2021 | 00:00 ~ 00:00'],
      ['03/12/2021 | 17:00 ~ 20:00', '03/19/2021 | 17:00 ~ 20:00']
    ][k % 4],
    'alerts': [
      ['10:00', '11:55'],
      ['06:00'],
      [],
      ['16:30']
    ][k % 4]
  };
}

List<String> getTodayEventIds(String scheduleId) {
  return ['l009001', 'l009004'];
}

List<String> getReviewIdsAPI(String lectureId) {
  return List.generate(7, (i) => 'rv0090' + i.toString());
}

List<String> getEventIdsAPI(String scheduleId) {
  return ['e009001', 'e009002', 'e009003', 'e009004'];
}