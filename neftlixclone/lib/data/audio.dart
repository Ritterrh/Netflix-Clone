class Audio {
  final String id;
  final String name;
  final String? description;
  final String tags;
  final Duration durationMinutes;
  final String thumbnailImageId;
  final num trendingIndex;

  bool isEmpty() {
    if (id.isEmpty || name.isEmpty) {
      return true;
    }

    return false;
  }

  Audio({
    required this.id,
    required this.name,
    this.description,
    required this.tags,
    required this.durationMinutes,
    required this.thumbnailImageId,
    required this.trendingIndex,
  });

  static Audio empty() {
    return Audio(
      id: '',
      name: '',
      description: '',
      tags: '',
      durationMinutes: const Duration(minutes: -1),
      thumbnailImageId: '',
      trendingIndex: -1,
    );
  }

  static Audio fromJson(Map<String, dynamic> data) {
    return Audio(
      id: data['\$id'],
      name: data['name'] ?? "",
      description: data['description'],
      tags: data['tags'],
      durationMinutes: Duration(minutes: data['durationMinutes']),
      thumbnailImageId: data['thumbnailImageId'],
      trendingIndex: 1,
    );
  }
}
