--- deleteShippingOrdersFunction file ---

SET search_path TO Lab4;

DROP FUNCTION IF EXISTS deleteShippingOrdersFunction(INTEGER, DATE);

CREATE OR REPLACE FUNCTION deleteShippingOrdersFunction(
    targetRouteID INTEGER,
    cutoffDate DATE
)
RETURNS INTEGER AS $$
DECLARE
    deletedOrderCount INTEGER := 0;
BEGIN
    
    ------ Input Validation -------

    -- if route ID is not the ID of any freight route
    IF NOT EXISTS (
        SELECT 1
        FROM FreightRoute f
        WHERE
            targetRouteID = f.routeID
    ) THEN
        RETURN -1;
    END IF;

    -- if cuttoff date is NULL
    IF cutoffDate IS NULL THEN
        RETURN -1;
    END IF;

    --------- Delete Dependent Records (PackageDropoff) -----------

    DELETE FROM PackageDropoff
    WHERE orderID IN (
        SELECT orderID
        FROM ShippingOrder
        WHERE 
            targetRouteID = routeID
            AND orderDate <= cutoffDate
    );

    --------- Delete Target Orders & Count (ShippingOrder) -----------
    
    DELETE FROM ShippingOrder
    WHERE
        targetRouteID = routeID
        AND orderDate <= cutoffDate;

    
    GET DIAGNOSTICS deletedOrderCount = ROW_COUNT;
    RETURN deletedOrderCount;

END;
$$ LANGUAGE plpgsql;


------------------- (done) -----------------

