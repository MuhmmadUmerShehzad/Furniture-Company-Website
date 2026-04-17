
Partial Class Payment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ' Show Catalog link only for admin
        If Session("User_Role") = "admin" Then
            pnlCatalog.Visible = True
        Else
            pnlCatalog.Visible = False
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
