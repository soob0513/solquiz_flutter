// TB_SOLAR_BOARD
class RecruitBoards {
  final List<int?> SB_IDX;
  final List<String?> SB_TYPE;
  final List<int?> PLANT_POWER_SUM;
  final List<String?> MEM_ID;
  final List<String?> PLACE;
  final List<String?> B_STATE;

  RecruitBoards({
    required this.SB_IDX,
    required this.SB_TYPE,
    required this.PLANT_POWER_SUM,
    required this.MEM_ID,
    required this.PLACE,
    required this.B_STATE,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory RecruitBoards.fromJson(Map<String, dynamic> json) {
    return RecruitBoards(
      SB_IDX: List<int>.from(json['sb_idx'] as List<dynamic>),
      SB_TYPE: List<String>.from(json['sb_type'] as List<dynamic>),
      PLANT_POWER_SUM: List<int>.from(json['plant_power_sum'] as List<dynamic>),
      MEM_ID: List<String>.from(json['mem_id'] as List<dynamic>),
      PLACE: List<String>.from(json['place'] as List<dynamic>),
      B_STATE: List<String>.from(json['b_state'] as List<dynamic>),
    );
  }
}
