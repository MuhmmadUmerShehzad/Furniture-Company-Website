Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics
Imports System.Net.Http
Imports System.Web.Script.Serialization

Partial Class Products
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

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
        End If

    End Sub

    ' ============================================================
    ' NEW: Load Recommendations from the Web API
    ' ============================================================
    Private Sub LoadRecommendations(ByVal productId As Integer)
        Try
            Using client As New HttpClient()
                Dim apiUrl As String = "http://localhost:5001/api/recommendations/alsobought/" & productId
                Dim response As String = client.GetStringAsync(apiUrl).Result

                Dim serializer As New JavaScriptSerializer()
                Dim recommendations = serializer.Deserialize(Of List(Of Dictionary(Of String, Object)))(response)

                If recommendations IsNot Nothing AndAlso recommendations.Count > 0 Then
                    rptRecommendations.DataSource = recommendations
                    rptRecommendations.DataBind()
                    pnlRecommendations.Visible = True
                    lblNoRecommendations.Visible = False
                Else
                    pnlRecommendations.Visible = False
                    lblNoRecommendations.Visible = True
                    lblNoRecommendations.Text = "No recommendations found for this product yet."
                End If
            End Using
        Catch ex As Exception
            Debug.WriteLine("API Error: " & ex.Message)
            pnlRecommendations.Visible = False
            lblNoRecommendations.Visible = True
            lblNoRecommendations.Text = "Recommendation service unavailable."
        End Try
    End Sub

    ' ============================================================
    ' NEW: Load Reorder Suggestions for Current Customer
    ' ============================================================
    Private Sub LoadReorderSuggestions()
        Try
            Dim customerId As String = Session("CustomerId").ToString()

            If String.IsNullOrEmpty(customerId) Then
                Return
            End If

            Using client As New HttpClient()
                Dim apiUrl As String = "http://localhost:5001/api/recommendations/reorder/" & customerId
                Dim response As String = client.GetStringAsync(apiUrl).Result

                Dim serializer As New JavaScriptSerializer()
                Dim suggestions = serializer.Deserialize(Of List(Of Dictionary(Of String, Object)))(response)

                If suggestions IsNot Nothing AndAlso suggestions.Count > 0 Then
                    rptReorder.DataSource = suggestions
                    rptReorder.DataBind()
                    pnlReorder.Visible = True
                Else
                    pnlReorder.Visible = False
                End If

            End Using
        Catch ex As Exception
            Debug.WriteLine("API Error (Reorder): " & ex.Message)
            pnlReorder.Visible = False
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