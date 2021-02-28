Map<String, dynamic> user = {
  'id': 'u009003',
  'username': 'kodw0402',
  'univId': 'univ009',
  'scheduleId': 's009003',
  'isVerified': true,
  'universityName': "Georgia Tech",
  'entranceYear': 2017,
  'profileImgURL':
      'https://avatars.githubusercontent.com/u/36005723?s=460&u=49590ea0e7bb1936d515ed627867e8ca217b145b&v=4',
};

Map<String, dynamic> currentUniv;

String todayString() {
  DateTime now = DateTime.now();
  return '${now.month}/${now.day}/${now.year}';
}

String todayWeekday() {
  DateTime now = DateTime.now();
  return ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][now.weekday];
}
