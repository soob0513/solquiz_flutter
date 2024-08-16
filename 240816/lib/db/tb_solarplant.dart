// TB_SOLARPLANT
class SolarPlant {
  final List<int?> PLANT_IDX;
  final List<String?> MEM_ID;
  final List<String?> PLANT_NAME;
  final List<String?> PLANT_ADDR;
  final List<String?> PLANT_POWER;
  final List<String?> PLACE;
  final List<String?> SB_TYPE;

  SolarPlant({
    required this.PLANT_IDX,
    required this.MEM_ID,
    required this.PLANT_NAME,
    required this.PLANT_ADDR,
    required this.PLANT_POWER,
    required this.PLACE,
    required this.SB_TYPE,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory SolarPlant.fromJson(Map<String, dynamic> json) {
    return SolarPlant(
      PLANT_IDX: List<int>.from(json['plant_idx'] as List<dynamic>),
      MEM_ID: List<String>.from(json['mem_id'] as List<dynamic>),
      PLANT_NAME: List<String>.from(json['plant_name'] as List<dynamic>),
      PLANT_ADDR: List<String>.from(json['plant_addr'] as List<dynamic>),
      PLANT_POWER: List<String>.from(json['plant_power'] as List<dynamic>),
      PLACE: List<String>.from(json['place'] as List<dynamic>),
      SB_TYPE: List<String>.from(json['sb_type'] as List<dynamic>),
    );
  }
}
