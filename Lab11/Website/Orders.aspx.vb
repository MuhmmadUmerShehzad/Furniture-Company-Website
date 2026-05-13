Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics
Imports System.Data
Imports System.Net.Http
Imports System.Web.Script.Serialization
Imports System.Threading.Tasks

Partial Class Order
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString
    Dim apiBaseUrl As String = ConfigurationManager.AppSettings("ApiBaseUrl")

    Protected Async Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        If Session("DbUser") Is Nothing Then
            Response.Redirect("Login.aspx")
        End If

        ' Show Catalog link only for admin
        If Session("User_Role") = "admin" Then
            pnlCatalog.Visible = True
            pnlSegmentation.Visible = True
        Else
            pnlCatalog.Visible = False
            pnlSegmentation.Visible = False
        End If

        If Not IsPostBack Then
            lblCustomerName.Text = Session("DbUser").ToString()
            If Session("Customer_Id") IsNot Nothing Then
                lblCustomerId.Text = Session("CustomerId").ToString()
            End If

            Dim conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand("SELECT Customer_Id, Customer_Name FROM CUSTOMER_t", conn)

            conn.Open()
            ddlCustomer.DataSource = cmd.ExecuteReader()
            ddlCustomer.DataTextField = "Customer_Name"
            ddlCustomer.DataValueField = "Customer_Id"
            ddlCustomer.DataBind()
            conn.Close()

            ClearForm()

            ' Fetch product name and load recommendations
            Dim productId As Integer
            If Integer.TryParse(Request.QueryString("ProductID"), productId) Then
                LoadProductName(productId)
                Await LoadRecommendations(productId)
            End If
        End If
    End Sub

    Protected Sub btnOrder_Click(sender As Object, e As EventArgs) Handles btnOrder.Click

        btnOrder.Enabled = False

        Dim customerId As Integer = Convert.ToInt32(ddlCustomer.SelectedValue)
        Dim productId As Integer = Convert.ToInt32(Request.QueryString("ProductID"))
        Dim quantity As Integer

        If Not Integer.TryParse(txtQuantity.Text.Trim(), quantity) OrElse quantity <= 0 Then
            Response.Write("<script>alert('Please enter valid quantity');</script>")
            btnOrder.Enabled = True
            Exit Sub
        End If

        Using conn As New SqlConnection(connString)
            Try
                conn.Open()

                Using cmd As New SqlCommand("sp_PlaceOrder", conn)
                    cmd.CommandType = CommandType.StoredProcedure

                    cmd.Parameters.AddWithValue("@Customer_Id", customerId)
                    cmd.Parameters.AddWithValue("@Product_Id", productId)
                    cmd.Parameters.AddWithValue("@Quantity", quantity)

                    Dim newOrderId As Integer = Convert.ToInt32(cmd.ExecuteScalar())

                    Response.Write("<script>alert('Order Placed Successfully! Order ID: " & newOrderId & "');</script>")
                    ClearForm()
                End Using

            Catch ex As Exception
                Response.Write("<script>alert('Error: " & ex.Message.Replace("'", "\'") & "');</script>")
            Finally
                btnOrder.Enabled = True
            End Try
        End Using

    End Sub

    Private Sub ClearForm()
        txtContact.Text = ""
        txtAddress.Text = ""
        txtPostalCode.Text = ""
        txtQuantity.Text = ""
        lblTotalPrice.Text = ""
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
            cmd.CommandText = "SELECT Standard_Price FROM PRODUCT_t WHERE Product_Id = @Product_Id"
            cmd.Parameters.AddWithValue("@Product_Id", productId)


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

    Private Sub LoadProductName(ByVal productId As Integer)
        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand("SELECT Product_Description FROM PRODUCT_t WHERE Product_Id = @id", conn)
            cmd.Parameters.AddWithValue("@id", productId)
            conn.Open()
            Dim name = cmd.ExecuteScalar()
            If name IsNot Nothing Then
                lblProductName.Text = "Ordering: " & name.ToString()
            End If
        End Using
    End Sub

    Private Async Function LoadRecommendations(ByVal productId As Integer) As Task
        Try
            Using client As New HttpClient()
                Dim url As String = apiBaseUrl & "alsobought/" & productId
                Dim response = Await client.GetAsync(url)

                If response.IsSuccessStatusCode Then
                    Dim json As String = Await response.Content.ReadAsStringAsync()
                    Dim serializer As New JavaScriptSerializer()
                    Dim recommendations = serializer.Deserialize(Of List(Of Object))(json)

                    If recommendations IsNot Nothing AndAlso recommendations.Count > 0 Then
                        rptRecommendations.DataSource = recommendations
                        rptRecommendations.DataBind()
                        pnlRecommendations.Visible = True
                        lblNoRecommendations.Visible = False
                    Else
                        pnlRecommendations.Visible = False
                        lblNoRecommendations.Visible = True
                        lblNoRecommendations.Text = "No additional recommendations for this product."
                    End If
                End If
            End Using
        Catch ex As Exception
            Debug.WriteLine("Recommendation Error: " & ex.Message)
            pnlRecommendations.Visible = False
        End Try
    End Function

End Class