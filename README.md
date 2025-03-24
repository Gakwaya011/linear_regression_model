# Soil pH Prediction Project - Summative Assignment

This project provides a machine learning-based API and a Flutter mobile application for predicting soil pH, addressing the need for efficient soil analysis in agriculture.

## Project Overview

* **Objective:** To develop a system for accurate soil pH prediction using machine learning.
* **Components:**
    * API (Backend): FastAPI-based prediction API.
    * Flutter App (Frontend): Mobile application for user interaction.

## Task 1: Linear Regression Task

* **Use Case:** Soil pH prediction for agricultural optimization.
* **Dataset:** `cleaned_rwanda_crops_dataset.csv` [Kaggle].
* **Data Analysis:**
    * Correlation heatmap and variable distribution visualizations were used to understand feature relationships.
* **Model Development:**
    * Linear Regression, Decision Tree, and Random Forest models were implemented.
    * Random Forest was selected as the best-performing model based on Mean Squared Error (MSE).
    * The selected model was saved as `best_ph_model.joblib`.
    * Linear regression model fit plot has been added.
* **Prediction Script:** A script to make predictions using the saved model is included.

## Task 2: API Development

* **API Framework:** FastAPI.
* **Endpoint:** `/predict` (POST).
* **Features:**
    * Swagger UI documentation available at: `https://ph-prediction-api.onrender.com/docs`
    * CORS middleware implemented.
    * Pydantic models enforce data types and range constraints.
    * requirements.txt file is included.
* **Deployment:** Render.com.

## Task 3: Flutter Mobile Application

* **Features:**
    * User input via TextFields.
    * "Predict" button to trigger API calls.
    * Display of prediction results or error messages.

## Task 4: Video Demonstration

* **Video Link:** [https://youtu.be/eCww5HfpBak]
* **Content:**
    * Demonstration of the mobile app and Swagger UI.
    * Explanation of model performance and selection.

## Source of Data

The dataset used for training was sourced from Kaggle, containing soil and environmental data. The data was preprocessed to handle missing values, normalize numerical features, and encode categorical variables to improve model performance.

## Live Links

* **API:**
    * The public API endpoint for predictions is hosted at: `https://ph-prediction-api.onrender.com/predict`
* **Video Demo:**
    * Watch the demo video showcasing how the app works and how predictions are made: [https://youtu.be/eCww5HfpBak]

## How to Run Mobile App

1.  Clone the repository:
    ```bash
    git clone [https://github.com/Cchancee/linear_regression_model.git](https://www.google.com/search?q=https://github.com/Cchancee/linear_regression_model.git)
    cd FlutterApp/
    ```
2.  Install Flutter dependencies:
    ```bash
    flutter pub get
    ```
3.  Connect your device or use an emulator, and run the app:
    ```bash
    flutter run
    ```
    The app will now open and you can enter values for the soil and environmental parameters to receive pH predictions.

## Author

* [Christophe Gakwaya]