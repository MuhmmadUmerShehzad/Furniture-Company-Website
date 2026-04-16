<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PageLifeCycle.aspx.vb" Inherits="PageLifeCycleDemo" %>

    <!DOCTYPE html>
    <html>

    <head runat="server">
        <title>Page Processing Demo</title>
    </head>

    <body>

        <form id="form1" runat="server">

            <h2>Page Processing Events Demo</h2>

            <asp:Button ID="Button1" runat="server" Text="Click Me" OnClick="Button1_Click" />

            <br /><br />

            <div><a href="dashboard.html" class="btn">Back to Lab 04</a></div>

            <asp:Label ID="Label1" runat="server"></asp:Label>

        </form>

    </body>

    </html>