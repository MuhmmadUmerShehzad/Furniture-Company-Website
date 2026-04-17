Imports System.Diagnostics
Imports System.Configuration
Imports System.Data.SqlClient

Partial Class Catalog
    Inherits System.Web.UI.Page

    Dim connString As String = ConfigurationManager.ConnectionStrings("PVFC").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("User_Role") <> "admin" Then
            Response.Redirect("Login.aspx")
        End If



        If Not IsPostBack Then
            lblCustomerName.Text = Session("DbUser").ToString()
            If Session("Customer_Id") IsNot Nothing Then
                lblCustomerId.Text = Session("CustomerId").ToString()
            End If
        End If
    End Sub


    Protected Sub btnUpdateProduct_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddProduct.Click

        Dim productId As Integer
        Dim price As Decimal

        If Not Integer.TryParse(txtProductId.Text.Trim(), productId) Then
            lblMessage.Text = "Enter valid Product ID."
            lblMessage.ForeColor = Drawing.Color.Red
            Exit Sub
        End If

        If Not Decimal.TryParse(txtPrice.Text.Trim(), price) Then
            lblMessage.Text = "Enter valid price."
            lblMessage.ForeColor = Drawing.Color.Red
            Exit Sub
        End If

        Dim conn As New SqlConnection(connString)
        Try
            conn.Open()

            Dim checkCmd As New SqlCommand
            checkCmd.Connection = conn
            checkCmd.CommandText = "SELECT COUNT(*)"
            checkCmd.CommandText &= " FROM PRODUCT_t"
            checkCmd.CommandText &= " WHERE Product_Id="
            checkCmd.CommandText &= productId


            If CInt(checkCmd.ExecuteScalar()) = 0 Then
                lblMessage.Text = "Product ID does not exist."
                lblMessage.ForeColor = Drawing.Color.Red
                Exit Sub
            End If

            ' Update query (single line string)

            Dim cmd As New SqlCommand
            cmd.Connection = conn
            cmd.CommandText = "UPDATE PRODUCT_t"
            cmd.CommandText &= " SET Product_Description = '"
            cmd.CommandText &= txtDescription.Text.Trim()
            cmd.CommandText &= "', Product_Finish = '"
            cmd.CommandText &= txtFinish.Text.Trim()
            cmd.CommandText &= "', Standard_Price = "
            cmd.CommandText &= price
            cmd.CommandText &= " WHERE Product_Id = "
            cmd.CommandText &= productId


            cmd.ExecuteNonQuery()

            lblMessage.Text = "Product updated successfully!"
            lblMessage.ForeColor = Drawing.Color.Green

        Catch ex As Exception
            lblMessage.Text = "Error: " & ex.Message
            lblMessage.ForeColor = Drawing.Color.Red
        End Try
        conn.Close()

    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs)
        Session.Clear()
        Session.Abandon()
        Response.Redirect("Login.aspx")
    End Sub

End Class