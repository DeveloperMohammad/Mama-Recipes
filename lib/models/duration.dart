class DurationFilter {
  final String title;
  final Duration maxDuration;
  final Duration minDuration;

  const DurationFilter({
    required this.title,
    required this.maxDuration,
    required this.minDuration,
  });
}