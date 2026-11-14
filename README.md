# Food Delivery Performance Analysis | Power BI + SQL + Excel

## The Question
Does delivering late actually hurt customer ratings?

## Key Finding
**Yes. On-time deliveries average 4.8 stars, late deliveries drop to 3.5 stars.**

Late orders are worst in Midrand & Soweto, especially for KFC, McDonald's, and Debonairs.

## What I Did
1. Cleaned raw data in SQL - removed nulls, fixed dates, standardized area names, removed duplicates
2. Built logic: `is_late = Yes` when `delivery_time > promised_time`
3. Built Power BI dashboard showing ratings by delivery status, area, and restaurant

## Files in this Repo
- `delivery_clean.xlsx` - Cleaned dataset (20 orders, Oct 2026)
- `cleaning.sql` - All cleaning steps
- `dashboard.png` - Final dashboard screenshot
- `Food-Delivery-Dashboard.pbix` - Power BI file

## Tools
Excel | SQL | Power BI

## Author
Sifiso Ncube | BCom Information and Technology (Mancosa) | Aspiring Data Analyst | Johannesburg
