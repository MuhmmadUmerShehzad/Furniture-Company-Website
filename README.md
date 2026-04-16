# 🛋️ PVFC Furniture - Order Management System

![ASP.NET](https://img.shields.io/badge/ASP.NET-5C2D91?style=for-the-badge&logo=dotnet&logoColor=white)
![VB.NET](https://img.shields.io/badge/VB.NET-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)

A full-featured **e-commerce order management system** with intelligent **Customer Segmentation** and Business Intelligence, developed as part of the Internet Application Development Lab.

---

## ✨ Project Highlights

- Secure user authentication (Admin + Customer)
- Real-time order placement with live price calculation
- Advanced **Customer Segmentation Analysis** (Premium, Frequent & Bulk Buyers)
- Dynamic personalized alerts based on customer segment
- Admin dashboard with adjustable segmentation thresholds
- Professional UI with responsive GridViews

---

## 🎯 Key Features

### 👤 User Features
- Browse products and place orders
- Real-time total price calculation
- Personalized order confirmation messages

### 🔍 Business Intelligence Features
- **Premium Customers** → High-value spenders (Complimentary Gift)
- **Frequent Customers** → Loyal repeat buyers
- **Bulk Buyers** → High quantity purchasers
- Live segmentation with custom thresholds
- Empty segment handling with friendly messages

### 🛠️ Admin Features
- Full customer segmentation dashboard
- Adjustable thresholds for all segments
- Total customer statistics
- Order management visibility

---

## 🛠️ Technologies Used

| Technology          | Purpose                        |
|---------------------|--------------------------------|
| ASP.NET Web Forms   | Frontend Framework             |
| VB.NET              | Server-side Logic              |
| SQL Server          | Database                       |
| ADO.NET             | Data Access                    |
| Stored Procedures   | Secure & Optimized Queries     |
| Session Management  | Authentication & State         |

---


3. Update connection string in `Web.config`

```xml
<connectionStrings>
    <add name="PVFC" 
         connectionString="Data Source=.;Initial Catalog=PVFC;Integrated Security=True" 
         providerName="System.Data.SqlClient"/>
</connectionStrings>
```

---

## 📌 Project Structure

```
PVFC-Furniture/
├── CustomerSegmentation.aspx      # Admin Segmentation Dashboard
├── Order.aspx                     # Order Placement Page
├── Login.aspx
├── Web.config
├── App_Data/
└── SQL Scripts/
    ├── create pvfc.sql
    └── sp_PlaceOrder.sql
```

---

## 👨‍💻 Developed By

**Umer Shehzad**  
*Internet Application Development Lab Project*

---

## 📄 License

This project is developed for educational purposes.
