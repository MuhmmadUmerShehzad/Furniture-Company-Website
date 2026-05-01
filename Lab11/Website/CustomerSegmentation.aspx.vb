Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Partial Class CustomerSegmentation
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        ' Restrict to admin role only
        If Session("User_Role") Is Nothing OrElse Session("User_Role").ToString() <> "admin" Then
            Response.Redirect("Login.aspx")
            Return
        End If

        lblUserName.Text = Session("DbUser").ToString()
        lblRole.Text = "Admin"

        If Not IsPostBack Then
            LoadTotalCustomers()
            RunSegmentation()
        End If
    End Sub

    Protected Sub btnAnalyse_Click(sender As Object, e As EventArgs) Handles btnAnalyse.Click
        LoadTotalCustomers()
        RunSegmentation()
    End Sub

    Private Sub LoadTotalCustomers()
        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand("SELECT COUNT(*) FROM CUSTOMER_t", conn)
            conn.Open()
            lblTotalCustomers.Text = cmd.ExecuteScalar().ToString()
        End Using
    End Sub

    Private Sub RunSegmentation()

        Dim premiumThreshold As Decimal = 3000
        Dim frequentThreshold As Integer = 3
        Dim bulkThreshold As Decimal = 5

        Decimal.TryParse(txtPremiumThreshold.Text.Trim(), premiumThreshold)
        Integer.TryParse(txtFrequentThreshold.Text.Trim(), frequentThreshold)
        Decimal.TryParse(txtBulkThreshold.Text.Trim(), bulkThreshold)

        LoadPremiumCustomers(premiumThreshold)
        LoadFrequentCustomers(frequentThreshold)
        LoadBulkBuyers(bulkThreshold)
    End Sub

    Private Sub LoadPremiumCustomers(threshold As Decimal)

        Dim sql As String =
            "SELECT C.Customer_Name, " &
            "       SUM(P.Standard_Price * OL.Ordered_Quantity) AS Total_Spend " &
            "FROM   CUSTOMER_t C " &
            "JOIN   ORDER_t        O  ON O.Customer_Id  = C.Customer_Id " &
            "JOIN   Order_line_t   OL ON OL.Order_Id    = O.Order_Id " &
            "JOIN   PRODUCT_t      P  ON P.Product_Id   = OL.Product_Id " &
            "GROUP BY C.Customer_Name " &
            "HAVING SUM(P.Standard_Price * OL.Ordered_Quantity) >= @Threshold " &
            "ORDER BY Total_Spend DESC"

        Dim dt As DataTable = FetchData(sql, "@Threshold", threshold)

        lblPremiumCount.Text = dt.Rows.Count.ToString()
        lblPremiumGridCount.Text = dt.Rows.Count.ToString()

        If dt.Rows.Count = 0 Then
            gvPremium.Visible = False
            lblPremiumEmpty.Visible = True
        Else
            gvPremium.Visible = True
            lblPremiumEmpty.Visible = False
            gvPremium.DataSource = dt
            gvPremium.DataBind()
        End If
    End Sub

    Private Sub LoadFrequentCustomers(threshold As Integer)

        Dim sql As String =
            "SELECT C.Customer_Name, " &
            "       COUNT(DISTINCT O.Order_Id) AS Order_Count " &
            "FROM   CUSTOMER_t C " &
            "JOIN   ORDER_t O ON O.Customer_Id = C.Customer_Id " &
            "GROUP BY C.Customer_Name " &
            "HAVING COUNT(DISTINCT O.Order_Id) >= @Threshold " &
            "ORDER BY Order_Count DESC"

        Dim dt As DataTable = FetchData(sql, "@Threshold", threshold)

        lblFrequentCount.Text = dt.Rows.Count.ToString()
        lblFrequentGridCount.Text = dt.Rows.Count.ToString()

        If dt.Rows.Count = 0 Then
            gvFrequent.Visible = False
            lblFrequentEmpty.Visible = True
        Else
            gvFrequent.Visible = True
            lblFrequentEmpty.Visible = False
            gvFrequent.DataSource = dt
            gvFrequent.DataBind()
        End If
    End Sub

    Private Sub LoadBulkBuyers(threshold As Decimal)

        Dim sql As String =
            "SELECT C.Customer_Name, " &
            "       CAST(SUM(OL.Ordered_Quantity) AS DECIMAL(10,2)) / " &
            "       COUNT(DISTINCT O.Order_Id) AS Avg_Qty " &
            "FROM   CUSTOMER_t C " &
            "JOIN   ORDER_t        O  ON O.Customer_Id  = C.Customer_Id " &
            "JOIN   Order_line_t   OL ON OL.Order_Id    = O.Order_Id " &
            "GROUP BY C.Customer_Name " &
            "HAVING CAST(SUM(OL.Ordered_Quantity) AS DECIMAL(10,2)) / " &
            "       COUNT(DISTINCT O.Order_Id) >= @Threshold " &
            "ORDER BY Avg_Qty DESC"

        Dim dt As DataTable = FetchData(sql, "@Threshold", threshold)

        lblBulkCount.Text = dt.Rows.Count.ToString()
        lblBulkGridCount.Text = dt.Rows.Count.ToString()

        If dt.Rows.Count = 0 Then
            gvBulk.Visible = False
            lblBulkEmpty.Visible = True
        Else
            gvBulk.Visible = True
            lblBulkEmpty.Visible = False
            gvBulk.DataSource = dt
            gvBulk.DataBind()
        End If
    End Sub

    Private Function FetchData(sql As String, paramName As String, paramValue As Object) As DataTable
        Dim dt As New DataTable()
        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand(sql, conn)
            cmd.Parameters.AddWithValue(paramName, paramValue)
            Dim adapter As New SqlDataAdapter(cmd)
            conn.Open()
            adapter.Fill(dt)
        End Using
        Return dt
    End Function

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs) Handles btnLogout.Click
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class
