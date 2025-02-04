import 'dart:developer';

import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/core/service_location.dart';
import 'package:greenshield_ai/features/predict/data/deepseek/deep_seek_repo.dart';
import 'package:greenshield_ai/features/predict/data/ml/ml_model.dart';
import 'package:greenshield_ai/features/predict/view/predict_state.dart';
import 'package:image_picker/image_picker.dart';

final predictStateProvider =
    StateNotifierProvider<PredictStateNotifier, PredictState>((ref) {
  return PredictStateNotifier(
    modelRepo: sl(),
    deepSeekRepo: sl(),
  );
});

class PredictStateNotifier extends StateNotifier<PredictState> {
  final ModelRepo modelRepo;
  final DeepSeekRepo deepSeekRepo;
  PredictStateNotifier({
    required this.modelRepo,
    required this.deepSeekRepo,
  }) : super(PredictState.init());

  stateMaker(PredictState newState) => state = newState;

  startPrediction({required ImageSource imageSource}) async {
    stateMaker(PredictState.init().copyWith(isLoading: true));
    final image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      final result = await modelRepo.getPrediction(image: image);
      if (result != null) {
        stateMaker(state.copyWith(
          isLoading: false,
          image: image,
          prediction: result.result,
          confidence: result.confidence,
        ));
        loadFromAI(disease: result.result);
      } else {
        stateMaker(state.copyWith(isLoading: false));
      }
    } else {
      stateMaker(state.copyWith(isLoading: false));
    }
  }

  reset() => stateMaker(PredictState.init());

  loadFromAI({required String disease}) async {
    stateMaker(state.copyWith(isAiLoading: true));
    final response = await deepSeekRepo.sendMessageToDeepSeek(message: disease);
    if (response != null) {
      log("Response: $response");
      final regex = RegExp(
          r'^(.*?)#1# লক্ষণ #1# (.*?)#2# প্রতিরোধ ও প্রতিকার #2# (.*)$',
          dotAll: true); // dotAll allows matching newlines

      final match = regex.firstMatch(response);

      if (match != null) {
        final description = match.group(1)?.trim() ?? "";
        final symptoms = match.group(2)?.trim() ?? "";
        final prevention = match.group(3)?.trim() ?? "";
        stateMaker(state.copyWith(
          isAiLoading: false,
          description: description,
          symptoms: symptoms,
          prevention: prevention,
        ));
      }
    } else {
      stateMaker(state.copyWith(isAiLoading: false));
    }
  }
}
