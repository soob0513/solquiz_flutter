class TbPrediction {
  final List<int?> pred_idx; // 예측 인덱스 목록
  final List<int?> plant_idx; // 식물 인덱스 목록
  final List<String> pred_date; // 측정 날짜
  final List<double> pred_power; // 예측 발전량 목록
  final List<String> created_at; // 예측 발전량 날짜
  final List<double> actual; // 실제 발전량 목록

  TbPrediction({
    required this.pred_idx,
    required this.plant_idx,
    required this.pred_date,
    required this.pred_power,
    required this.created_at,
    required this.actual,
  });

  // JSON 데이터를 TbPrediction 객체로 변환하는 팩토리 메서드
  factory TbPrediction.fromJson(Map<String, dynamic> json) {
    // JSON의 각 필드가 null일 수 있으므로, null 체크를 추가합니다.
    List<int?> getIntList(String key) {
      return (json[key] as List<dynamic>?)?.map((item) => item as int?).toList() ?? [];
    }

    List<String> getStringList(String key) {
      return (json[key] as List<dynamic>?)?.map((item) => item as String).toList() ?? [];
    }

    List<double> getDoubleList(String key) {
      return (json[key] as List<dynamic>?)?.map((item) => (item as num).toDouble()).toList() ?? [];
    }

    return TbPrediction(
      pred_idx: getIntList('pred_idx'),
      plant_idx: getIntList('plant_idx'),
      pred_date: getStringList('pred_date'),
      pred_power: getDoubleList('pred_power'),
      created_at: getStringList('created_at'),
      actual: getDoubleList('actual'),
    );
  }
}
