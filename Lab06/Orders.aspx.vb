Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class Order
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        ' Show Catalog link only for admin
        If Session("User_Role") = "admin" Then
            pnlCatalog.Visible = True
        Else
            pnlCatalog.Visible = False
        End If

        If Not IsPostBack Then
            LoadUserInfo()

            Dim conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand("SELECT Customer_Id, Customer_Name FROM CUSTOMER_t", conn)

            conn.Open()
            ddlCustomer.DataSource = cmd.ExecuteReader()
            ddlCustomer.DataTextField = "Customer_Name"
            ddlCustomer.DataValueField = "Customer_Id"
            ddlCustomer.DataBind()
            conn.Close()
        End If
    End Sub

    Protected Sub LoadUserInfo()
        ' Load customer name from database using Customer_Id from session
        If Session("CustomerId") IsNot Nothing Then
            Dim customerId As String = Session("CustomerId").ToString()
            Dim conn As New SqlConnection(connString)

            Try
                Dim cmd As New SqlCommand
                cmd.Connection = conn
                cmd.CommandText = "SELECT Customer_Name FROM CUSTOMER_t WHERE Customer_Id = @CustomerId"
                cmd.Parameters.AddWithValue("@CustomerId", customerId)

                conn.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()

                If reader.Read() Then
                    lblCustomerName.Text = reader("Customer_Name").ToString()
                    lblCustomerId.Text = customerId
                End If

                reader.Close()

            Catch ex As Exception
                Debug.WriteLine("Database Error: " & ex.Message)
                lblCustomerName.Text = "User"
                lblCustomerId.Text = customerId
            Finally
                conn.Close()
            End Try
        End If
    End Sub

    Protected Sub btnOrder_Click(sender As Object, e As EventArgs) Handles btnOrder.Click

        ' Disable button to prevent duplicate submissions
        btnOrder.Enabled = False

        Dim productId As Integer = Convert.ToInt32(Request.QueryString("ProductID"))
        Dim customerId As Integer = Convert.ToInt32(ddlCustomer.SelectedValue)

        Dim conn As New SqlConnection(connString)

        Try
            conn.Open()

            ' Verify customer exists in database
            Dim cmdVerify As New SqlCommand
            cmdVerify.Connection = conn
            cmdVerify.CommandText = "SELECT COUNT(*) FROM CUSTOMER_t"
            cmdVerify.CommandText &= " WHERE Customer_Id = "
            cmdVerify.CommandText &= customerId

            'cmdVerify.Parameters.AddWithValue("@cid", customerId)
            Dim customerExists As Integer = CInt(cmdVerify.ExecuteScalar())

            If customerExists = 0 Then
                Response.Write("<script>alert('Error: Customer not found. Please log in again.');</script>")
                btnOrder.Enabled = True
                Exit Sub
            End If

            ' Generate a unique Order_Id that doesn't already exist
            Dim orderId As Integer
            Dim orderExists As Integer = 1
            Dim random As New Random()

            While orderExists > 0
                orderId = random.Next(10000, 99999)
                Dim cmdCheckId As New SqlCommand
                cmdCheckId.Connection = conn
                cmdCheckId.CommandText = "SELECT COUNT(*) FROM ORDER_t"
                cmdCheckId.CommandText &= " WHERE Order_Id = "
                cmdCheckId.CommandText &= orderId
                orderExists = CInt(cmdCheckId.ExecuteScalar())
            End While

            Dim cmdOrder As New SqlCommand
            cmdOrder.Connection = conn
            cmdOrder.CommandText = "INSERT INTO ORDER_t (Order_Id, Customer_Id, Order_Date) VALUES ("
            cmdOrder.CommandText &= orderId & ", " & customerId & ", '" & DateTime.Now & "') "

            cmdOrder.ExecuteNonQuery()

            Dim cmdLine As New SqlCommand
            cmdLine.Connection = conn
            cmdLine.CommandText = "INSERT INTO Order_line_t (Order_Id, Product_Id, Ordered_Quantity) VALUES ("
            cmdLine.CommandText &= orderId & ", " & productId & ", " & txtQuantity.Text & ") "

            cmdLine.ExecuteNonQuery()

            Response.Write("<script>alert('Order Placed Successfully! Order ID: " & orderId & "');</script>")
        Catch ex As Exception
            btnOrder.Enabled = True
            Response.Write("<script>alert('Error: " & ex.Message.Replace("'", "\'") & "');</script>")
        Finally
            conn.Close()
        End Try

    End Sub

    Protected Sub txtQuantity_TextChanged(sender As Object, e As EventArgs)

        Dim productId As Integer
        If Not Integer.TryParse(Request.QueryString("ProductID"), productId) Then Exit Sub

        Dim qty As Integer
        If Not Integer.TryParse(txtQuantity.Text.Trim(), qty) Then Exit Sub

        Using conn As New SqlConnection(connString)
            conn.Open()

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "SELECT Standard_Price FROM PRODUCT_t WHERE Product_Id = "
            cmd.CommandText &= productId


            Dim priceObj = cmd.ExecuteScalar()

            If priceObj IsNot Nothing Then
                Dim price As Decimal = Convert.ToDecimal(priceObj)
                Dim total As Decimal = price * qty
                lblTotalPrice.Text = total.ToString("0.00")
            End If
        End Using

    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class