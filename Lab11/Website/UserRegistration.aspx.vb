Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class Registration
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
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
            LoadExistingCustomerData()
        End If
    End Sub

    Protected Sub LoadExistingCustomerData()
        ' Load existing customer information if user is logged in
        If Session("CustomerId") IsNot Nothing Then
            Dim customerId As String = Session("CustomerId").ToString()
            Dim conn As New SqlConnection(connString)

            Try
                Dim cmd As New SqlCommand
                cmd.Connection = conn
                cmd.CommandText = "SELECT Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code FROM CUSTOMER_t WHERE Customer_Id = @CustomerId"
                cmd.Parameters.AddWithValue("@CustomerId", customerId)

                conn.Open()
                Dim reader As SqlDataReader = cmd.ExecuteReader()

                If reader.Read() Then
                    txtUpdateName.Text = reader("Customer_Name").ToString()
                    txtUpdateAddress.Text = reader("Customer_Address").ToString()
                    txtUpdateCity.Text = reader("Customer_City").ToString()
                    txtUpdateState.Text = reader("Customer_State").ToString()
                    txtUpdatePostal.Text = reader("Postal_Code").ToString()
                End If

                reader.Close()

            Catch ex As Exception
                Debug.WriteLine("Database Error: " & ex.Message)
            Finally
                conn.Close()
            End Try
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

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpdate.Click

        ' Check if user is logged in
        If Session("CustomerId") Is Nothing Then
            lblUpdateMessage.Text = "You must be logged in to update your information."
            lblUpdateMessage.CssClass = "update-message error"
            Exit Sub
        End If

        Dim customerId As String = Session("CustomerId").ToString()
        Dim conn As New SqlConnection(connString)

        Try
            ' Validate inputs
            If String.IsNullOrWhiteSpace(txtUpdateName.Text) Then
                lblUpdateMessage.Text = "Please enter your name."
                lblUpdateMessage.CssClass = "update-message error"
                Exit Sub
            End If

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "UPDATE CUSTOMER_t SET " &
                              "Customer_Name = @CustomerName, " &
                              "Customer_Address = @CustomerAddress, " &
                              "Customer_City = @CustomerCity, " &
                              "Customer_State = @CustomerState, " &
                              "Postal_Code = @PostalCode " &
                              "WHERE Customer_Id = @CustomerId"

            cmd.Parameters.AddWithValue("@CustomerId", customerId)
            cmd.Parameters.AddWithValue("@CustomerName", txtUpdateName.Text.Trim())
            cmd.Parameters.AddWithValue("@CustomerAddress", If(String.IsNullOrWhiteSpace(txtUpdateAddress.Text), "", txtUpdateAddress.Text.Trim()))
            cmd.Parameters.AddWithValue("@CustomerCity", If(String.IsNullOrWhiteSpace(txtUpdateCity.Text), "", txtUpdateCity.Text.Trim()))
            cmd.Parameters.AddWithValue("@CustomerState", If(String.IsNullOrWhiteSpace(txtUpdateState.Text), "", txtUpdateState.Text.Trim()))
            cmd.Parameters.AddWithValue("@PostalCode", If(String.IsNullOrWhiteSpace(txtUpdatePostal.Text), "", txtUpdatePostal.Text.Trim()))

            conn.Open()
            Dim rowsAffected As Integer = cmd.ExecuteNonQuery()

            If rowsAffected > 0 Then
                lblUpdateMessage.Text = "Your information has been updated successfully!"
                lblUpdateMessage.CssClass = "update-message success"
                Debug.WriteLine("Customer Information Updated Successfully")
            Else
                lblUpdateMessage.Text = "No records were updated. Please try again."
                lblUpdateMessage.CssClass = "update-message error"
            End If

        Catch ex As Exception
            lblUpdateMessage.Text = "Error updating information: " & ex.Message
            lblUpdateMessage.CssClass = "update-message error"
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