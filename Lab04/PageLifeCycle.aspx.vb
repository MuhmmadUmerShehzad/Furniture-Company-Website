Partial Class PageLifeCycleDemo
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(sender As Object, e As EventArgs) Handles Me.Init
        Label1.Text &= "Page Init fired <br/>"
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Label1.Text &= "Page Load fired <br/>"
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Label1.Text &= "Button Click fired <br/>"
    End Sub

    Protected Sub Page_PreRender(sender As Object, e As EventArgs) Handles Me.PreRender
        Label1.Text &= "Page PreRender fired <br/>"
    End Sub

    Protected Sub Page_Unload(sender As Object, e As EventArgs) Handles Me.Unload
        Label1.Text &= "Page unload fired <br/>"
    End Sub

End Class