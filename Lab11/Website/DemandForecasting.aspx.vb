Imports System
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics
Imports System.Net.Http
Imports System.Web.Script.Serialization

Partial Class DemandForecasting
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString
    Dim apiBaseUrl As String = ConfigurationManager.AppSettings("ApiBaseUrl")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ' Only admins can access
        If Session("DbUser") Is Nothing Then
            Response.Redirect("Login.aspx")
        End If

        If Session("User_Role") <> "admin" Then
            Response.Redirect("Products.aspx")
        End If

        If Not IsPostBack Then
            lblCustomerName.Text = Session("DbUser").ToString()
            LoadAllProducts()
        End If
    End Sub

    Private Sub LoadAllProducts()
        Using conn As New SqlConnection(connString)
            Dim cmd As New SqlCommand("SELECT Product_Id, Product_Description FROM PRODUCT_t ORDER BY Product_Description", conn)
            conn.Open()
            ddlPrimaryProduct.DataSource = cmd.ExecuteReader()
            ddlPrimaryProduct.DataBind()
            ddlPrimaryProduct.Items.Insert(0, New ListItem("-- Select Primary Product --", "0"))
        End Using
    End Sub

    Protected Sub btnForecast_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim productId As Integer = Convert.ToInt32(ddlPrimaryProduct.SelectedValue)
        If productId = 0 Then Return

        Try
            Using conn As New SqlConnection(connString)
                Dim sql As String = "SELECT P.Product_Id, P.Product_Description, COUNT(*) AS CoCount " &
                                   "FROM Order_line_t OL1 JOIN Order_line_t OL2 ON OL1.Order_Id = OL2.Order_Id " &
                                   "JOIN PRODUCT_t P ON OL2.Product_Id = P.Product_Id " &
                                   "WHERE OL1.Product_Id = @pid AND OL2.Product_Id != @pid " &
                                   "GROUP BY P.Product_Id, P.Product_Description ORDER BY CoCount DESC"
                
                Dim cmd As New SqlCommand(sql, conn)
                cmd.Parameters.AddWithValue("@pid", productId)
                conn.Open()
                
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                Dim forecastData As New List(Of Object)()
                
                While reader.Read()
                    forecastData.Add(New With {
                        .productId = reader("Product_Id"),
                        .description = reader("Product_Description"),
                        .coCount = reader("CoCount")
                    })
                End While

                If forecastData.Count > 0 Then
                    rptForecast.DataSource = forecastData
                    rptForecast.DataBind()
                    pnlForecastResults.Visible = True
                    lblNoData.Visible = False
                Else
                    pnlForecastResults.Visible = False
                    lblNoData.Visible = True
                End If
            End Using
        Catch ex As Exception
            Debug.WriteLine("Forecast Error: " & ex.Message)
            pnlForecastResults.Visible = False
            lblNoData.Text = "Forecasting service currently unavailable."
            lblNoData.Visible = True
        End Try
    End Sub

    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class
