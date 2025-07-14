# 🏦 Bank Management System – SQL Project

This project is a **SQL-based Bank Management System** that simulates core banking functionalities like managing customers, accounts, loans, and branches. It focuses on practical use of SQL concepts including table creation, constraints, joins, views, and nested queries.

---

## 📂 Database: `bank1`

### 📋 Tables:
- `customer`: Stores customer details
- `account`: Stores bank account details
- `loan`: Stores loan details of customers
- `branch`: Stores bank branch information

---

## 🛠️ Features & Highlights

- ✅ Create & manage relational database schema with foreign key constraints
- 🔐 Constraints: `PRIMARY KEY`, `UNIQUE`, `CHECK`, `DEFAULT`, `ENUM`
- 📈 Complex queries including:
  - Joins (INNER, LEFT, RIGHT)
  - Subqueries
  - Aggregations (`AVG`, `COUNT`, `SUM`)
  - Sorting & Filtering
- 🔄 Data Manipulation: `INSERT`, `UPDATE`, `DELETE`
- 👁️‍🗨️ Views creation and updates
- 📊 Queries to extract business insights (e.g. highest balance, pending loans, average branch balance)

---

## 📦 Sample Data

- **Customers** from various cities with email, phone, and age constraints.
- **Accounts** with various types (Savings/Current) linked to branches.
- **Loans** with types, interest, status, and timelines.
- **Branches** from multiple Indian states.

---

## 💡 Example Queries

- Get customers with more than one account
- Display loans with pending or default status
- Fetch account details with balance greater than average
- Create a view of customers with accounts in Maharashtra branches
- Find customers who have taken personal loans and update interest rates

---

## 🧠 Learning Objectives

- Master SQL DDL & DML operations
- Implement real-world relational database structure
- Practice complex query building & logic
- Understand the importance of data integrity through constraints

---

## 🧪 How to Run

1. Open **MySQL Workbench** or any SQL environment.
2. Copy and run the content from the SQL file in your database editor.
3. Use `SELECT *` queries to verify table contents.
4. Try modifying queries to extend functionality (e.g. adding transactions or users).

---

## 📁 File Structure
bank_project.sql # SQL file with schema, insertions, and queries
README.md # Project overview and documentation

---

## 🚀 Future Improvements

- Integrate with a Java-based frontend using JDBC
- Add stored procedures and triggers
- Role-based user login and account control

---

## 🧑‍💻 Author

**Sanskriti Singh**  
[LinkedIn](https://www.linkedin.com/in/sanskriti-singh-787688262) | [GitHub](https://github.com/01Sanskriti)

---

## 📜 License

This project is for educational purposes only.

