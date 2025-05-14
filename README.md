# MoonGlim Jewelry Data Warehousing Project
(Collabrative Project between Audrey Stuart and Mouyseang An)
## Project Overview  
MoonGlim Jewelry is a luxury Direct-to-Consumer (D2C) brand focused on high-quality jewelry and ethical sourcing. This data warehousing project aims to centralize sales, customer, and product data to drive actionable insights for business growth. The project follows a structured approach, including **ETL processes**, **data mart design**, **analytical reporting**, and **dashboard development** to support decision-making across departments.

---

## Key Components  

### 1. **Data Mart Design**  
- **Star Schema**:  
  - **Fact Table**: `Sales` (captures order details).  
  - **Dimensions**: `Date`, `Customer`, `Product`, `Employee`, and `Location`.  
- **KPIs**:  
  - Total Revenue, Average Order Value, Sales Growth Rate (YoY), Total Orders.  
- **Business Requirements**:  
  - Revenue by year/quarter, product popularity by state, customer loyalty analysis, and revenue breakdown by product type.  

### 2. **ETL Process (SSIS)**  
- **Steps**:  
  - Built SSIS packages to extract data from OLTP databases, transform it, and load into the data mart.  
  - Created sequence containers for preparing data mart, loading dimensions (e.g., `DimDate`), and populating the fact table.  
- **Challenges**:  
  - Scripting errors in fact table population, resolved through iterative debugging.  
  - Synthetic data generation for missing source data.  

### 3. **Power Pivot Analysis**  
- **Key Findings**:  
  - Revenue fluctuations linked to seasonal trends (e.g., higher sales in December).  
  - Bracelets underperforming compared to necklaces and earrings.  
- **Recommendations**:  
  - Remarket bracelets with targeted campaigns.  
  - Investigate supply chain inefficiencies causing revenue volatility.  

### 4. **Dashboards (Power BI & Tableau)**  
- **Stakeholder Focus**:  
  - **CFO/Finance**: High-level metrics like Total Revenue, YoY Growth, and state-wise revenue heatmaps.  
  - **Sales Team**: Product performance trends, customer loyalty rankings.  
- **Visualizations**:  
  - Line charts for revenue trends, bar graphs for product popularity, maps for regional sales, scatter plots for order value distribution.  

---

## Tools & Technologies  
- **ETL**: SQL Server Integration Services (SSIS), Visual Studio.  
- **Analysis**: Power Pivot, Excel.  
- **Visualization**: Power BI, Tableau.  
- **Data Modeling**: Star Schema, Entity Relationship Diagrams (ERD).  

---

## Business Impact  
- **Revenue Growth**: Identifying underperforming products (e.g., bracelets) and seasonal trends enables targeted marketing, aiming for a **20% revenue increase**.  
- **Customer Experience**: Loyalty analysis helps retain high-value customers through personalized offers.  
- **Operational Efficiency**: Data-driven inventory management reduces waste and aligns with sustainability goals.  
