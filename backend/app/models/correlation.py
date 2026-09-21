from sqlalchemy import Column, Integer, String, ForeignKey
from app.core.database import Base

class Correlation(Base):
    __tablename__ = "correlations"

    id = Column(Integer, primary_key=True, index=True)

    source_ioc = Column(Integer, ForeignKey("indicators.id"))
    target_ioc = Column(Integer, ForeignKey("indicators.id"))

    relation_type = Column(String, nullable=False)
    score = Column(Integer, default=0)
