-- CSE 182 Spring 2026 Lab4
-- Example stored function.
--
-- This is NOT one of the required Lab4 functions. It is only a small example
-- showing the usual PL/pgSQL pattern: validate, update, count changed rows,
-- and return an integer.

SET search_path TO Lab4;

DROP FUNCTION IF EXISTS exampleReduceCenterDelay(CHAR(3), INTEGER);

CREATE OR REPLACE FUNCTION exampleReduceCenterDelay(
    inputCenterCode CHAR(3),
    minutesToSubtract INTEGER
)
RETURNS INTEGER AS $$
DECLARE
    changedRows INTEGER;
BEGIN
    IF inputCenterCode IS NULL THEN
        RETURN -1;
    END IF;

    IF minutesToSubtract IS NULL OR minutesToSubtract <= 0 THEN
        RETURN -1;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM DistributionCenter
        WHERE centerCode = inputCenterCode
    ) THEN
        RETURN -1;
    END IF;

    UPDATE DistributionCenter
    SET avgProcessingDelayMins = GREATEST(avgProcessingDelayMins - minutesToSubtract, 0)
    WHERE centerCode = inputCenterCode;

    GET DIAGNOSTICS changedRows = ROW_COUNT;
    RETURN changedRows;
END;
$$ LANGUAGE plpgsql;
