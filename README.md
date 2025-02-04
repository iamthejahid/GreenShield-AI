
# GreenShield AI - Agricultural Assistant

GreenShield AI is an AI-powered mobile application designed to assist farmers and agricultural professionals in identifying plant diseases, providing treatment suggestions, and offering disease prevention methods. The app uses machine learning for disease classification and leverages the OpenAI API/Deepseek for in-depth guidance on managing plant health.

## Features

-   **Disease Prediction:** Upload images of plants to predict potential diseases using a trained TensorFlow Lite model.
-   **AI-Powered Recommendations:** Get detailed recommendations on disease symptoms, prevention, and treatment from OpenAI's DeepSeek.
-   **Real-Time Feedback:** Receive immediate predictions and responses to queries related to plant health in Bengali.

## Tech Stack

-   **Flutter**: For building the cross-platform mobile application (iOS and Android).
-   **TensorFlow Lite**: For running a pre-trained deep learning model to classify diseases from images.
-   **AI**: For detailed agricultural recommendations via the DeepSeek/Open AI API.
-   **Dart**: The programming language used to write the app's logic.

## Project Structure

### `lib/features/predict/data/ml/ml_model.dart`

This file contains the logic for loading the TensorFlow Lite model, preprocessing input images, and classifying the images into disease categories. The `ModelRepo` interface and `ModelRepoImpl` implementation encapsulate the logic for model loading, prediction, and handling the image preprocessing.

### `lib/features/predict/data/deepseek/deep_seek_repo.dart`

This file interfaces with the DeepSeek API to send messages regarding the predicted disease and receive detailed responses in Bengali. The `DeepSeekRepoImpl` class handles the API communication, including loading the API key and making requests to OpenAI's/Deepseeks GPT model.

### `lib/features/predict/view/predict_state.dart`

This file defines the state management logic for the app. It uses `StateNotifierProvider` to manage the state of the prediction process, including loading, result updates, and the communication with DeepSeek for additional information.

### `lib/core/helpers/ui_exporter.dart`

Contains common UI helpers to manage widgets and layout for the user interface.

### `lib/core/service_location.dart`

Responsible for setting up and managing the dependencies using the `get_it` package for service locator functionality.

### `lib/main.dart`

Entry point for the Flutter application, setting up routing and service locator initialization.

## How the App Works

1.  **Image Upload:**
    
    -   Users can upload an image of a plant using either the camera or the gallery.
    -   The image is passed to the model for disease classification.
2.  **Prediction & AI Guidance:**
    
    -   The trained TensorFlow Lite model predicts the disease category and provides the confidence level.
    -   If a prediction is made, the app sends the disease name to the DeepSeek API.
    -   DeepSeek responds with detailed disease information, including symptoms and treatment methods in Bengali.
3.  **Display Results:**
    
    -   The app shows the predicted disease, the confidence level, and detailed prevention/treatment guidelines on the screen.

## Dependencies

-   `flutter_riverpod`: For state management and dependency injection.
-   `image_picker`: For picking images from the gallery or camera.
-   `tflite_flutter`: To run the TensorFlow Lite model in the Flutter app.
-   `http`: For making HTTP requests to the DeepSeek API.
-   `image`: For image processing (resizing, decoding).
-   `get_it`: For service locator functionality.

## Example Use Case

1.  A user opens the app and takes a photo of a plant that seems unhealthy.
2.  The app predicts a potential disease and displays the results with high confidence.
3.  The app sends the disease name to the DeepSeek API, which responds with more detailed information about the disease.
4.  The user receives the disease description, symptoms, and prevention/treatment methods in Bengali.

## Folder Structure

```

.
├── app
│   ├── app.dart
│   └── bootstrap.dart
├── core
│   ├── color
│   │   └── app_colors.dart
│   ├── helpers
│   │   ├── dismiss_keyboard.dart
│   │   ├── internet_connection_checker.dart
│   │   ├── toaster.dart
│   │   └── ui_exporter.dart
│   ├── router
│   │   ├── error_page.dart
│   │   └── router_notifier.dart
│   ├── service_location.dart
│   ├── sizes.dart
│   ├── theme_data.dart
│   └── widgets
│       ├── custom_button.dart
│       ├── decorated_container.dart
│       └── label_text.dart
├── features
│   ├── predict
│   │   ├── data
│   │   ├── domain
│   │   └── view
│   └── splashscreen
│       └── view
└── main.dart
./

```


### Assets 
```
.
├── capture.png
├── chat.png
├── green_leaf.png
└── t_assets
    ├── api_key.txt
    ├── labels.txt
    └── model.tflite
```

## Preview
<p align="center">
  <img src="media/sr.gif" alt="recording" width="200" />
</p>
