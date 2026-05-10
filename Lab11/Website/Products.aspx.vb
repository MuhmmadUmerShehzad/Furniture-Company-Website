

Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics
Imports System.Net.Http
Imports System.Web.Script.Serialization

Partial Class Products
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString
    Dim apiBaseUrl As String = ConfigurationManager.AppSettings("ApiBaseUrl")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

        ' Show Catalog link only for admin
        If Session("DbUser") Is Nothing Then
            Response.Redirect("Login.aspx")
        End If

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
            LoadProducts()
        End If

    End Sub

    Protected Sub LoadProducts()
        ' Establish connection with database and send sql query
        Dim conn As New SqlConnection(connString)

        Try
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "SELECT Product_Id, Product_Description"
            cmd.CommandText &= " FROM PRODUCT_t"

            conn.Open()

            Dim reader As SqlDataReader = cmd.ExecuteReader()

            rptProdcuts.DataSource = reader
            rptProdcuts.DataBind()

        Catch ex As Exception
            Debug.WriteLine("Database Error: " & ex.Message)
        Finally
            conn.Close()
        End Try
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSearch.Click

        ' Establish connection and send query
        Dim conn As New SqlConnection(connString)

        Try

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "SELECT Product_Id, Product_Description"
            cmd.CommandText &= " FROM PRODUCT_t"
            cmd.CommandText &= " WHERE Product_Description LIKE"
            cmd.CommandText &= " '%" & txtSearch.Text & "%' "

            conn.Open()

            'Execute the query
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            'Read the data returned by the query
            rptProdcuts.DataSource = reader
            rptProdcuts.DataBind()

        Catch ex As Exception
            Debug.WriteLine("Database Error: " & ex.Message)
        Finally
            conn.Close()
        End Try

        'Clear the search box after all the rendering of the page
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "clearBox", "document.getElementById('" & txtSearch.ClientID & "').value='';", True)

    End Sub
    Protected Sub rptProdcuts_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        If e.CommandName = "Order" Then
            Dim productId As String = e.CommandArgument.ToString()
            Dim customerId As String = Session("CustomerId").ToString()

            ' Redirect and pass ProductID and CustomerId in QueryString
            Response.Redirect("Orders.aspx?ProductID=" & productId & "&CustomerID=" & customerId)
        ElseIf e.CommandName = "ShowRecs" Then
            LoadRecommendations(Convert.ToInt32(e.CommandArgument))
        End If
    End Sub

    Private Sub LoadRecommendations(ByVal productId As Integer)
        Try
            Using conn As New SqlConnection(connString)
                Dim sql As String = "SELECT TOP 5 P.Product_Id, P.Product_Description, P.Standard_Price, COUNT(*) AS Freq " &
                                   "FROM Order_line_t OL1 JOIN Order_line_t OL2 ON OL1.Order_Id = OL2.Order_Id " &
                                   "JOIN PRODUCT_t P ON OL2.Product_Id = P.Product_Id " &
                                   "WHERE OL1.Product_Id = @pid AND OL2.Product_Id != @pid " &
                                   "GROUP BY P.Product_Id, P.Product_Description, P.Standard_Price ORDER BY Freq DESC"
                
                Dim cmd As New SqlCommand(sql, conn)
                cmd.Parameters.AddWithValue("@pid", productId)
                conn.Open()
                
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                Dim recommendations As New List(Of Object)()
                
                While reader.Read()
                    recommendations.Add(New With {
                        .productId = reader("Product_Id"),
                        .description = reader("Product_Description"),
                        .price = reader("Standard_Price")
                    })
                End While

                If recommendations.Count > 0 Then
                    rptRecommendations.DataSource = recommendations
                    rptRecommendations.DataBind()
                    pnlRecommendations.Visible = True
                    lblNoRecommendations.Visible = False
                Else
                    pnlRecommendations.Visible = False
                    lblNoRecommendations.Visible = True
                    lblNoRecommendations.Text = "No recommendations found for this product."
                End If
            End Using
        Catch ex As Exception
        End Try
    End Sub

    Private Sub LoadReorderSuggestions()
        Dim customerId As Integer = Convert.ToInt32(Session("CustomerId"))
        Try
            Using conn As New SqlConnection(connString)
                Dim sql As String = "SELECT DISTINCT P.Product_Id, P.Product_Description, P.Standard_Price " &
                                   "FROM ORDER_t O JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " &
                                   "JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " &
                                   "WHERE O.Customer_Id = @cid ORDER BY P.Product_Description"
                
                Dim cmd As New SqlCommand(sql, conn)
                cmd.Parameters.AddWithValue("@cid", customerId)
                conn.Open()
                
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                Dim reorders As New List(Of Object)()
                
                While reader.Read()
                    reorders.Add(New With {
                        .productId = reader("Product_Id"),
                        .description = reader("Product_Description"),
                        .price = reader("Standard_Price")
                    })
                End While

                If reorders.Count > 0 Then
                    rptReorders.DataSource = reorders
                    rptReorders.DataBind()
                    pnlReorder.Visible = True
                Else
                    pnlReorder.Visible = False
                End If
            End Using
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

    Protected Sub btnShowReorder_Click(sender As Object, e As EventArgs)
        LoadReorderSuggestions()
    End Sub

End Class