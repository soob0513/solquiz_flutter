class Member {
  final List<String?> MEM_ID;
  final List<String?> MEM_PW;
  final List<String?> MEM_NAME;
  final List<String?> MEM_PHONE;
  final List<String?> MEM_EMAIL;
  final List<String?> JOINED_AT;
  final List<String?> MEM_ROLE;

  Member({
    required this.MEM_ID,
    required this.MEM_PW,
    required this.MEM_NAME,
    required this.MEM_PHONE,
    required this.MEM_EMAIL,
    required this.JOINED_AT,
    required this.MEM_ROLE,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      MEM_ID: List<String>.from(json['mem_id'] as List<dynamic>),
      MEM_PW: List<String>.from(json['mem_pw'] as List<dynamic>),
      MEM_NAME: List<String>.from(json['mem_name'] as List<dynamic>),
      MEM_PHONE: List<String>.from(json['mem_phone'] as List<dynamic>),
      MEM_EMAIL: List<String>.from(json['mem_email'] as List<dynamic>),
      JOINED_AT: List<String>.from(json['joined_at'] as List<dynamic>),
      MEM_ROLE: List<String>.from(json['mem_role'] as List<dynamic>),
    );
  }
}
