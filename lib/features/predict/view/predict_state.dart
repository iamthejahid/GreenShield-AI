import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class PredictState extends Equatable {
  final bool isLoading;
  final String? prediction;
  final String? confidence;
  final String? aiResponse;
  final XFile? image;
  const PredictState({
    required this.isLoading,
    this.prediction,
    this.confidence,
    this.aiResponse,
    this.image,
  });

  @override
  List<Object?> get props =>
      [isLoading, image, prediction, confidence, aiResponse];

  PredictState copyWith(
      {bool? isLoading,
      String? prediction,
      String? confidence,
      String? aiResponse,
      XFile? image}) {
    return PredictState(
      isLoading: isLoading ?? this.isLoading,
      prediction: prediction ?? this.prediction,
      confidence: confidence ?? this.confidence,
      aiResponse: aiResponse ?? this.aiResponse,
      image: image ?? this.image,
    );
  }

  factory PredictState.init() => PredictState(
        isLoading: false,
        prediction: null,
        confidence: null,
        aiResponse: null,
        image: null,
      );
}
