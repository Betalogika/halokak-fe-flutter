
class CategoryResponse {
  int? total;
  List<Map<String, dynamic>>? data;

  CategoryResponse({ this.total, this.data });

  factory CategoryResponse.from(Map<String, dynamic> json) {
    return CategoryResponse(
      total: json['total'],
      data: json['data'] != null ? List<Map<String, dynamic>>.from(json["data"].map((x) => x)) : null,
    );
  }
}

class RecommendMentorResponse {
  int? total;
  List<Map<String, dynamic>>? data;

  RecommendMentorResponse({ this.total, this.data });

  factory RecommendMentorResponse.from(Map<String, dynamic> json) {
    return RecommendMentorResponse(
      total: json['total'],
      data: json['data'] != null ? List<Map<String, dynamic>>.from(json["data"].map((x) => x)) : null,
    );
  }
}