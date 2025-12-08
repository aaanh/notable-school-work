/*
 * Copyright (c) 2025 Anh Hoang Nguyen <anhnguyen@aaanh.com>
 * 
 * All rights reserved. All materials and contents in this source
 * file are made available only for school work grading purposes
 * 
 * Author: Anh Hoang Nguyen - https://anh.to/gh - anhnguyen@aaanh.com
 */

-- START SPOOL CONFIG
COLUMN tstamp NEW_VALUE ts
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD_HH24MISS') tstamp FROM dual;

SET LINESIZE 200
spool "01_seed_output_&ts..log";
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS AM') from dual;
-- END SPOOL CONFIG

set serveroutput on


-- branches
insert into branches (id, branch_name) values (1, 'Army');
insert into branches (id, branch_name) values (2, 'Navy');
insert into branches (id, branch_name) values (3, 'Air Force');
insert into branches (id, branch_name) values (4, 'Marine Corps');
insert into branches (id, branch_name) values (5, 'Coast Guard');
insert into branches (id, branch_name) values (6, 'Space Force');

-- commands
insert into commands (id, command_name) values (1, 'CENTCOM');
insert into commands (id, command_name) values (2, 'SOCOM');
insert into commands (id, command_name) values (3, 'NORAD');
insert into commands (id, command_name) values (4, 'NATO');
insert into commands (id, command_name) values (5, 'AFRICOM');
insert into commands (id, command_name) values (6, 'EUCOM');
insert into commands (id, command_name) values (7, 'NORTHCOM');
insert into commands (id, command_name) values (8, 'CYBERCOM');
insert into commands (id, command_name) values (9, 'SPACECOM');

-- operation bases
insert into op_bases (id, op_base_name, op_location) values (1, 'Fort Bragg', 'North Carolina');
insert into op_bases (id, op_base_name, op_location) values (2, 'Fort Hood', 'Texas');
insert into op_bases (id, op_base_name, op_location) values (3, 'Fort Benning', 'Georgia');
insert into op_bases (id, op_base_name, op_location) values (4, 'JB Lewis-McChord', 'Washington');
insert into op_bases (id, op_base_name, op_location) values (5, 'Camp Pendleton', 'California');
insert into op_bases (id, op_base_name, op_location) values (6, 'Fort Campbell', 'Kentucky');
insert into op_bases (id, op_base_name, op_location) values (7, 'Camp Lejeune', 'North Carolina');
insert into op_bases (id, op_base_name, op_location) values (8, 'Eglin AFB', 'Florida');
insert into op_bases (id, op_base_name, op_location) values (9, 'Norfolk Naval Station', 'Virginia');
insert into op_bases (id, op_base_name, op_location) values (10, 'Fort Bliss', 'Texas');

insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (1, 'John', 'Smith', 'Officer', 'Colonel', 1, 1, 1, 1, null, 15, 3, 85000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (2, 'Sarah', 'Johnson', 'Enlisted', 'Sergeant', 1, 1, 1, 1, 1, 8, 2, 45000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (3, 'Michael', 'Davis', 'Officer', 'Captain', 2, 2, 9, 1, null, 12, 4, 75000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (4, 'Lisa', 'Wilson', 'Enlisted', 'Staff Sergeant', 2, 2, 9, 1, 3, 6, 1, 42000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (5, 'Robert', 'Brown', 'Officer', 'Major', 3, 3, 8, 1, null, 10, 2, 78000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (6, 'Jennifer', 'Taylor', 'Enlisted', 'Staff Sergeant', 4, 2, 5, 1, null, 7, 3, 48000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (7, 'Emily', 'Clark', 'Officer', 'Lieutenant', 1, 1, 1, 1, 1, 6, 1, 67000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (8, 'James', 'Miller', 'Enlisted', 'Corporal', 1, 1, 2, 1, 2, 4, 0, 39000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (9, 'Amanda', 'Garcia', 'Officer', 'Lieutenant Colonel', 2, 2, 9, 1, null, 14, 5, 82000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (10, 'David', 'Martinez', 'Enlisted', 'Private', 2, 2, 9, 1, 9, 3, 2, 40000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (11, 'Sophia', 'Rodriguez', 'Officer', 'Captain', 3, 3, 8, 1, 5, 9, 4, 74000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (12, 'Matthew', 'Lee', 'Enlisted', 'Sergeant', 3, 3, 8, 1, 11, 7, 3, 46000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (13, 'Olivia', 'Walker', 'Officer', 'Major', 4, 2, 5, 1, null, 13, 6, 81000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (14, 'Daniel', 'Hall', 'Enlisted', 'Corporal', 4, 2, 5, 1, 13, 5, 1, 42000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (15, 'Isabella', 'Allen', 'Officer', 'Colonel', 5, 5, 10, 1, null, 20, 7, 90000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (16, 'Ethan', 'Young', 'Enlisted', 'Staff Sergeant', 5, 5, 10, 1, 15, 8, 3, 47000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (17, 'Riley', 'Johnson', 'Enlisted', 'Private First Class', 2, 3, 4, 1, null, 10, 6, 60000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (18, 'Morgan', 'Davis', 'Officer', 'Major', 4, 6, 5, 1, null, 18, 4, 76000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (19, 'Avery', 'Williams', 'Enlisted', 'Sergeant', 1, 1, 7, 1, 18, 3, 5, 46000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (20, 'Drew', 'Jones', 'Enlisted', 'Private First Class', 1, 3, 8, 1, 18, 12, 6, 64000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (21, 'Taylor', 'Johnson', 'Officer', 'Lieutenant Colonel', 6, 3, 10, 1, null, 19, 5, 78000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (22, 'Avery', 'Johnson', 'Enlisted', 'Sergeant First Class', 5, 1, 5, 1, 21, 10, 2, 60000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (23, 'Morgan', 'Taylor', 'Enlisted', 'First Sergeant', 1, 4, 5, 1, 21, 4, 5, 48000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (24, 'Avery', 'Taylor', 'Officer', 'Major General', 6, 7, 9, 1, null, 19, 0, 78000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (25, 'Morgan', 'Johnson', 'Enlisted', 'Sergeant Major', 1, 4, 5, 1, 21, 2, 3, 44000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (26, 'Drew', 'Moore', 'Officer', 'Colonel', 4, 1, 6, 1, null, 8, 7, 56000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (27, 'Morgan', 'Jones', 'Enlisted', 'First Sergeant', 1, 5, 10, 1, 21, 8, 1, 56000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (28, 'Drew', 'Miller', 'Officer', 'First Lieutenant', 1, 4, 9, 1, null, 17, 6, 74000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (29, 'Drew', 'Jones', 'Enlisted', 'Private', 6, 5, 9, 1, 21, 9, 0, 58000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (30, 'Taylor', 'Moore', 'Officer', 'Second Lieutenant', 4, 8, 10, 1, null, 5, 5, 50000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (31, 'Jamie', 'Moore', 'Officer', 'Second Lieutenant', 4, 4, 10, 1, null, 15, 2, 70000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (32, 'Taylor', 'Williams', 'Enlisted', 'Private First Class', 3, 7, 8, 1, 26, 11, 7, 62000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (33, 'Jordan', 'Johnson', 'Officer', 'Colonel', 3, 7, 9, 1, null, 5, 2, 50000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (34, 'Alex', 'Moore', 'Enlisted', 'Sergeant First Class', 5, 4, 2, 1, 28, 4, 3, 48000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (35, 'Avery', 'Moore', 'Officer', 'Major General', 6, 9, 2, 1, null, 13, 0, 66000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (36, 'Avery', 'Jones', 'Enlisted', 'Corporal', 6, 5, 3, 1, 24, 10, 3, 60000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (37, 'Casey', 'Brown', 'Enlisted', 'Specialist', 1, 2, 4, 1, 1, 5, 2, 50000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (38, 'Riley', 'Davis', 'Officer', 'Brigadier General', 2, 1, 9, 1, null, 25, 8, 95000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (39, 'Morgan', 'Wilson', 'Officer', 'Lieutenant General', 3, 3, 8, 1, null, 28, 9, 105000.00);
insert into personnel (id, first_name, last_name, personnel_type, service_rank, branch_id, command_id, op_base_id, is_active, commanding_officer_id, service_years, deployed, salary) values (40, 'Alex', 'Taylor', 'Officer', 'General', 1, 1, 1, 1, null, 30, 10, 120000.00);

-- vehicles

insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (1, 'M1A2-001', 1, 1, 1, 1, 1, 5, 2, 'combat', 6500000.00, 150000.00, 325000.00, 50000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (2, 'HMMWV-002', 1, 1, 1, 1, 2, 8, 3, 'transport', 220000.00, 8000.00, 22000.00, 5000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (3, 'DDG-003', 2, 2, 9, 1, 3, 12, 4, 'combat', 1800000000.00, 25000000.00, 60000000.00, 2000000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (4, 'F35A-004', 3, 3, 8, 1, 5, 3, 1, 'combat', 80000000.00, 4000000.00, 8000000.00, 500000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (5, 'LAV-005', 4, 2, 5, 1, 6, 6, 2, 'transport', 1200000.00, 45000.00, 120000.00, 15000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (6, 'M2A3-006', 1, 1, 2, 1, 7, 4, 2, 'combat', 5600000.00, 140000.00, 280000.00, 45000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (7, 'HMMWV-007', 1, 1, 2, 1, 8, 6, 1, 'transport', 210000.00, 7500.00, 21000.00, 4800.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (8, 'LHD-008', 2, 2, 9, 1, 9, 15, 6, 'combat', 2400000000.00, 28000000.00, 72000000.00, 2500000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (9, 'F22-009', 3, 3, 8, 1, 11, 5, 2, 'combat', 90000000.00, 4200000.00, 9000000.00, 520000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (10, 'LAV-010', 4, 2, 5, 1, 12, 7, 3, 'transport', 1250000.00, 48000.00, 125000.00, 17000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (11, 'CG-011', 5, 5, 10, 1, 15, 9, 4, 'patrol', 45000000.00, 1200000.00, 4000000.00, 300000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (12, 'P-012', 6, 9, 6, 1, 13, 2, 1, 'recon', 12000000.00, 350000.00, 1200000.00, 80000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (13, 'SUV-013', 1, 1, 3, 1, 14, 3, 1, 'transport', 30000.00, 2000.00, 3000.00, 500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (14, 'Drone-014', 6, 9, 6, 1, 16, 1, 1, 'recon', 1500000.00, 70000.00, 150000.00, 20000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (15, 'F18-015', 3, 3, 8, 1, 11, 8, 5, 'combat', 72000000.00, 3500000.00, 7200000.00, 400000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (16, 'SKU-016', 2, 7, 2, 1, 19, 9, 5, 'transport', 900000.00, 2000.00, 90000.00, 5000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (17, 'SKU-017', 2, 7, 2, 1, 19, 9, 5, 'transport', 900000.00, 2000.00, 90000.00, 5000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (18, 'SKU-018', 2, 2, 2, 1, 6, 1, 3, 'combat', 950000.00, 2500.00, 95000.00, 5500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (19, 'SKU-019', 5, 6, 6, 1, 13, 13, 4, 'recon', 1000000.00, 3000.00, 100000.00, 6000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (20, 'SKU-020', 4, 5, 10, 1, 13, 8, 6, 'transport', 1050000.00, 3500.00, 105000.00, 6500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (21, 'SKU-021', 3, 2, 6, 1, 7, 13, 1, 'recon', 1100000.00, 4000.00, 110000.00, 7000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (22, 'SKU-022', 2, 5, 3, 1, 19, 1, 4, 'transport', 1150000.00, 4500.00, 115000.00, 7500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (23, 'SKU-023', 5, 4, 5, 1, 19, 15, 1, 'patrol', 1200000.00, 5000.00, 120000.00, 8000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (24, 'SKU-024', 1, 3, 8, 1, 4, 11, 3, 'transport', 1250000.00, 5500.00, 125000.00, 8500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (25, 'SKU-025', 6, 3, 9, 1, 11, 9, 1, 'recon', 1300000.00, 6000.00, 130000.00, 9000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (26, 'SKU-026', 1, 4, 6, 1, 17, 3, 6, 'patrol', 1350000.00, 6500.00, 135000.00, 9500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (27, 'SKU-027', 1, 7, 2, 1, 4, 3, 3, 'patrol', 1400000.00, 7000.00, 140000.00, 10000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (28, 'SKU-028', 6, 3, 4, 1, 20, 8, 3, 'combat', 1450000.00, 7500.00, 145000.00, 10500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (29, 'SKU-029', 3, 2, 1, 1, 9, 1, 2, 'recon', 1500000.00, 8000.00, 150000.00, 11000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (30, 'SKU-030', 3, 3, 7, 1, 13, 14, 0, 'combat', 1550000.00, 8500.00, 155000.00, 11500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (31, 'SKU-031', 6, 3, 4, 1, 11, 11, 0, 'combat', 1600000.00, 9000.00, 160000.00, 12000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (32, 'SKU-032', 4, 9, 10, 1, 20, 5, 3, 'patrol', 1650000.00, 9500.00, 165000.00, 12500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (33, 'SKU-033', 1, 8, 6, 1, 5, 9, 2, 'combat', 1700000.00, 10000.00, 170000.00, 13000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (34, 'SKU-034', 5, 2, 1, 1, 20, 8, 5, 'transport', 1750000.00, 10500.00, 175000.00, 13500.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (35, 'SKU-035', 5, 2, 8, 1, 19, 12, 3, 'patrol', 1800000.00, 11000.00, 180000.00, 14000.00);
insert into vehicles (id, sku, branch_id, command_id, op_base_id, is_active, responsible_personnel_id, service_years, deployed, purpose, purchase_cost, maintenance_cost, yearly_depreciation, deployment_cost) values (36, 'SKU-036', 3, 2, 3, 1, 9, 7, 3, 'transport', 1850000.00, 11500.00, 185000.00, 14500.00);

-- deployments

insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (1, 1, 1, 1, 1, 1);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (2, 1, 1, 2, 2, 1);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (3, 2, 2, 3, 3, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (4, 3, 3, 4, 5, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (5, 4, 2, 5, 6, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (6, 1, 1, 6, 7, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (7, 1, 1, 7, 8, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (8, 2, 2, 8, 9, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (9, 3, 3, 9, 11, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (10, 4, 2, 10, 12, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (11, 1, 1, 1, 2, 1);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (12, 1, 1, 2, 1, 1);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (13, 2, 2, 3, 4, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (14, 2, 2, 4, 3, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (15, 3, 3, 5, 6, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (16, 3, 3, 6, 5, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (17, 4, 2, 7, 10, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (18, 4, 2, 8, 9, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (19, 5, 5, 9, 16, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (20, 5, 5, 10, 15, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (21, 6, 9, 11, 13, 6);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (22, 6, 9, 12, 14, 6);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (23, 1, 1, 13, 7, 3);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (24, 1, 1, 14, 8, 3);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (25, 3, 3, 15, 11, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (26, 3, 3, 1, 12, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (27, 2, 3, 17, 17, 4);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (28, 2, 3, 18, 17, 4);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (29, 4, 6, 18, 18, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (30, 4, 6, 19, 18, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (31, 1, 1, 19, 19, 7);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (32, 1, 1, 20, 19, 7);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (33, 1, 3, 20, 20, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (34, 1, 3, 21, 20, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (35, 6, 3, 21, 21, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (36, 6, 3, 22, 21, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (37, 5, 1, 22, 22, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (38, 5, 1, 23, 22, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (39, 1, 4, 23, 23, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (40, 1, 4, 24, 23, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (41, 6, 7, 24, 24, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (42, 6, 7, 25, 24, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (43, 1, 4, 25, 25, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (44, 1, 4, 26, 25, 5);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (45, 4, 1, 26, 26, 6);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (46, 4, 1, 27, 26, 6);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (47, 1, 5, 27, 27, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (48, 1, 5, 28, 27, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (49, 1, 4, 28, 28, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (50, 1, 4, 29, 28, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (51, 6, 5, 29, 29, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (52, 6, 5, 30, 29, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (53, 4, 8, 30, 30, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (54, 4, 8, 31, 30, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (55, 4, 4, 31, 31, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (56, 4, 4, 32, 31, 10);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (57, 3, 7, 32, 32, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (58, 3, 7, 33, 32, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (59, 3, 7, 33, 33, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (60, 3, 7, 34, 33, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (61, 5, 4, 34, 34, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (62, 5, 4, 35, 34, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (63, 6, 9, 35, 35, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (64, 6, 9, 36, 35, 2);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (65, 6, 5, 36, 36, 3);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (66, 6, 5, 17, 36, 3);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (67, 1, 2, 1, 37, 4);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (68, 1, 2, 2, 37, 4);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (69, 2, 1, 3, 38, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (70, 2, 1, 8, 38, 9);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (71, 3, 3, 4, 39, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (72, 3, 3, 9, 39, 8);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (73, 1, 1, 6, 40, 1);
insert into deployments (id, branch_id, command_id, vehicle_id, personnel_id, op_base_id) values (74, 1, 1, 7, 40, 1);

-- evaluation criteria constants
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_DEPLOYMENTS_OVERDEPLOYED', 5);
insert into evaluation_criteria (criteria, criteria_value) values ('MIN_SERVICE_YEARS_DEPLOYMENT', 2);
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_PERSONNEL_DEPLOYMENTS_READY', 3);
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_VEHICLE_DEPLOYMENTS_READY', 2);
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_BASE_CAPACITY', 100);
insert into evaluation_criteria (criteria, criteria_value) values ('MAINTENANCE_COST_INCREASE_THRESHOLD', 1.5);
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_HIGH_MAINTENANCE_VEHICLES', 3);
insert into evaluation_criteria (criteria, criteria_value) values ('MAX_PERSONNEL_DEPLOYMENTS_LIMIT', 10);
insert into evaluation_criteria (criteria, criteria_value) values ('HIGH_MAINTENANCE_COST_THRESHOLD', 1000000);

commit;

spool off