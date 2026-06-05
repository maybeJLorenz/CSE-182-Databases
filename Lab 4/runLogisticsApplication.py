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
    # TODO: Replace the following line with your implementation.
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
    # TODO: Replace the following line with your implementation.
    raise NotImplementedError("processDelayedExpeditedOrders is not implemented")


def increaseStaffCompensation(conn, minAssignments: int, minYearsExperience: int, increaseAmount: float):
    # TODO: Replace the following line with your implementation.
    raise NotImplementedError("increaseStaffCompensation is not implemented")


def deleteShippingOrders(conn, routeID: int, cutoffDate: str):
    # TODO: Replace the following line with your implementation.
    raise NotImplementedError("deleteShippingOrders is not implemented")


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
        
        # TODO: Replace the following line with your implementation.
        raise NotImplementedError("main is not implemented")
        
        # Perform tests of processDelayedExpeditedOrders, as described in Lab4.
        # Print their outputs (including error outputs) here, not in processDelayedExpeditedOrders.
        # You may use a Python method to help you do the printing.

        # Perform tests of increaseStaffCompensation, as described in Lab4.
        # Print their outputs (including error outputs) here, not in increaseStaffCompensation.
        # You may use a Python method to help you do the printing.

        # Perform tests of deleteShippingOrders, as described in Lab4.
        # Print their outputs (including error outputs) here, not in deleteShippingOrders.
        # You may use a Python method to help you do the printing.

    finally:
        conn.close()


if __name__ == "__main__":
    main(sys.argv)

