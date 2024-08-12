class TbPrediction{
  late final int pred_idx;
  late final int plant_idx;
  late final String pred_date;
  late final double pred_power;
  late final String created_at;
  late final double actual;

  TbPrediction({
    required this.pred_idx,
    required this.plant_idx,
    required this.pred_date,
    required this.pred_power,
    required this.created_at,
    required this.actual,
  });
  factory TbPrediction.fromJson(Map<String, dynamic> json) {
    return TbPrediction(
      pred_idx: json['pred_idx'],
      plant_idx: json['plant_idx'],
      pred_date: json['pred_date'],
      pred_power: json['pred_power'],
      created_at: json['created_at'],
      actual: json['actual'],
    );
  }
}
