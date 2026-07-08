# Data dictionary

## fact_orders

| Column | Description |
|---|---|
| `fact_order_key` | Surrogate key for the order line |
| `customer_key` | Foreign key to `dim_customers` |
| `employee_key` | Foreign key to `dim_employees` |
| `office_key` | Foreign key to `dim_offices` |
| `product_key` | Foreign key to `dim_products` |
| `order_number` | Source order number |
| `order_line_number` | Line number within an order |
| `quantity_ordered` | Units ordered |
| `price_each` | Actual selling price per unit |
| `buy_price` | Product acquisition cost per unit |
| `line_revenue` | `quantity_ordered * price_each` |
| `line_profit` | `quantity_ordered * (price_each - buy_price)` |
| `days_to_ship` | Days between order date and shipped date |
| `is_late_shipment` | Whether shipped date exceeded required date |

## orders_obt

The OBT contains order, customer, product, sales-rep, office, revenue, profit, and shipment attributes in one denormalized table for BI use.
