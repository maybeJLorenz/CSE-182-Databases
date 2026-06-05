#!/usr/bin/env python3
"""
CSE 182 Spring 2026 Lab4 starter file.

Students must implement the four functions below. The first argument of each
function is an open psycopg2 connection. Do not change the function names or
parameters.
"""

import os
import sys
import psycopg2


def countOrdersFromCenter(conn, centerCode: str):
    cursor = conn.cursor()
    
    try:
        cursor.execute(
            """
            SELECT 1
            FROM DistributionCenter d
            WHERE d.centerCode = %s
            """,
            (centerCode,)
        )

        result = cursor.fetchone()
        
        if result is None:
            return -1
        
        cursor.execute(
            """
            SELECT COUNT(s.orderID)
            FROM ShippingOrder s, FreightRoute f
            WHERE 
                s.routeID = f.routeID
                AND f.originCenter = %s
            """,
            (centerCode,)
        )

        count_result = cursor.fetchone()

        total_orders = count_result[0]

        return total_orders
    
    finally:
        cursor.close()


def processDelayedExpeditedOrders(conn, minDelayDays: int):
    if minDelayDays < 0:
        return -1
    
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            UPDATE ShippingOrder s
            SET
                priorityClass = 'D',
                shippingCost = shippingCost - (shippingCost * 0.2)
            FROM FreightRoute f
            WHERE
                s.routeID = f.routeID
                AND f.scheduledArrival IS NOT NULL
                AND f.actualArrival IS NOT NULL
                AND f.actualArrival > (f.scheduledArrival + %s * INTERVAL '1 day')
                AND s.priorityClass = 'X'
                AND s.shippingCost IS NOT NULL
            """,
            (minDelayDays,)
        )

        changed_rows = cursor.rowcount

        conn.commit()

        return changed_rows

    finally:
        cursor.close()
    


def increaseStaffCompensation(conn, minAssignments: int, minYearsExperience: int, increaseAmount: float):
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            SELECT increaseStaffCompensationFunction(%s, %s, %s);
            """,
            (minAssignments, minYearsExperience, increaseAmount)
        )

        result = cursor.fetchone()

        conn.commit()

        return result[0]

    finally:
        cursor.close()
    


def deleteShippingOrders(conn, routeID: int, cutoffDate: str):
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            SELECT deleteShippingOrdersFunction(%s, %s);
            """,
            (routeID, cutoffDate)
        )

        result = cursor.fetchone()

        conn.commit()

        return result[0]

    finally:
        cursor.close()


def connect_to_database(argv):
    user = argv[1] if len(argv) >= 2 else os.environ.get("PGUSER", "cse182")
    password = argv[2] if len(argv) >= 3 else os.environ.get("PGPASSWORD", "database4me")
    database = os.environ.get("PGDATABASE", user)

    kwargs = {"dbname": database, "user": user, "password": password}
    if os.environ.get("PGHOST"):
        kwargs["host"] = os.environ["PGHOST"]
    if os.environ.get("PGPORT"):
        kwargs["port"] = os.environ["PGPORT"]
    return psycopg2.connect(**kwargs)


def main(argv):
    try:
        conn = connect_to_database(argv)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)

    try:
        # There are other correct ways of writing all of these calls correctly in Python.

        # Perform tests of countOrdersFromCenter, as described in Lab4.
        # Print their outputs (including error outputs) here, not in countOrdersFromCenter.
        # You may use a Python method to help you do the printing.
        centers_to_test = ['NYC', 'RDU', 'SJC']
        
        for center in centers_to_test:
            result = countOrdersFromCenter(conn, center)
            
            if result >= 0:
                print(f"Number of orders originating from center {center} is {result}")
            else:
                print(f"Center {center} does not exists")
                
            print()
        
        # Perform tests of processDelayedExpeditedOrders, as described in Lab4.
        # Print their outputs (including error outputs) here, not in processDelayedExpeditedOrders.
        # You may use a Python method to help you do the printing.
        delays_to_test = [-1, 1, 10, 1]
        
        for delay in delays_to_test:
            result = processDelayedExpeditedOrders(conn, delay)
            
            if result >= 0:
                print(f"Number of delayed expedited orders processed for minimum delay {delay} is {result}")
            else:
                print(f"Delay {delay} is invalid.")
                
            print()
        
        # Perform tests of increaseStaffCompensation, as described in Lab4.
        # Print their outputs (including error outputs) here, not in increaseStaffCompensation.
        # You may use a Python method to help you do the printing.
        compensation_tests = [
            (3, 8, 100.0),
            (4, 15, 200.0),
            (-1, 5, 100.0),
            (2, -3, 100.0),
            (2, 5, 0.0)
        ]
        
        for min_assignments, min_years, inc_amount in compensation_tests:
            result = increaseStaffCompensation(conn, min_assignments, min_years, inc_amount)
            
            if result >= 0:
                print(f"Number of route staff assignment compensation values updated for minimum assignments {min_assignments}, minimum years {min_years}, and increase amount {inc_amount} is {result}")
            else:
                print(f"The compensation increase request was invalid for minimum assignments {min_assignments}, minimum years {min_years}, and increase amount {inc_amount}")
                
            print()

        # Perform tests of deleteShippingOrders, as described in Lab4.
        # Print their outputs (including error outputs) here, not in deleteShippingOrders.
        # You may use a Python method to help you do the printing.
        delete_tests = [
            (101, '2026-05-01'),
            (101, '2026-12-31'),
            (999, '2026-05-01'),
            (102, None),
            (108, '2026-01-01')
        ]
        
        for route_id, cutoff in delete_tests:
            result = deleteShippingOrders(conn, route_id, cutoff)
            
            if result >= 0:
                print(f"Number of shipping orders deleted for route {route_id} on or before cutoff date {cutoff} is {result}")
            else:
                print(f"The delete request is invalid for route {route_id} on or before cutoff date {cutoff}")
                
            print()

    finally:
        conn.close()


if __name__ == "__main__":
    main(sys.argv)

