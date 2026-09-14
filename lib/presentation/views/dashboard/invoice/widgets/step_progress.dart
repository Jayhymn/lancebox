class StepProgress {
  final String label;
  final bool isGreyed;
  final int flex;

  const StepProgress({
    required this.label,
    this.isGreyed = true,
    this.flex = 1,
  });
}