from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
import joblib
import numpy as np
import uvicorn

app = FastAPI(title="pH Prediction API")

# CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#  a Pydantic Model for the input data.

class InputData(BaseModel):
    nitrogen: float = Field(..., description="Nitrogen level in the soil (ppm)", example=100.0)
    phosphorus: float = Field(..., description="Phosphorus level in the soil (ppm)", example=50.0)
    potassium: float = Field(..., description="Potassium level in the soil (ppm)", example=75.0)
    temperature: float = Field(..., description="Average soil temperature (°C)", example=25.0)
    humidity: float = Field(..., description="Average relative humidity (%)", example=60.0)
    rainfall: float = Field(..., description="Total rainfall (mm)", example=10.0)
    elevation: float = Field(..., description="Elevation above sea level (meters)", example=500.0)
    slope: float = Field(..., description="Slope of the terrain (degrees)", example=5.0)
    aspect: float = Field(..., description="Aspect of the terrain (degrees, 0-360)", example=180.0)
    water_holding_capacity: float = Field(..., description="Water holding capacity of the soil (%)", example=30.0)
    wind_speed: float = Field(..., description="Average wind speed (m/s)", example=10.0, ge=0, le=50) # Added range constraints
    solar_radiation: float = Field(..., description="Average solar radiation (W/m²)", example=200.0)
    ec: float = Field(..., description="Electrical conductivity of the soil (dS/m)", example=0.5)
    zn: float = Field(..., description="Zinc level in the soil (ppm)", example=2.0)
    soil_texture_Loam: float = Field(..., description="Soil texture Loam (1 if yes, 0 if no)", example=0.0)
    soil_texture_Sandy: float = Field(..., description="Soil texture Sandy (1 if yes, 0 if no)", example=1.0)
    soil_texture_Sandy_Clay: float = Field(..., description="Soil texture Sandy Clay (1 if yes, 0 if no)", example=0.0)
    soil_texture_Sandy_Loam: float = Field(..., description="Soil texture Sandy Loam (1 if yes, 0 if no)", example=0.0)

try:
    model_path = "summative/linear_regression/best_ph_model.joblib"
    scaler_path = "summative/linear_regression/scaler.joblib"

    print(f"Model Path: {model_path}")
    print(f"Scaler Path: {scaler_path}")

    model = joblib.load(model_path)
    scaler = joblib.load(scaler_path)
except Exception as e:
    raise RuntimeError(f"Error loading model or scaler: {e}")

# Create a Pydantic Model for the prediction return.
class PredictionResponse(BaseModel):
    prediction: float = Field(..., description="Predicted pH value of the soil.")

@app.post("/predict", response_model=PredictionResponse, summary="Predict soil pH based on environmental and soil conditions.")
async def predict(data: InputData):
    """
    Predicts the pH value of soil using a pre-trained linear regression model.

    This endpoint takes environmental and soil data as input and returns the predicted pH value.

    Args:
        data: Input data containing soil and environmental parameters.

    Returns:
        A JSON object with the predicted pH value.

    Raises:
        HTTPException: If an error occurs during prediction.
    """
    try:
        input_array = np.array([
            data.nitrogen, data.phosphorus, data.potassium, data.temperature,
            data.humidity, data.rainfall, data.elevation, data.slope, data.aspect,
            data.water_holding_capacity, data.wind_speed, data.solar_radiation,
            data.ec, data.zn, data.soil_texture_Loam, data.soil_texture_Sandy,
            data.soil_texture_Sandy_Clay, data.soil_texture_Sandy_Loam
        ]).reshape(1, -1)

        scaled_input = scaler.transform(input_array)
        prediction = model.predict(scaled_input)[0]
        return {"prediction": float(prediction)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)