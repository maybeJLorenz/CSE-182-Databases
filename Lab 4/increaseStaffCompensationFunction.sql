---- increaseStaffCompensationFunction file ----


SET search_path TO Lab4;

DROP FUNCTION IF EXISTS increaseStaffCompensationFunction(INTEGER, INTEGER, NUMERIC);

CREATE OR REPLACE FUNCTION increaseStaffCompensationFunction(
    minAssignments INTEGER,
    minYearsExperience INTEGER,
    increaseAmount NUMERIC
)
RETURNS INTEGER AS $$
DECLARE
    changedRows INTEGER := 0;
BEGIN
--------- Input validations ------------
    IF minAssignments < 0 OR minYearsExperience < 0 THEN
        RETURN -1;
    END IF;

    IF increaseAmount <= 0 THEN
        RETURN -1;
    END IF;


--------- UPDATE Implementation ------------

    UPDATE RouteStaffAssignment
    SET compensation = compensation + increaseAmount
    WHERE staffID IN (
        SELECT l.staffID
        FROM LogisticsStaff l, RouteStaffAssignment r
        WHERE
            l.staffID = r.staffID
            AND l.yearsExperience >= minYearsExperience
        GROUP BY l.staffID
        HAVING COUNT(r.routeID) >= minAssignments
    );

    GET DIAGNOSTICS changedRows = ROW_COUNT;

    RETURN changedRows;
END;
$$ LANGUAGE plpgsql;


------------ (done) ---------------