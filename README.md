# Story App - Dicoding

Simple application Social Media using the Flutter framework. This repository is one of the tasks to get a certificate in Learn Flutter Intermediate App Development.

## How to Run

this project use [Flutter 3.16.9](https://flutter.dev/)

1. Clone this project
2. Input Your geo.API_KEY at AndroidManifest.xml and AppDelegate.swift
3. Run this command
   ```bash
   flutter pub get
   flutter flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. Run app Flavor Free
   ```bash
   flutter run --flavor free -t lib/main_free.dart
   ```
   or
   
   Flavor paid
   ```bash
   flutter run --flavor paid -t lib/main_paid.dart
   ```
