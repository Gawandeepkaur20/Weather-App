🌦️ Mausam – Weather Forecast App

A clean and modern Flutter app that displays real-time weather data using OpenWeather API.

<p align="center"> <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" /> <img src="https://img.shields.io/badge/Dart-Language-blue?logo=dart" /> <img src="https://img.shields.io/badge/OpenWeather-API-orange" /> <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-green" /> </p>
🌟 Overview

Mausam is a simple and fast weather forecasting app built with Flutter.
It provides real-time weather details like:

🌡️ Temperature

💧 Humidity

💨 Wind Speed

📍 Weather by city search

⏳ Clean loading animation

📊 Data fetched live using the OpenWeather API

🛠️ Tech Stack

Flutter (Dart)

OpenWeather API

HTTP Package
 lib/
 ├── main.dart
 ├── home.dart
 ├── loading.dart
 ├── location.dart
 ├── worker.dart
assets/
images/
⚙️ How It Works
1️⃣ User enters a city name
2️⃣ App sends request to OpenWeather API
3️⃣ Weather data (temp, humidity, wind speed) comes in JSON
4️⃣ App displays clean and formatted UI
🔑 Setup: API Key

Create a free account on: https://openweathermap.org/api
Generate an API Key
Add your key in your code:
String apiKey = "YOUR_API_KEY_HERE";

🚀 Run the App
Clone the repo:
git clone https://github.com/Gawandeepkaur20/Weather-App.git

Navigate to project:
cd Weather-App

Install dependencies:
flutter pub get

Run:
flutter run

🔮 Future Enhancements

☁️ 5-day & 7-day weather forecast

📍 Auto-location weather (GPS)

🎨 Animated weather icons

🌙 Dark & Light mode

☔ Rain probability, sunrise/sunset times

