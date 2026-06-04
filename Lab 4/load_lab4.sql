SET search_path TO Lab4;

-- Client(clientID, clientName, email, accountCreationDate, premiumMember)
COPY Client FROM stdin USING DELIMITERS '|';
1|Acme Corp|contact@acme.com|2020-05-12|Y
2|Global Goods|info@globalgoods.com|2021-08-23|N
3|Tech Parts Inc|sales@techparts.com|2019-11-05|Y
4|Fast Retail|hello@fastretail.com|2022-01-15|N
5|Fresh Foods|logistics@freshfoods.com|2020-09-30|Y
6|Auto Spares|parts@autospares.com|2023-03-14|N
7|MediSupplies|shipping@medisupplies.com|2018-07-22|Y
8|Home Essentials|orders@homeessentials.com|2021-12-01|N
9|Rapid Freight|contact@rapid.com|2023-01-10|Y
10|Blue Harbor Books|shipping@blueharbor.example|2024-02-18|N
11|Northwind Labs|logistics@northwind.example|2024-06-03|Y
12|Summit Outfitters|freight@summit.example|2025-01-09|N
13|Pacific Studio Supply|dispatch@pacificstudio.example|2024-10-11|N
14|Triangle Medical Kits|orders@trianglemed.example|2023-09-19|Y
15|Canyon Bike Works|freight@canyonbike.example|2025-02-03|N
\.

-- DistributionCenter(centerCode, city, country, numLoadingDocks, avgProcessingDelayMins)
COPY DistributionCenter FROM stdin USING DELIMITERS '|';
NYC|New York|USA|45|120
LAX|Los Angeles|USA|50|145
CHI|Chicago|USA|35|90
HOU|Houston|USA|40|110
ATL|Atlanta|USA|60|180
DFW|Dallas|USA|55|130
MIA|Miami|USA|30|100
SEA|Seattle|USA|25|85
DEN|Denver|USA|5|100
RDU|Raleigh|USA|5|90
BOS|Boston|USA|18|75
PHX|Phoenix|USA|22|105
PDX|Portland|USA|16|80
SLC|Salt Lake City|USA|14|95
\.

-- FreightRoute(routeID, originCenter, destCenter, scheduledDeparture, scheduledArrival, actualDeparture, actualArrival, vehicleType)
COPY FreightRoute FROM stdin USING DELIMITERS '|';
101|NYC|LAX|2026-04-20 08:00:00|2026-04-22 11:00:00|2026-04-20 08:30:00|2026-04-22 11:15:00|Heavy Truck
102|LAX|CHI|2026-04-21 09:00:00|2026-04-24 13:30:00|2026-04-21 09:15:00|2026-04-24 13:40:00|Freight Train
103|CHI|HOU|2026-04-22 07:30:00|2026-04-25 10:00:00|2026-04-22 07:35:00|2026-04-26 10:00:00|Heavy Truck
104|HOU|ATL|2026-04-23 14:00:00|2026-04-25 10:00:00|2026-04-23 14:10:00|2026-04-27 10:00:00|Cargo Plane
105|ATL|DFW|2026-04-24 12:00:00|2026-04-26 13:45:00|2026-04-24 12:05:00|2026-04-28 14:00:00|Heavy Truck
106|DFW|MIA|2026-04-25 16:00:00|2026-04-28 17:30:00|2026-04-25 16:20:00|2026-04-28 17:40:00|Freight Train
107|MIA|SEA|2026-04-26 10:00:00|2026-04-29 18:00:00|2026-04-26 10:05:00|2026-05-01 18:01:00|Cargo Plane
108|SEA|NYC|2026-04-27 07:00:00|2026-04-30 08:00:00|2026-04-27 07:10:00|2026-04-30 08:15:00|Freight Train
109|DEN|LAX|2026-04-28 07:00:00|2026-04-30 09:00:00|2026-04-28 07:15:00|2026-05-01 09:01:00|Heavy Truck
110|BOS|PHX|2026-04-29 06:00:00|2026-05-04 09:00:00|2026-04-29 06:30:00|\N|Cargo Ship
111|PHX|BOS|2026-05-02 06:00:00|2026-05-05 09:00:00|2026-05-02 06:20:00|2026-05-05 09:05:00|Cargo Ship
112|RDU|ATL|2026-05-03 06:00:00|2026-05-04 10:00:00|2026-05-03 06:05:00|2026-05-04 10:10:00|Heavy Truck
113|BOS|DEN|2026-05-05 08:00:00|2026-05-10 08:00:00|2026-05-05 08:30:00|2026-05-22 08:30:00|Cargo Plane
114|PDX|SLC|2026-05-06 07:00:00|2026-05-08 07:00:00|2026-05-06 07:05:00|2026-05-09 07:00:00|Heavy Truck
115|SLC|SEA|2026-05-07 13:00:00|2026-05-09 13:00:00|2026-05-07 13:10:00|2026-05-12 13:15:00|Freight Train
\.

