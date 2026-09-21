from app.services.correlation import calculate_correlation


def calculate_risk_score(current, all_iocs):
    detection_score = current.detection_score or 0
    max_correlation_score = 0

    for other in all_iocs:
        if other.id == current.id:
            continue

        result = calculate_correlation(current, other)
        correlation_score = result.get("score", 0)

        if correlation_score > max_correlation_score:
            max_correlation_score = correlation_score

    risk_score = min(
        detection_score + max_correlation_score,
        100
    )

    return {
        "detection_score": detection_score,
        "correlation_score": max_correlation_score,
        "risk_score": risk_score
    }
