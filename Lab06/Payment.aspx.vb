Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class Payment
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

    Protected Sub btnProceed_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProceed.Click
        Response.Write("<script>alert('Payment Successful! Thank you for your purchase.');</script>")
    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class
