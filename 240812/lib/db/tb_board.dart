// lib/models/board.dart
class Boards {
  final List<int?> B_IDX; // 게시물 인덱스 목록
  final List<String?> B_TITLE; // 제목 목록
  final List<String> B_FILE; // 파일 목록
  final List<String> CREATED_AT; // 생성일 목록
  final List<int> B_VIEW; // 조회수 목록
  final List<int> B_LIKES; // 좋아요 수 목록
  final List<String> MEM_ID; // 회원 ID 목록
  final List<String> B_CONTENT; // 내용 목록

  Boards({
    required this.B_IDX,
    required this.B_TITLE,
    required this.B_FILE,
    required this.CREATED_AT,
    required this.B_VIEW,
    required this.B_LIKES,
    required this.MEM_ID,
    required this.B_CONTENT,
  });

  // JSON 데이터를 Boards 객체로 변환하는 팩토리 메서드
  factory Boards.fromJson(Map<String, dynamic> json) {
    return Boards(
      B_IDX: List<int>.from(json['idx'] as List<dynamic>),
      B_TITLE: List<String>.from(json['title'] as List<dynamic>),
      B_FILE: List<String>.from(json['filename'] as List<dynamic>),
      CREATED_AT: List<String>.from(json['created_at'] as List<dynamic>),
      B_VIEW: List<int>.from(json['view'] as List<dynamic>),
      B_LIKES: List<int>.from(json['likes'] as List<dynamic>),
      MEM_ID: List<String>.from(json['mem_id'] as List<dynamic>),
      B_CONTENT: List<String>.from(json['content'] as List<dynamic>),
    );
  }
}
