# Predicting Soil pH: A Machine Learning Approach

This project delivers a practical solution for estimating soil pH, a key factor in agriculture. I've built a predictive system combining a machine learning API and a user-friendly mobile app.

## Project Highlights

* **Goal:** To provide accessible soil pH predictions using machine learning.
* **Components:**
    * FastAPI-powered API for predictions (backend).
    * Flutter mobile app for easy user input (frontend).

## Model Development and Analysis

* **Use Case:** Agricultural soil pH prediction.
* **Data Source:** `cleaned_rwanda_crops_dataset.csv` (from Kaggle).
* **Data Insights:** I visualized feature relationships using correlation heatmaps and variable distributions to understand the data.
* **Model Selection:** I explored Linear Regression, Decision Trees, and Random Forest. Random Forest, with the lowest Mean Squared Error (MSE), was chosen as the best model and saved as `best_ph_model.joblib`. I also plotted the linear regression line of best fit.
* **Prediction Function:** A Python function is included to make predictions using the trained model.

## API for Predictions

* **Tech:** FastAPI.
* **Endpoint:** `/predict` (POST).
* **Features:**
    * Interactive documentation at: [https://ph-prediction-api.onrender.com/docs](https://ph-prediction-api.onrender.com/docs)
    * Cross-Origin Resource Sharing (CORS) is enabled.
    * Input data is validated using Pydantic.
    * `requirements.txt` is provided.
* **Deployment:** Hosted on Render.com.

## Mobile App for Input and Results

* **Features:**
    * Text fields for inputting soil data.
    * A "Predict" button to get results.
    * Clear display of predictions or error messages.

## Video Demo

* **Video Link:** [https://youtu.be/eCww5HfpBak](https://youtu.be/eCww5HfpBak)
* **Content:** The video showcases the app, the API via Swagger UI, and explains the model's performance and selection.

## Data Source

My model was trained on a Kaggle dataset with soil and environmental data. I preprocessed the data to ensure it was ready for machine learning.

## Live Links

* **API Endpoint:** [https://ph-prediction-api.onrender.com/predict](https://ph-prediction-api.onrender.com/predict)
* **Video Demo:** [https://youtu.be/eCww5HfpBak](https://youtu.be/eCww5HfpBak)

## Running the Mobile App

To run the app:

1.  Clone the repository:

    ```bash
    git clone [https://github.com/Gakwaya011/linear_regression_model.git](https://github.com/Gakwaya011/linear_regression_model.git)
    cd FlutterApp/
    ```

2.  Install Flutter dependencies:

    ```bash
    flutter pub get
    ```

3.  Run the app:

    ```bash
    flutter run
    ```

    You can now input soil data and receive pH predictions.

## Author

* Christophe Gakwaya
