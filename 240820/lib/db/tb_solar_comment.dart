// TB_SOLAR_COMMENT
class RecruitComment {
  final List<String?> PLANT_POWER;
  final List<String?> PLACE;
  final List<String?> SB_TYPE;
  final List<String?> B_STATE;
  // final List<String?> SP_STA;

  RecruitComment({
    required this.PLANT_POWER,
    required this.PLACE,
    required this.SB_TYPE,
    required this.B_STATE,
    // required this.SP_STA,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory RecruitComment.fromJson(Map<String, dynamic> json) {
    return RecruitComment(
      PLANT_POWER: List<String>.from(json['plant_power'] as List<dynamic>),
      PLACE: List<String>.from(json['place'] as List<dynamic>),
      SB_TYPE: List<String>.from(json['sb_type'] as List<dynamic>),
      B_STATE: List<String>.from(json['b_state'] as List<dynamic>),
      // SP_STA : List<String>.from(json['sp_sta'] as List<dynamic>),
    );
  }
}

class RecruitComment2 {
  final List<int?> SP_IDX;
  final List<int?> SB_IDX;
  final List<String?> MEM_ID;
  final List<String?> SP_STA;

  RecruitComment2({
    required this.SP_IDX,
    required this.SB_IDX,
    required this.MEM_ID,
    required this.SP_STA,
  });

  factory RecruitComment2.fromJson(Map<String, dynamic> json) {
    return RecruitComment2(
      SP_IDX: List<int>.from(json['sp_idx'] as List<dynamic>),
      SB_IDX: List<int>.from(json['sb_idx'] as List<dynamic>),
      MEM_ID: List<String>.from(json['mem_id'] as List<dynamic>),
      SP_STA : List<String>.from(json['sp_sta'] as List<dynamic>),

    );
  }
}



/*
class RecruitComment {
  final List<String?> PLACE;
  final List<String?> SB_TYPE;
  final List<int?> PLANT_POWER;

  RecruitComment({
    required this.PLACE,
    required this.SB_TYPE,
    required this.PLANT_POWER,
  });

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() => {
    'PLACE': PLACE,
    'SB_TYPE': SB_TYPE,
    'PLANT_POWER': PLANT_POWER,
  };

  // JSON을 객체로 변환
  factory RecruitComment.fromJson(Map<String, dynamic> json) => RecruitComment(
    PLACE: List<String?>.from(json['PLACE'] ?? []),
    SB_TYPE: List<String?>.from(json['SB_TYPE'] ?? []),
    PLANT_POWER: List<int?>.from(json['PLANT_POWER'] ?? []),
  );
}
 */

