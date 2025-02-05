-keep class org.tensorflow.lite.** { *; }
-keep class org.tensorflow.lite.gpu.** { *; }
-keepclassmembers class * {
    @org.tensorflow.lite.Interpreter.Options <fields>;
}
-dontwarn org.tensorflow.lite.**
