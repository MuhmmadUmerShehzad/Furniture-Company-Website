Imports System
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Diagnostics

Partial Class Login
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click

        Try
            Dim conn As New SqlConnection(connString)
            conn.Open()

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "SELECT * FROM Users WHERE Username = '"
            cmd.CommandText &= txtName.Text & "' AND User_Password = '"
            cmd.CommandText &= txtPassword.Text & "'"

            Dim reader As SqlDataReader = cmd.ExecuteReader()

            If reader.Read() Then


                Debug.WriteLine(reader)

                Session("UserId") = reader("UserId").ToString()
                Try
                    Session("CustomerId") = reader("Customer_Id").ToString()
                Catch ex As Exception
                    Debug.WriteLine("Customer Id is NULL")
                End Try
                Session("DbUser") = txtName.Text
                Session("DbPass") = txtPassword.Text
                Session("User_Role") = reader("User_Role").ToString()

                reader.Close()
                conn.Close()

                Response.Redirect("Products.aspx")

            Else
                reader.Close()
                conn.Close()
                Response.Write("<script>alert('Invalid Username or Password');</script>")
            End If

        Catch ex As Exception
            Response.Write("<script>alert('Invalid Creditentials');</script>")
        End Try

    End Sub

End Class