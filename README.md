# 🛍️ Fashion Boutique Sales Analysis  

## 📌 Project Overview  
This project analyzes sales, returns, customer satisfaction, and business performance for a **Fashion Boutique** using **MySQL**. The goal is to uncover insights into product performance, customer behavior, and year-over-year growth.  

## 📂 Dataset  
The dataset (`fashion_boutique.csv`) contains sales transactions with details such as:  
- **purchase_date**  
- **category**  
- **brand**  
- **size**  
- **color**  
- **current_price**  
- **customer_rating**  
- **is_returned** and **return_reason**  

The dataset was cleaned and analyzed using **SQL queries** provided in [`Analysis.sql`](./Analysis.sql).  

## 🔎 SQL Analysis Performed  
Some of the key queries include:  
- Data cleaning (date conversion, missing value handling)  
- Average customer rating & satisfaction per category  
- Best-selling **colors**, **seasons**, and **sizes**  
- Return rates and most common return reasons  
- Profit comparison between **2024 vs 2025**  

## 📊 Key Insights  
- Average customer rating across all purchases: **2.5 / 5**  
- Top reasons for returns: **Change of mind** and **Size issues**  
- Best-selling **color** and **season** identified  
- Business performance **grew in 2025**, with profit increasing by **128,458.05** compared to 2024  

👉 *Screenshots of SQL results and charts can be found in the `insights/` folder.*  

## ⚙️ How to Run the Project  
1. Clone this repository:  
   ```bash
   git clone https://github.com/your-username/fashion-boutique-analysis.git
   cd fashion-boutique-analysis
   ```  
2. Import the dataset into MySQL:  
   ```sql
   LOAD DATA INFILE 'fashion_boutique.csv'
   INTO TABLE fashion_boutique
   FIELDS TERMINATED BY ','
   IGNORE 1 ROWS;
   ```  
3. Run the analysis script:  
   ```sql
   SOURCE Analysis.sql;
   ```  

## 📈 Visualizations  
Screenshots from SQL insights are included to highlight:  
- Category-wise satisfaction rates  
- Return reasons distribution  
- Yearly profit growth  

## 🚀 Conclusion  
The boutique shows **positive growth**, but improvements in **sizing accuracy** and **customer satisfaction** are essential to reduce returns and increase loyalty.  
