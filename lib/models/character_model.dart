class CharacterModel {
  final int index;
  final String title;
  final String originalTitle;
  final String releaseDate;
  final String pages;
  final List<String> children;
  final String image;
  final String description ;

  CharacterModel({
    required this.index,
    required this.title,
    required this.originalTitle,
    required this.releaseDate,
    required this.pages,
    required this.children,
    required this.image,
    required this.description,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      index: json['index'] ?? 0,
      title: json['title']?.toString() ?? '-',
      originalTitle: json['originalTitle']?.toString() ?? '-',
      releaseDate: json['releaseDate']?.toString() ?? '-',
      pages: json['pages']?.toString() ?? '-',
      children: (json['children'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      image: json['image']?.toString() ?? '',
      description: json['descriptione']?.toString() ?? '-',
    );
  }
}