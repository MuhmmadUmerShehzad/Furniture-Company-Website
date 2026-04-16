Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class UserRegsistration
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ' Show Catalog link only for admin
        If Session("User_Role") = "admin" Then
            pnlCatalog.Visible = True
            pnlAdminCustomerId.Visible = True   ' Admin can target any Customer ID
        Else
            pnlCatalog.Visible = False
            pnlAdminCustomerId.Visible = False   ' Regular user: Customer ID comes from session
        End If
        LoadCustomerName()
        Debug.WriteLine("UserRegistration Page Load - Session Customer ID: " & If(Session("CustomerId") IsNot Nothing, Session("CustomerId").ToString(), "NULL"))
    End Sub

    Private Sub LoadCustomerName()
        Try
            ' Use stored username from session
            If Session("DbUser") IsNot Nothing Then
                Dim customerId As String = ""
                Dim displayName As String = Session("DbUser").ToString()
                
                ' Get Customer ID if available
                If Session("CustomerId") IsNot Nothing Then
                    customerId = Session("CustomerId").ToString()
                End If
                
                ' For regular users, try to get Customer_Name as well
                If Session("CustomerId") IsNot Nothing AndAlso Session("User_Role") <> "admin" Then
                    Using conn As New SqlConnection(connString)
                        conn.Open()
                        Dim cmd As New SqlCommand("SELECT Customer_Name FROM CUSTOMER_t WHERE Customer_Id = @id", conn)
                        cmd.Parameters.AddWithValue("@id", Session("CustomerId"))
                        Dim name As Object = cmd.ExecuteScalar()
                        If name IsNot Nothing AndAlso Not IsDBNull(name) Then
                            displayName = name.ToString()
                        End If
                    End Using
                End If
                
                ' Display customer ID and name
                If customerId <> "" Then
                    lblCustomerName.Text = "👤 ID: " & customerId & " | " & displayName
                Else
                    lblCustomerName.Text = "👤 " & displayName
                End If
            End If
        Catch
        End Try
    End Sub

    ' ── Register New Customer ──────────────────────────────────────────────────
    Protected Sub btnRegister_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRegister.Click

        Dim conn As New SqlConnection(connString)

        Try
            Dim customerId As Integer = New Random().Next(1000, 9999)

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code) VALUES (" & customerId & ", '" & txtName.Text & "', '" & txtAddress.Text & "', '" & txtCity.Text & "', '" & txtState.Text & "', '" & txtPostal.Text & "')"
            conn.Open()
            cmd.ExecuteNonQuery()

            lblRegisterMsg.Text = "Customer registered successfully!"
            lblRegisterMsg.ForeColor = Drawing.Color.Green
            Debug.WriteLine("Customer Registered Successfully")
        Catch ex As Exception
            lblRegisterMsg.Text = "Error: " & ex.Message
            lblRegisterMsg.ForeColor = Drawing.Color.Red
            Debug.WriteLine("Database Error: " & ex.Message)
        Finally
            conn.Close()
        End Try

    End Sub

    ' ── Update Customer ────────────────────────────────────────────────────────
    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpdate.Click

        ' Determine which Customer ID to update
        Dim targetId As String = ""

        If Session("User_Role") = "admin" AndAlso Not String.IsNullOrWhiteSpace(txtUpdateCustomerId.Text) Then
            ' Admin can supply any Customer ID
            targetId = txtUpdateCustomerId.Text.Trim()
        Else
            ' Regular user: always use their own session ID
            If Session("CustomerId") IsNot Nothing Then
                targetId = Session("CustomerId").ToString()
            End If
        End If

        If String.IsNullOrWhiteSpace(targetId) Then
            lblUpdateMsg.Text = "No Customer ID found. Please log in again."
            lblUpdateMsg.ForeColor = Drawing.Color.Red
            Return
        End If

        Dim conn As New SqlConnection(connString)

        Try
            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "UPDATE CUSTOMER_t SET " &
                              "Customer_Name    = '" & txtUpdName.Text & "', " &
                              "Customer_Address = '" & txtUpdAddress.Text & "', " &
                              "Customer_City    = '" & txtUpdCity.Text & "', " &
                              "Customer_State   = '" & txtUpdState.Text & "', " &
                              "Postal_Code      = '" & txtUpdPostal.Text & "' " &
                              "WHERE Customer_Id = " & targetId

            conn.Open()
            Dim rowsAffected As Integer = cmd.ExecuteNonQuery()

            If rowsAffected > 0 Then
                lblUpdateMsg.Text = "Customer updated successfully!"
                lblUpdateMsg.ForeColor = Drawing.Color.Green
            Else
                lblUpdateMsg.Text = "No customer found with that ID."
                lblUpdateMsg.ForeColor = Drawing.Color.OrangeRed
            End If

            Debug.WriteLine("Update executed for Customer_Id: " & targetId)
        Catch ex As Exception
            lblUpdateMsg.Text = "Error: " & ex.Message
            lblUpdateMsg.ForeColor = Drawing.Color.Red
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