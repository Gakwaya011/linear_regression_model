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
    nitrogen: float = Field(..., description="Nitrogen level", example=100.0)
    phosphorus: float = Field(..., description="Phosphorus level", example=50.0)
    potassium: float = Field(..., description="Potassium level", example=75.0)
    temperature: float = Field(..., description="Temperature", example=25.0)
    humidity: float = Field(..., description="Humidity", example=60.0)
    rainfall: float = Field(..., description="Rainfall", example=10.0)
    elevation: float = Field(..., description="Elevation", example=500.0)
    slope: float = Field(..., description="Slope", example=5.0)
    aspect: float = Field(..., description="Aspect", example=180.0)
    water_holding_capacity: float = Field(..., description="Water holding capacity", example=30.0)
    wind_speed: float = Field(..., description="Wind speed", example=10.0, ge=0, le=50) # Added range constraints
    solar_radiation: float = Field(..., description="Solar radiation", example=200.0)
    ec: float = Field(..., description="Electrical conductivity", example=0.5)
    zn: float = Field(..., description="Zinc level", example=2.0)
    soil_texture_Loam: float = Field(..., description="Soil texture Loam (1 if yes, 0 if no)", example=0.0)
    soil_texture_Sandy: float = Field(..., description="Soil texture Sandy (1 if yes, 0 if no)", example=1.0)
    soil_texture_Sandy_Clay: float = Field(..., description="Soil texture Sandy Clay (1 if yes, 0 if no)", example=0.0)
    soil_texture_Sandy_Loam: float = Field(..., description="Soil texture Sandy Loam (1 if yes, 0 if no)", example=0.0)


try:
    model_path = "../linear_regression/best_ph_model.joblib"
    scaler_path = "../linear_regression/scaler.joblib"

    print(f"Model Path: {model_path}")
    print(f"Scaler Path: {scaler_path}")

    model = joblib.load(model_path)
    scaler = joblib.load(scaler_path)
except Exception as e:
    raise RuntimeError(f"Error loading model or scaler: {e}")

# Create a Pydantic Model for the prediction return.
class PredictionResponse(BaseModel):
    prediction: float

@app.post("/predict", response_model=PredictionResponse) #Add the response model here.
async def predict(data: InputData):
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