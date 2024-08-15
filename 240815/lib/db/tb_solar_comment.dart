// TB_SOLAR_COMMENT
class RecruitComment {
  final List<String?> PLANT_POWER;
  final List<String?> PLACE;
  final List<String?> SB_TYPE;

  RecruitComment({
    required this.PLANT_POWER,
    required this.PLACE,
    required this.SB_TYPE,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory RecruitComment.fromJson(Map<String, dynamic> json) {
    return RecruitComment(
      PLANT_POWER: List<String>.from(json['plant_power'] as List<dynamic>),
      PLACE: List<String>.from(json['place'] as List<dynamic>),
      SB_TYPE: List<String>.from(json['sb_type'] as List<dynamic>),

    );
  }
}
