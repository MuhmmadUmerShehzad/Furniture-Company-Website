<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Products.aspx.vb" Inherits="Products" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Products</title>
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

        /* ── User Info Display ── */
        .user-info {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .user-info-label {
            font-size: 0.75rem;
            color: #8A8A8A;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .user-info-value {
            font-size: 0.95rem;
            color: #2C3E50;
            font-weight: 600;
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

        /* ── Recommendations (Premium Styles) ── */
        .recommendations-container {
            margin-bottom: 32px;
            padding: 24px;
            background: #FCFAF7;
            border: 1px solid #E9E4DC;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(139, 115, 85, 0.08);
        }

            .recommendations-container h3 {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.15rem;
                color: #2C3E50;
                margin-bottom: 20px;
                padding-bottom: 8px;
                border-bottom: 2px solid #8B7355;
                display: inline-block;
            }

        .recommendation-table thead tr {
            background: #8B7355 !important;
        }

        .reorder-table thead tr {
            background: #5D6D7E !important;
        }

        .no-data-label {
            display: block;
            margin-bottom: 24px;
            padding: 12px 20px;
            background: #FDFEFE;
            border: 1px dashed #E2DDD6;
            border-radius: 6px;
            color: #8A8A8A;
            font-style: italic;
            font-size: 0.875rem;
            text-align: center;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <h1>Pine Valley Furniture</h1>

        <nav class="navbar">
            <div class="user-info">
                <div class="user-info-label">Logged In As</div>
                <div class="user-info-value">
                    <asp:Label ID="lblCustomerName" runat="server" Text=""></asp:Label>
                </div>
                <div class="user-info-label" style="margin-top: 8px;">Customer ID</div>
                <div class="user-info-value">
                    <asp:Label ID="lblCustomerId" runat="server" Text=""></asp:Label>
                </div>
            </div>
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
                <asp:Panel ID="pnlSegmentation" runat="server" Visible="false">
                    <li>
                        <asp:HyperLink ID="lnkSegmentation" runat="server" NavigateUrl="CustomerSegmentation.aspx" Text="Segmentation" />
                    </li>
                    <li>
                        <asp:HyperLink ID="lnkForecasting" runat="server" NavigateUrl="DemandForecasting.aspx" Text="Forecasting" />
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
                <asp:Button ID="btnShowReorder" runat="server" Text="Reorder Suggestions" OnClick="btnShowReorder_Click" />
            </div>

            <!-- Recommendations Section (Moved to Top) -->
            <asp:Panel ID="pnlRecommendations" runat="server" Visible="false" CssClass="recommendations-container">
                <h3>🔍 Customers who bought this also bought...</h3>
                <asp:Repeater ID="rptRecommendations" runat="server">
                    <HeaderTemplate>
                        <table class="products-table recommendation-table">
                            <thead>
                                <tr>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Frequency</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.DataItem("description") %></td>
                            <td>$<%# Container.DataItem("price") %></td>
                            <td><%# Container.DataItem("freq") %> times</td>
                            <td>
                                <asp:Button ID="btnOrderRec" runat="server" Text="Order Now"
                                    CommandName="Order"
                                    CommandArgument='<%# Container.DataItem("productId") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:Panel>

            <asp:Label ID="lblNoRecommendations" runat="server" Visible="false" CssClass="no-data-label"></asp:Label>

            <!-- REORDER SUGGESTIONS PANEL (Moved to Top) -->
            <asp:Panel ID="pnlReorder" runat="server" Visible="false" CssClass="recommendations-container reorder-panel">
                <h3>Previously Ordered Items (Reorder)</h3>

                <asp:Repeater ID="rptReorder" runat="server">
                    <HeaderTemplate>
                        <table class="products-table reorder-table">
                            <thead>
                                <tr>
                                    <th>Description</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# Container.DataItem("description") %></td>
                            <td>$<%# Container.DataItem("price") %></td>
                            <td>
                                <asp:Button ID="btnReorderItem" runat="server" Text="Order Now"
                                    CommandName="Order"
                                    CommandArgument='<%# Container.DataItem("productId") %>' />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:Panel>

            <table class="products-table">
                <thead>
                    <tr>
                        <th>Product Description</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptProdcuts" runat="server" OnItemCommand="rptProdcuts_ItemCommand">
                        <ItemTemplate>
                            <tr>
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