-- LogisticsStaff(staffID, staffName, staffRole, yearsExperience)
COPY LogisticsStaff FROM stdin USING DELIMITERS '|';
1|Marcus Vance|Lead Driver|15
2|Sarah Jenkins|Co-Driver|10
3|Omar Tariq|Loadmaster|7
4|Diana Prince|Pilot|20
5|Lucas Wright|Warehouse Tech|5
6|Elena Rostova|Dispatcher|12
7|Kenji Moto|Freight Engineer|8
8|Alicia Keys|Pilot|18
9|John Tracker|Delivery Driver|4
10|Maria Gonzales|Delivery Driver|6
11|David Kim|Delivery Driver|3
12|Lisa Ray|Delivery Driver|8
13|Sophia Kim|Lead Driver|7
14|Grace Hopper|Route Analyst|14
\.

-- ShippingOrder(orderID, clientID, routeID, orderDate, priorityClass, shippingCost, paymentMethod)
-- priorityClass: 'S' (Standard), 'E' (Express), 'X' (eXpedited), 'D' (Delayed)
COPY ShippingOrder FROM stdin USING DELIMITERS '|';
201|1|101|2026-04-15|S|2500.00|WireTransfer
202|2|102|2026-04-18|E|7500.00|CorporateCard
203|3|103|2026-04-20|S|1800.00|ACH
204|4|104|2026-04-22|X|12000.00|WireTransfer
205|5|105|2026-04-25|S|2200.00|Visa
206|6|106|2026-04-26|E|6800.00|ACH
207|7|107|2026-04-28|X|15000.00|WireTransfer
208|8|108|2026-05-20|S|4500.00|CorporateCard
209|9|109|2026-05-01|D|500.00|WireTransfer
210|8|101|2026-05-02|S|3000.00|Visa
211|1|109|2026-05-03|X|8000.00|\N
212|3|101|2026-04-29|X|9000.00|ACH
213|10|103|2026-05-04|X|11000.00|CorporateCard
214|11|110|2026-05-05|X|7000.00|WireTransfer
215|12|105|2026-05-06|X|\N|Visa
216|6|111|2026-05-07|S|6400.00|ACH
217|7|106|2026-05-08|E|7200.00|WireTransfer
218|13|112|2026-05-04|S|1550.00|CorporateCard
219|14|112|2026-05-04|X|2600.00|ACH
220|15|112|2026-05-05|E|3100.00|WireTransfer
221|2|113|2026-05-06|X|9800.00|CorporateCard
222|5|113|2026-05-07|X|12500.00|WireTransfer
223|6|101|2026-05-01|E|4100.00|ACH
224|9|101|2026-11-15|S|5400.00|CorporateCard
225|10|114|2026-05-07|X|4700.00|Visa
226|11|115|2026-05-08|X|\N|WireTransfer
\.

-- PackageDropoff(orderID, staffID, dropoffTime, packageCount, storageBinNumber)
COPY PackageDropoff FROM stdin USING DELIMITERS '|';
201|1|2026-04-15 12:30:00|6|B-12A
201|9|2026-04-15 13:00:00|6|B-12B
202|2|2026-04-18 09:45:00|45|C-03C
203|10|2026-04-20 11:50:00|8|A-18F
204|11|2026-04-22 15:30:00|2|H-01A
205|12|2026-04-25 10:20:00|15|B-14B
205|1|2026-04-25 10:45:00|10|B-14C
206|2|2026-04-26 14:50:00|60|D-06D
207|9|2026-04-28 08:15:00|5|C-20C
208|10|2026-05-20 05:30:00|75|F-07F
208|11|2026-05-20 05:50:00|75|F-07G
210|5|2026-05-02 08:30:00|11|B-15A
211|1|2026-05-03 09:00:00|5|X-99Z
212|3|2026-04-29 09:30:00|18|C-11A
213|6|2026-05-04 16:00:00|12|G-02B
214|4|2026-05-05 17:00:00|20|S-10C
215|5|2026-05-06 12:00:00|9|B-16D
216|14|2026-05-07 12:30:00|30|P-01A
218|12|2026-05-04 11:05:00|7|R-01A
219|14|2026-05-04 11:15:00|4|R-01B
220|12|2026-05-05 09:45:00|10|R-02A
221|8|2026-05-06 14:30:00|16|BOS-8
222|14|2026-05-07 15:10:00|21|BOS-9
223|2|2026-05-01 10:00:00|13|N-05A
224|1|2026-11-15 12:00:00|9|N-11B
225|8|2026-05-07 10:20:00|6|P-03A
226|6|2026-05-08 13:45:00|15|S-08C
\.

-- RouteStaffAssignment(routeID, staffID, compensation)
COPY RouteStaffAssignment FROM stdin USING DELIMITERS '|';
101|1|1500.00
101|2|1000.00
101|3|500.00
101|13|1200.00
102|7|1600.00
102|6|1100.00
102|5|550.00
103|1|1500.00
103|3|600.00
103|13|1200.00
104|4|2550.00
104|9|1000.00
105|1|1600.00
105|5|550.00
106|7|1500.00
106|6|1100.00
107|8|2550.00
107|3|500.00
108|7|1000.00
108|5|600.00
109|13|1500.00
109|1|1000.00
110|4|2700.00
110|11|1200.00
111|8|2600.00
111|14|1300.00
112|12|900.00
112|14|1250.00
113|8|2700.00
113|14|1350.00
113|6|1200.00
114|8|1900.00
114|14|1400.00
114|2|1150.00
115|6|1250.00
115|2|1175.00
\.
