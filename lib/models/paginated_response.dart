import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T> content;
  final int totalElements;
  final int totalPages;
  final int size;
  final int number;
  final bool first;
  final bool last;
  
  PaginatedResponse({
    required this.content,
    required this.totalElements,
    required this.totalPages,
    required this.size,
    required this.number,
    required this.first,
    required this.last,
  });
  
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);
      
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
  
  // Helper method to create from API response
  factory PaginatedResponse.fromApiResponse(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    // Handle different response formats
    final items = json['items'] ?? json['content'] ?? json;
    final totalItems = json['totalItems'] ?? json['totalElements'] ?? 
                      (items is List ? items.length : 0);
    final pageSize = json['size'] ?? json['limit'] ?? 10;
    final pageNumber = json['number'] ?? 
                      (json['offset'] != null ? (json['offset'] / pageSize).floor() : 0);
    
    List<T> content;
    if (items is List) {
      content = items.map((e) => fromJsonT(e)).toList();
    } else {
      content = [];
    }
    
    return PaginatedResponse(
      content: content,
      totalElements: totalItems,
      totalPages: (totalItems / pageSize).ceil(),
      size: pageSize,
      number: pageNumber,
      first: pageNumber == 0,
      last: pageNumber >= (totalItems / pageSize).ceil() - 1,
    );
  }
}