enum BannerType { image, video }

class BannerItem {
  final BannerType type;
  final String url;

  BannerItem({
    required this.type,
    required this.url,
  });
}