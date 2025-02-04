import 'package:greenshield_ai/core/helpers/ui_exporter.dart';
import 'package:greenshield_ai/core/service_location.dart';
import 'package:greenshield_ai/features/predict/data/ml/ml_model.dart';
import 'package:greenshield_ai/features/predict/view/predict_state.dart';
import 'package:image_picker/image_picker.dart';

final predictStateProvider =
    StateNotifierProvider<PredictStateNotifier, PredictState>((ref) {
  return PredictStateNotifier(
    modelRepo: sl(),
  );
});

class PredictStateNotifier extends StateNotifier<PredictState> {
  final ModelRepo modelRepo;
  PredictStateNotifier({
    required this.modelRepo,
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
      } else {
        stateMaker(state.copyWith(isLoading: false));
      }
    } else {
      stateMaker(state.copyWith(isLoading: false));
    }
  }

  reset() => stateMaker(PredictState.init());
}
