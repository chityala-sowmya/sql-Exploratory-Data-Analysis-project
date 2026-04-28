# 📊 Data Catalog

This document describes the structure and meaning of the dataset used in this project.
The data is organized in a **star schema** consisting of one fact table (`fact_sales`) and two dimension tables (`dim_customers`, `dim_products`).

---

## 🧾 gold.fact_sales

Transaction-level data — each row represents a single sales order.

| Column Name   | Description                            |
| ------------- | -------------------------------------- |
| order_number  | Unique identifier for each order       |
| product_key   | Foreign key linking to `dim_products`  |
| customer_key  | Foreign key linking to `dim_customers` |
| order_date    | Date when the order was placed         |
| shipping_date | Date when the order was shipped        |
| due_date      | Expected delivery date                 |
| sales_amount  | Total revenue generated from the order |
| quantity      | Number of units sold                   |
| price         | Price per unit of the product          |

---

## 👤 gold.dim_customers

Customer details and demographic information.

| Column Name     | Description                               |
| --------------- | ----------------------------------------- |
| customer_key    | Surrogate key for customer                |
| customer_id     | Business identifier for customer          |
| customer_number | Alternate customer reference number       |
| first_name      | Customer's first name                     |
| last_name       | Customer's last name                      |
| country         | Country where the customer is located     |
| marital_status  | Marital status of the customer            |
| gender          | Gender of the customer                    |
| birthdate       | Customer's date of birth                  |
| create_date     | Date when the customer record was created |

---

## 📦 gold.dim_products

Product details and classification.

| Column Name    | Description                                           |
| -------------- | ----------------------------------------------------- |
| product_key    | Surrogate key for product                             |
| product_id     | Business identifier for product                       |
| product_number | Alternate product reference number                    |
| product_name   | Name of the product                                   |
| category_id    | Identifier for product category                       |
| category       | High-level product category                           |
| subcategory    | Detailed product classification                       |
| maintenance    | Maintenance or service classification (if applicable) |
| cost           | Cost price of the product                             |
| product_line   | Product line grouping                                 |
| start_date     | Date when the product became available                |

---

## 🔗 Relationships

* `fact_sales.customer_key` → `dim_customers.customer_key`
* `fact_sales.product_key` → `dim_products.product_key`

These relationships enable:

* Customer-level analysis
* Product performance tracking
* Revenue breakdown by category and geography

---

## 🧠 Notes

* The dataset is stored in the `/datasets` folder
* Data follows a **star schema design** for efficient analytical querying
* Surrogate keys (`customer_key`, `product_key`) are used for joins
* Suitable for exploratory data analysis, reporting, and advanced analytics

---
