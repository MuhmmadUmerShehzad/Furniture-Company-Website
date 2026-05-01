using Microsoft.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

// Add CORS so your ASPX app can call this API
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader();
    });
});

var app = builder.Build();
app.UseCors();

var connString = builder.Configuration.GetConnectionString("PVFC");

// ============================================================
// Endpoint 1: "Customers who bought this also bought..."
// ============================================================
app.MapGet(
    "/api/recommendations/alsobought/{productId}",
    async (int productId) =>
    {
        var recommendations = new List<object>();

        using var conn = new SqlConnection(connString);

        var sql =
            @"
        SELECT TOP 5
            P.Product_Id,
            P.Product_Description,
            P.Standard_Price,
            COUNT(*) AS Times_Bought_Together
        FROM Order_line_t OL1
        JOIN Order_line_t OL2 ON OL1.Order_Id = OL2.Order_Id
        JOIN PRODUCT_t P ON OL2.Product_Id = P.Product_Id
        WHERE OL1.Product_Id = @ProductId
          AND OL2.Product_Id != @ProductId
        GROUP BY P.Product_Id, P.Product_Description, P.Standard_Price
        ORDER BY Times_Bought_Together DESC";

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@ProductId", productId);

        await conn.OpenAsync();
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
        {
            recommendations.Add(
                new
                {
                    ProductId = reader.GetInt32(reader.GetOrdinal("Product_Id")),
                    Description = reader.GetString(reader.GetOrdinal("Product_Description")),
                    Price = reader.GetDecimal(reader.GetOrdinal("Standard_Price")),
                    Freq = reader.GetInt32(reader.GetOrdinal("Times_Bought_Together")),
                }
            );
        }

        return Results.Ok(recommendations);
    }
);

// ============================================================
// Endpoint 2: Reorder suggestions for a customer
// ============================================================
app.MapGet(
    "/api/recommendations/reorder/{customerId}",
    async (int customerId) =>
    {
        var suggestions = new List<object>();

        using var conn = new SqlConnection(connString);

        var sql =
            @"
        SELECT DISTINCT 
            P.Product_Id, 
            P.Product_Description, 
            P.Standard_Price
        FROM ORDER_t O
        JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id
        JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id
        WHERE O.Customer_Id = @CustomerId
        ORDER BY P.Product_Description";

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@CustomerId", customerId);

        await conn.OpenAsync();
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
        {
            suggestions.Add(
                new
                {
                    ProductId = reader.GetInt32(reader.GetOrdinal("Product_Id")),
                    Description = reader.GetString(reader.GetOrdinal("Product_Description")),
                    Price = reader.GetDecimal(reader.GetOrdinal("Standard_Price")),
                }
            );
        }

        return Results.Ok(suggestions);
    }
);

// ============================================================
// Endpoint 3: Demand forecasting for secondary items (Admin)
// ============================================================
app.MapGet(
    "/api/recommendations/forecast/{productId}",
    async (int productId) =>
    {
        var forecast = new List<object>();

        using var conn = new SqlConnection(connString);

        var sql =
            @"
        SELECT
            P.Product_Id,
            P.Product_Description,
            COUNT(*) AS Co_occurrence_Count
        FROM Order_line_t OL1
        JOIN Order_line_t OL2 ON OL1.Order_Id = OL2.Order_Id
        JOIN PRODUCT_t P ON OL2.Product_Id = P.Product_Id
        WHERE OL1.Product_Id = @ProductId
          AND OL2.Product_Id != @ProductId
        GROUP BY P.Product_Id, P.Product_Description
        ORDER BY Co_occurrence_Count DESC";

        using var cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@ProductId", productId);

        await conn.OpenAsync();
        using var reader = await cmd.ExecuteReaderAsync();

        while (await reader.ReadAsync())
        {
            forecast.Add(
                new
                {
                    ProductId = reader.GetInt32(reader.GetOrdinal("Product_Id")),
                    Description = reader.GetString(reader.GetOrdinal("Product_Description")),
                    CoCount = reader.GetInt32(reader.GetOrdinal("Co_occurrence_Count")),
                }
            );
        }

        return Results.Ok(forecast);
    }
);

// Run on port 5001 (won't conflict with your ASPX app)
app.Run("http://localhost:5001");
