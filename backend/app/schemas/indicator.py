from pydantic import BaseModel

class IndicatorCreate(BaseModel):
    value: str
    type: str
    severity_score: int = 50
    confidence: int = 80

class IndicatorResponse(IndicatorCreate):
    id: int
    status: str

    class Config:
        from_attributes = True
