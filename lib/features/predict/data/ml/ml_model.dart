import 'dart:developer';
import 'dart:typed_data';
import 'package:greenshield_ai/features/predict/data/label/index_wise_labels.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:greenshield_ai/features/predict/domain/result_class.dart';

typedef Prediction = ({
  int classLabel,
  double confidence,
});

abstract class ModelRepo {
  Future<ResultClass?> getPrediction({
    required XFile? image,
  });
}

class ModelRepoImpl implements ModelRepo {
  late Interpreter interpreter;
  late List<String> labels;
  late List<int> inputShape;
  late List<int> outputShape;
  late bool isModelLoaded = false;

  // Model load from the assets along the labels
  loadModel() async {
    if (isModelLoaded) return;
    try {
      final modelFile = await rootBundle.load('assets/t_assets/model.tflite');
      interpreter = Interpreter.fromBuffer(modelFile.buffer.asUint8List());

      final labelData =
          await rootBundle.loadString('assets/t_assets/labels.txt');
      labels =
          labelData.split('\n').where((label) => label.isNotEmpty).toList();

      // Get Input & Output tensor shapes
      inputShape = interpreter.getInputTensor(0).shape;
      outputShape = interpreter.getOutputTensor(0).shape;

      log("✅ Model & Labels Loaded! Labels Count: ${labels.length}");
      log("Input Shape: $inputShape | Output Shape: $outputShape");
      isModelLoaded = true;
    } catch (e, err) {
      log("", error: e, stackTrace: err);
      throw Exception("Failed to load model: $e");
    }
  }

  // helpers
  // Preprocess image: Resize, Normalize, Convert to Float
  Float32List _preprocessImage(img.Image image) {
    int inputSize = inputShape[1]; // Get the expected input size from model
    img.Image resized =
        img.copyResize(image, width: inputSize, height: inputSize);

    var input = Float32List(inputSize * inputSize * 3);
    int index = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        img.Pixel pixel = resized.getPixelSafe(x, y);

        // *Use correct normalization as per Python code*
        input[index++] = pixel.r - 127.5 / 127.5; // Normalize to [-1,1]
        input[index++] = pixel.g - 127.5 / 127.5;
        input[index++] = pixel.b - 127.5 / 127.5;
      }
    }

    return input;
  }

  // Classify Image
  Future<Prediction?> classifyImage(img.Image image) async {
    try {
      var input = _preprocessImage(image);
      var reshapedInput =
          input.reshape([1, inputShape[1], inputShape[2], inputShape[3]]);

      var output =
          List.filled(outputShape[1], 0.0).reshape([1, outputShape[1]]);

      interpreter.run(reshapedInput, output);
      log("📊 Model Output: $output");

      // Convert output to List<double>
      List<double> probabilities = List<double>.from(output[0]);

      // Find the highest probability index
      int predictedClass =
          probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
      double confidence = probabilities[predictedClass];

      // confidence in 2 percentage
      confidence = confidence * 100;

      log("🔹 Predicted Class: ${labels[predictedClass]} | Confidence: ${probabilities[predictedClass].toStringAsFixed(2)}");
      return (
        classLabel: predictedClass,
        confidence: confidence,
      );
    } catch (e, err) {
      log("❌ Error: $e", error: e, stackTrace: err);
      throw Exception("Failed to classify image: $e");
    }
  }

  @override
  Future<ResultClass?> getPrediction({required XFile? image}) async {
    await loadModel();
    try {
      final image0 = await image!.readAsBytes();
      img.Image? decodedImage = img.decodeImage(Uint8List.fromList(image0));

      if (decodedImage == null) {
        return null;
      }

      final result = await classifyImage(decodedImage);

      final classIndex = result!.classLabel;
      final label = DISEASEMAP[classIndex];
      final confidence = result.confidence;

      return ResultClass(
        result: label ?? "Unknown",
        confidence: confidence.toStringAsFixed(2),
      );
    } catch (e, stacktrace) {
      log("❌ Error: $e", error: e, stackTrace: stacktrace);
      return null;
    }
  }
}
