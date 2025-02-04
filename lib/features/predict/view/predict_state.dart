import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class PredictState extends Equatable {
  final bool isLoading;
  final String? prediction;
  final String? confidence;
  final XFile? image;
  final bool? isAiLoading;
  final String? description;
  final String? symptoms;
  final String? prevention;
  const PredictState({
    required this.isLoading,
    this.prediction,
    this.confidence,
    this.image,
    this.isAiLoading,
    this.description,
    this.symptoms,
    this.prevention,
  });

  @override
  List<Object?> get props => [
        isLoading,
        image,
        prediction,
        confidence,
        isAiLoading,
        description,
        symptoms,
        prevention
      ];

  PredictState copyWith({
    bool? isLoading,
    String? prediction,
    String? confidence,
    XFile? image,
    bool? isAiLoading,
    String? description,
    String? symptoms,
    String? prevention,
  }) {
    return PredictState(
      isLoading: isLoading ?? this.isLoading,
      prediction: prediction ?? this.prediction,
      confidence: confidence ?? this.confidence,
      image: image ?? this.image,
      isAiLoading: isAiLoading ?? this.isAiLoading,
      description: description ?? this.description,
      symptoms: symptoms ?? this.symptoms,
      prevention: prevention ?? this.prevention,
    );
  }

  factory PredictState.init() => PredictState(
        isLoading: false,
        prediction: null,
        confidence: null,
        image: null,
        isAiLoading: false,
        description: null,
        symptoms: null,
        prevention: null,
      );
}
