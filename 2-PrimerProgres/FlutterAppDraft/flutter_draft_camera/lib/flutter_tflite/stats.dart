class Stats {
  int totalPredictTime;
  //int totalElapsedTime;
  int inferenceTime;
  int preProcessingTime;

  Stats(
    {required this.totalPredictTime,
    //required this.totalElapsedTime,
    required this.inferenceTime,
    required this.preProcessingTime}
  );

  @override
  String toString() {
    return 'Stats{totalPredictTime: $totalPredictTime, inferenceTime: $inferenceTime, preProcessingTime: $preProcessingTime}';
  }
}