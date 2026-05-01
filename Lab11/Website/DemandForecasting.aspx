<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DemandForecasting.aspx.vb" Inherits="DemandForecasting" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Demand Forecasting — Pine Valley Furniture</title>
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

        .forecast-controls {
            display: flex;
            gap: 16px;
            align-items: center;
            margin-bottom: 32px;
            padding: 20px;
            background: #F8F6F2;
            border-radius: 8px;
        }

        select {
            flex: 1;
            padding: 11px 16px;
            font-family: 'Inter', Arial, sans-serif;
            font-size: 0.9rem;
            color: #2C3E50;
            background: #ffffff;
            border: 1px solid #E2DDD6;
            border-radius: 6px;
            outline: none;
        }

        input[type="submit"] {
            padding: 11px 32px;
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
            transition: background 0.22s ease;
        }

            input[type="submit"]:hover {
                background: #2C3E50;
            }

        /* ── Forecast Table ── */
        .forecast-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 24px;
        }

            .forecast-table thead tr {
                background: #2C3E50;
                color: #ffffff;
            }

            .forecast-table th, .forecast-table td {
                padding: 14px 18px;
                text-align: left;
                border-bottom: 1px solid #E2DDD6;
            }

            .forecast-table th {
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

        .impact-high {
            color: #C0392B;
            font-weight: 700;
        }

        .impact-label {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 99px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .label-predicted {
            background: #E8F6F3;
            color: #16A085;
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
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <h1>Pine Valley Furniture</h1>

        <nav class="navbar">
            <div class="user-info">
                <div class="user-info-label">Manager Access</div>
                <div class="user-info-value">
                    <asp:Label ID="lblCustomerName" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <ul>
                <li><a href="Products.aspx">Products</a></li>
                <li><a href="Catalog.aspx">Catalog</a></li>
                <li><a href="CustomerSegmentation.aspx">Segmentation</a></li>
                <li><a href="DemandForecasting.aspx" style="color: #8B7355; border-bottom-color: #8B7355;">Forecasting</a></li>
            </ul>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
        </nav>

        <div class="content">
            <h3>Inventory Demand Forecasting</h3>
            <p style="color: #8A8A8A; font-size: 0.9rem; margin-bottom: 24px;">
                Select a primary product to forecast demand for secondary/complementary items based on historical purchasing patterns.
            </p>

            <div class="forecast-controls">
                <asp:DropDownList ID="ddlPrimaryProduct" runat="server" DataTextField="Product_Description" DataValueField="Product_Id">
                </asp:DropDownList>
                <asp:Button ID="btnForecast" runat="server" Text="Generate Forecast" OnClick="btnForecast_Click" />
            </div>

            <asp:Panel ID="pnlForecastResults" runat="server" Visible="false">
                <asp:Repeater ID="rptForecast" runat="server">
                    <HeaderTemplate>
                        <table class="forecast-table">
                            <thead>
                                <tr>
                                    <th>Secondary Product</th>
                                    <th>Co-occurrence Count</th>
                                    <th>Predicted Impact</th>
                                    <th>Inventory Alert</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><strong><%# Container.DataItem("description") %></strong></td>
                            <td><%# Container.DataItem("coCount") %> times bought together</td>
                            <td>
                                <span class="impact-high">+<%# Math.Round(Convert.ToDouble(Container.DataItem("coCount")) * 1.5, 0) %>% Predicted Increase</span>
                            </td>
                            <td>
                                <span class="impact-label label-predicted">Refill Suggested</span>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:Panel>

            <asp:Label ID="lblNoData" runat="server" Text="No secondary demand patterns found for this product." Visible="false" 
                style="display:block; text-align:center; padding: 40px; color: #8A8A8A; font-style: italic; border: 1px dashed #E2DDD6; border-radius: 8px;"></asp:Label>

            <asp:HyperLink ID="lnkHelp" runat="server" NavigateUrl="HelpPage.aspx" CssClass="help-link">
                Need help with forecasting?
            </asp:HyperLink>
        </div>

    </form>

</body>

</html>
