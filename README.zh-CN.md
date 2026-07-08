# ClassicModels Analytics Engineering with dbt｜GitHub 项目说明

这是一个可以直接放到 GitHub 的 analytics engineering showcase 项目。项目把原始订单业务数据建模成两类分析数据产品：

1. **Star Schema 星型模型**：适合正式报表、可复用指标、治理型分析。
2. **One Big Table OBT**：适合 BI dashboard、业务方自助分析、快速查询。

核心展示点不是“我会写 SQL”，而是：

- 能把业务交易数据转成分析模型。
- 能用 dbt 管理 transformation workflow。
- 能设计 fact / dimension / OBT。
- 能写 data quality tests。
- 能解释建模 trade-off。

适合投递：Analytics Engineer、Data Engineer、BI Engineer、Data Analyst with SQL/dbt 岗位。

## 一句话项目介绍

> Built a dbt analytics engineering project that transformed raw order-management data into a tested star schema and BI-ready One Big Table on PostgreSQL, enabling revenue, margin, customer, product-line, sales-rep, and late-shipment analysis.

## 本地运行

```bash
docker compose up -d
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
cp profiles.example.yml profiles.yml
cd classicmodels_modeling
dbt deps --profiles-dir ..
dbt build --profiles-dir ..
```

## 面试讲法

这个项目可以这样说：

> I started from raw operational order data and designed two analytical outputs: a normalized star schema for governed analytics and a denormalized OBT for BI users. I used dbt to create a staging layer, build fact and dimension models, generate surrogate keys, and add data quality tests such as uniqueness, not-null checks, relationship tests, and composite-key validation. The key design decision was balancing reusability and governance in the star schema with query simplicity and dashboard performance in the OBT.
