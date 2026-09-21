from app.core.database import SessionLocal
from app.models.indicator import Indicator
from app.services.risk import calculate_risk_score

db = SessionLocal()

try:
    iocs = db.query(Indicator).all()

    print(f"Found {len(iocs)} IOCs")

    for ioc in iocs:
        risk = calculate_risk_score(ioc, iocs)

        ioc.correlation_score = risk["correlation_score"]
        ioc.risk_score = risk["risk_score"]

        print(
            f"IOC #{ioc.id}: "
            f"Detection={risk['detection_score']} | "
            f"Correlation={risk['correlation_score']} | "
            f"Risk={risk['risk_score']}"
        )

    db.commit()
    print("Risk recalculation completed successfully.")

finally:
    db.close()
