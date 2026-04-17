<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Products.aspx.vb" Inherits="Products" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Products — Pine Valley Furniture</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@500;600&display=swap');

            *,
            *::before,
            *::after {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Inter', Arial, sans-serif;
                background-color: #F8F6F2;
                color: #2C3E50;
                min-height: 100vh;
            }

            h1 {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.75rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                color: #ffffff;
                background: #2C3E50;
                padding: 22px 40px;
                text-align: center;
                border-bottom: 3px solid #8B7355;
            }

            /* ── Navbar ── */
            .navbar {
                background-color: #ffffff;
                border-bottom: 1px solid #E2DDD6;
                display: flex;
                justify-content: center;
                align-items: center;
                box-shadow: 0 1px 4px rgba(0, 0, 0, 0.06);
                position: sticky;
                top: 0;
                z-index: 100;
            }

            .navbar ul {
                list-style: none;
                display: flex;
                gap: 2px;
                padding: 0 10px;
            }

            .navbar ul li a,
            .navbar a {
                display: block;
                padding: 14px 20px;
                text-decoration: none;
                color: #8A8A8A;
                font-weight: 500;
                font-size: 0.875rem;
                letter-spacing: 0.03em;
                text-transform: uppercase;
                border-bottom: 2px solid transparent;
                transition: color 0.22s ease, border-color 0.22s ease;
            }

            .navbar ul li a:hover,
            .navbar a:hover {
                color: #8B7355;
                border-bottom-color: #8B7355;
            }

            .btn-logout {
                position: absolute;
                right: 20px;
                padding: 8px 20px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.8rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                color: #ffffff;
                background: #C0392B;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.22s ease, transform 0.22s ease;
            }

            .btn-logout:hover {
                background: #a93226;
                transform: translateY(-1px);
            }

            /* ── Content Card ── */
            .content {
                max-width: 960px;
                margin: 48px auto;
                padding: 40px 48px;
                background: #ffffff;
                border-radius: 16px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.10);
                border: 1px solid #E2DDD6;
            }

            .content h3 {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.35rem;
                font-weight: 500;
                color: #2C3E50;
                margin-bottom: 28px;
                padding-bottom: 12px;
                border-bottom: 1px solid #E2DDD6;
            }

            /* ── Search row ── */
            .search-row {
                display: flex;
                gap: 10px;
                align-items: center;
                margin-bottom: 24px;
                flex-wrap: wrap;
            }

            .search-row input[type="text"] {
                max-width: 280px;
                margin-bottom: 0;
            }

            .search-row input[type="submit"] {
                margin-top: 0;
            }

            input[type="text"] {
                padding: 11px 16px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.9rem;
                color: #2C3E50;
                background: #F8F6F2;
                border: 1px solid #E2DDD6;
                border-radius: 6px;
                outline: none;
                display: block;
                margin-bottom: 14px;
            }

            input[type="text"]:focus {
                border-color: #8B7355;
                box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.15);
                background: #ffffff;
            }

            input[type="submit"] {
                display: inline-block;
                padding: 11px 28px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.875rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                color: #ffffff;
                background: #8B7355;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 8px;
                transition: background 0.22s ease, transform 0.22s ease;
            }

            input[type="submit"]:hover {
                background: #2C3E50;
                transform: translateY(-1px);
            }

            /* ── Products Table ── */
            .products-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 24px;
                font-size: 0.9rem;
            }

            .products-table thead tr {
                background: #2C3E50;
                color: #ffffff;
            }

            .products-table thead th {
                padding: 13px 18px;
                text-align: left;
                font-weight: 600;
                font-size: 0.8rem;
                letter-spacing: 0.06em;
                text-transform: uppercase;
            }

            .products-table tbody tr {
                border-bottom: 1px solid #E2DDD6;
                transition: background 0.18s ease;
            }

            .products-table tbody tr:last-child {
                border-bottom: none;
            }

            .products-table tbody tr:hover {
                background: #F8F6F2;
            }

            .products-table tbody td {
                padding: 13px 18px;
                color: #2C3E50;
                vertical-align: middle;
            }

            .products-table tbody td:first-child {
                font-weight: 600;
                color: #8B7355;
                width: 80px;
            }

            .help-link {
                display: inline-block;
                margin-top: 24px;
                text-decoration: none;
                color: #8A8A8A;
                font-size: 0.825rem;
                padding: 7px 16px;
                background: #F8F6F2;
                border: 1px solid #E2DDD6;
                border-radius: 99px;
                transition: color 0.22s ease, border-color 0.22s ease;
            }

            .help-link:hover {
                color: #8B7355;
                border-color: #8B7355;
            }
        </style>
    </head>

    <body>

        <form id="form1" runat="server">

            <h1>Pine Valley Furniture</h1>

            <nav class="navbar">
                <ul>
                    <li>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="UserRegistration.aspx"
                            Text="Registration" />
                    </li>
                    <li>
                        <asp:HyperLink ID="lnkProducts" runat="server" NavigateUrl="Products.aspx" Text="Products" />
                    </li>
                    <asp:Panel ID="pnlCatalog" runat="server" Visible="false">
                        <li>
                            <asp:HyperLink ID="lnkCatalog" runat="server" NavigateUrl="Catalog.aspx" Text="Catalog" />
                        </li>
                    </asp:Panel>
                    <li>
                        <asp:HyperLink ID="lnkPayment" runat="server" NavigateUrl="Payment.aspx" Text="Payment" />
                    </li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout"
                    OnClick="btnLogout_Click" />
            </nav>

            <div class="content">
                <h3>Products</h3>

                <div class="search-row">
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search for Products" />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                    <asp:Button ID="ShowAll" runat="server" Text="Show All" OnClick="LoadProducts" />
                </div>

                <table class="products-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Product Description</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptProdcuts" runat="server" OnItemCommand="rptProdcuts_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <%# Eval("Product_Id") %>
                                    </td>
                                    <td>
                                        <%# Eval("Product_Description") %>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnOrder" runat="server" Text="Order Now" CommandName="Order"
                                            CommandArgument='<%# Eval("Product_Id") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>

                <asp:HyperLink ID="lnkHelpPage" runat="server" NavigateUrl="HelpPage.aspx" CssClass="help-link"
                    Text="Need help?" />
            </div>

        </form>

    </body>

    </html>