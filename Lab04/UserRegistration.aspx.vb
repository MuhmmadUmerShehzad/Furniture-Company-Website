Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class Registration
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ' Show Catalog link only for admin
        If Session("User_Role") = "admin" Then
            pnlCatalog.Visible = True
        Else
            pnlCatalog.Visible = False
        End If
    End Sub

    Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRegister.Click

        Dim conn As New SqlConnection(connString)

        Try
            Dim customerId As Integer = New Random().Next(1000, 9999)

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code) VALUES (" & customerId & ", '" & txtName.Text & "', '" & txtAddress.Text & "', '" & txtCity.Text & "', '" & txtState.Text & "', '" & txtPostal.Text & "')"
            conn.Open()
            cmd.ExecuteNonQuery()

            Debug.WriteLine("Customer Registered Successfully")
        Catch ex As Exception
            Debug.WriteLine("Database Error: " & ex.Message)
        Finally
            conn.Close()
        End Try

    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class