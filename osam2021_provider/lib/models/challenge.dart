class Challenge {
  final String name;
  final String bgColor;
  final String announcement;
  final String date;
  final String attendants;
  final int code;
  final bool added;
  final String prize;

  Challenge({required this.name, required this.bgColor, required this.prize, required this.announcement, required this.date, required this.attendants, required this.code, required this.added});
}

List<Challenge> open = [
  Challenge(
      code: 0,
      bgColor: '#ffffff',
      name: '259대대 잔반대결',
      announcement: '이기자! 수호대대 병사 여러분, 좋은 취지에 함께하기 위해 챌린지에 참여해주셔서 감사합니다.', //
      date: '2021-11-30 23:59:59',
      attendants: '150',
      added: false,
      prize: '상점 20점'),
  Challenge(
      code: 1,
      bgColor: '#ffffff',
      name: 'Challenge 2',
      announcement: 'hello2', //
      date: '2021-11-01 23:59:59',
      attendants: '50',
      added: false,
      prize: '전투휴무 1일')
];
