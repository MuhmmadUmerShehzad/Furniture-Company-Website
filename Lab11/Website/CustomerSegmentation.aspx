<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CustomerSegmentation.aspx.vb" Inherits="CustomerSegmentation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Customer Segmentation</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@500;600&display=swap');

        *, *::before, *::after {
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
            box-shadow: 0 1px 4px rgba(0,0,0,0.06);
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

                .navbar ul li a, .navbar a {
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

                    .navbar ul li a:hover, .navbar a:hover {
                        color: #8B7355;
                        border-bottom-color: #8B7355;
                    }

                    .navbar ul li a.active {
                        color: #8B7355;
                        border-bottom-color: #8B7355;
                    }

        .btn-logout {
    position: absolute;
    right: 20px;
    padding: 11px 28px;
    font-family: 'Inter', Arial, sans-serif;
    font-size: 0.8rem;
    font-weight: 600;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    color: #ffffff;
    background: #8B7355;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.22s ease, transform 0.22s ease;
}

.btn-logout:hover {
    background: #a93226;
    transform: translateY(-1px);
}

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

        /* ── Main Layout ── */
        .page-wrapper {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 24px 60px;
        }

        .page-title {
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 1.5rem;
            color: #2C3E50;
            margin-bottom: 6px;
        }

        .page-subtitle {
            font-size: 0.875rem;
            color: #8A8A8A;
            margin-bottom: 32px;
        }

        /* ── Threshold Controls ── */
        .threshold-card {
            background: #ffffff;
            border: 1px solid #E2DDD6;
            border-radius: 12px;
            padding: 24px 32px;
            margin-bottom: 36px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end;
            gap: 24px;
        }

        .threshold-field {
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex: 1;
            min-width: 180px;
        }

            .threshold-field label {
                font-size: 0.8rem;
                font-weight: 600;
                color: #8A8A8A;
                text-transform: uppercase;
                letter-spacing: 0.04em;
            }

            .threshold-field input[type="text"] {
                padding: 10px 14px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.9rem;
                color: #2C3E50;
                background: #F8F6F2;
                border: 1px solid #E2DDD6;
                border-radius: 6px;
                outline: none;
                width: 100%;
            }

                .threshold-field input[type="text"]:focus {
                    border-color: #8B7355;
                    box-shadow: 0 0 0 3px rgba(139,115,85,0.15);
                    background: #ffffff;
                }

        .btn-analyze {
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
            transition: background 0.22s ease, transform 0.22s ease;
            white-space: nowrap;
        }

            .btn-analyze:hover {
                background: #2C3E50;
                transform: translateY(-1px);
            }

        .segments-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 24px;
        }

        @media (max-width: 1000px) {
            .segments-grid {
                grid-template-columns: 1fr;
            }
        }

        .segment-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #E2DDD6;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            overflow: hidden;
            font-size: 10px;
        }

        .segment-header {
            padding: 18px 24px 14px;
            border-bottom: 1px solid #E2DDD6;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .segment-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .icon-premium {
            background: #FFF3CD;
        }

        .icon-frequent {
            background: #D4EDDA;
        }

        .icon-bulk {
            background: #D1ECF1;
        }

        .segment-title {
            font-family: 'Playfair Display', Georgia, serif;
            font-size: 1.05rem;
            font-weight: 600;
            color: #2C3E50;
        }

        .segment-desc {
            font-size: 0.75rem;
            color: #8A8A8A;
            margin-top: 2px;
        }

        .segment-body {
            padding: 16px 0 20px;
        }

        .segment-count {
            padding: 0 24px 12px;
            font-size: 0.8rem;
            color: #8A8A8A;
        }

            .segment-count span {
                font-size: 1.4rem;
                font-weight: 700;
                color: #2C3E50;
                margin-right: 4px;
            }

        .seg-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.82rem;
        }

            .seg-table th {
                background: #F8F6F2;
                color: #8A8A8A;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.72rem;
                letter-spacing: 0.04em;
                padding: 9px 16px;
                text-align: left;
                border-bottom: 1px solid #E2DDD6;
            }

            .seg-table td {
                padding: 10px 16px;
                border-bottom: 1px solid #F0EDE8;
                color: #2C3E50;
            }

            .seg-table tr:last-child td {
                border-bottom: none;
            }

            .seg-table tr:hover td {
                background: #FDFAF7;
            }

        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 99px;
            font-size: 0.72rem;
            font-weight: 600;
        }

        .badge-premium {
            background: #FFF3CD;
            color: #856404;
        }

        .badge-frequent {
            background: #D4EDDA;
            color: #155724;
        }

        .badge-bulk {
            background: #D1ECF1;
            color: #0C5460;
        }

        .badge-standard {
            background: #E2DDD6;
            color: #8A8A8A;
        }

        .btn-action {
            padding: 5px 10px;
            font-family: 'Inter', Arial, sans-serif;
            font-size: 0.72rem;
            font-weight: 600;
            text-transform: uppercase;
            color: #ffffff;
            background: #8B7355;
            border: 1px solid #8B7355;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.22s ease, color 0.22s ease;
        }

            .btn-action:hover {
                background: #2C3E50;
                border-color: #2C3E50;
            }

            .btn-action.outline {
                background: transparent;
                color: #8B7355;
            }

                .btn-action.outline:hover {
                    background: #8B7355;
                    color: #ffffff;
                }

        .empty-msg {
            padding: 24px;
            text-align: center;
            color: #8A8A8A;
            font-size: 0.85rem;
        }

        /* ── Summary Bar ── */
        .summary-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 28px;
            flex-wrap: wrap;
        }

        .summary-tile {
            flex: 1;
            min-width: 140px;
            background: #ffffff;
            border: 1px solid #E2DDD6;
            border-radius: 10px;
            padding: 16px 20px;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

            .summary-tile .val {
                font-size: 1.6rem;
                font-weight: 700;
                color: #2C3E50;
            }

            .summary-tile .lbl {
                font-size: 0.75rem;
                color: #8A8A8A;
                text-transform: uppercase;
                letter-spacing: 0.04em;
                font-weight: 600;
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
                    <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label>
                </div>
                <div class="user-info-label" style="margin-top: 8px;">Role</div>
                <div class="user-info-value">
                    <asp:Label ID="lblRole" runat="server" Text=""></asp:Label>
                </div>
            </div>
            <ul>
                <li>
                    <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="UserRegistration.aspx" Text="Registration" /></li>
                <li>
                    <asp:HyperLink ID="lnkProducts" runat="server" NavigateUrl="Products.aspx" Text="Products" /></li>
                <li>
                    <asp:HyperLink ID="lnkCatalog" runat="server" NavigateUrl="Catalog.aspx" Text="Catalog" /></li>
                <li>
                    <asp:HyperLink ID="lnkSegmentation" runat="server" NavigateUrl="CustomerSegmentation.aspx" CssClass="active" Text="Segmentation" /></li>
                <li>
                    <asp:HyperLink ID="lnkForecasting" runat="server" NavigateUrl="DemandForecasting.aspx" Text="Forecasting" /></li>
                <li>
                    <asp:HyperLink ID="lnkPayment" runat="server" NavigateUrl="Payment.aspx" Text="Payment" /></li>
            </ul>
            <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" />
        </nav>

        <div class="page-wrapper">

            <h2 class="page-title">Customer Segmentation Analysis</h2>
            <p class="page-subtitle">Segment customers by purchase behaviour adjust thresholds then click Analyse.</p>

            <%-- Threshold Controls --%>
            <div class="threshold-card">
                <div class="threshold-field">
                    <label>Premium Threshold (min. total spend)</label>
                    <asp:TextBox ID="txtPremiumThreshold" runat="server" Text="3000" />
                </div>
                <div class="threshold-field">
                    <label>Frequent Threshold (min. orders)</label>
                    <asp:TextBox ID="txtFrequentThreshold" runat="server" Text="3" />
                </div>
                <div class="threshold-field">
                    <label>Bulk Threshold (min. avg qty/order)</label>
                    <asp:TextBox ID="txtBulkThreshold" runat="server" Text="5" />
                </div>
                <asp:Button ID="btnAnalyse" runat="server" Text="Analyse" CssClass="btn-analyze" />
            </div>

            <%-- Summary Tiles --%>
            <div class="summary-bar">
                <div class="summary-tile">
                    <div class="val">
                        <asp:Label ID="lblTotalCustomers" runat="server" Text="—" /></div>
                    <div class="lbl">Total Customers</div>
                </div>
                <div class="summary-tile">
                    <div class="val">
                        <asp:Label ID="lblPremiumCount" runat="server" Text="—" /></div>
                    <div class="lbl">Premium</div>
                </div>
                <div class="summary-tile">
                    <div class="val">
                        <asp:Label ID="lblFrequentCount" runat="server" Text="—" /></div>
                    <div class="lbl">Frequent</div>
                </div>
                <div class="summary-tile">
                    <div class="val">
                        <asp:Label ID="lblBulkCount" runat="server" Text="—" /></div>
                    <div class="lbl">Bulk Buyers</div>
                </div>
            </div>

            <%-- Segment Cards --%>
            <div class="segments-grid">

                <%-- PREMIUM --%>
                <div class="segment-card">
                    <div class="segment-header">
                        <div>
                            <div class="segment-title">Premium Customers</div>
                            <div class="segment-desc">Highest total spend over all orders</div>
                        </div>
                    </div>
                    <div class="segment-body">
                        <div class="segment-count">
                            <span>
                                <asp:Label ID="lblPremiumGridCount" runat="server" Text="0" /></span> customers
                        </div>
                        <asp:GridView ID="gvPremium" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="seg-table"
                            GridLines="None"
                            EmptyDataText="">
                            <Columns>
                                <asp:BoundField DataField="Customer_Name" HeaderText="Name" />
                                <asp:BoundField DataField="Total_Spend" HeaderText="Total Spend" DataFormatString="{0:C}" />
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <%# If(System.Convert.ToDecimal(Eval("Total_Spend")) >= 10000, "<span class='badge badge-premium'>Royal</span>", "<span class='badge badge-standard'>Standard</span>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Targeted Action">
                                    <ItemTemplate>
                                        <%# If(System.Convert.ToDecimal(Eval("Total_Spend")) >= 10000, "<button type='button' class='btn-action' onclick='alert(""Complimentary Gift Dispatched!"")'>Send Gift</button>", "<button type='button' class='btn-action outline' onclick='alert(""Thank You SMS Sent!"")'>Send SMS</button>") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblPremiumEmpty" runat="server" CssClass="empty-msg" Text="No customers meet this threshold." Visible="false" />
                    </div>
                </div>

                <%-- FREQUENT --%>
                <div class="segment-card">
                    <div class="segment-header">
                        <div>
                            <div class="segment-title">Frequent Customers</div>
                            <div class="segment-desc">Revisit frequently to place orders</div>
                        </div>
                    </div>
                    <div class="segment-body">
                        <div class="segment-count">
                            <span>
                                <asp:Label ID="lblFrequentGridCount" runat="server" Text="0" /></span> customers
                        </div>
                        <asp:GridView ID="gvFrequent" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="seg-table"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="Customer_Name" HeaderText="Name" />
                                <asp:BoundField DataField="Order_Count" HeaderText="Orders" />
                                <asp:TemplateField HeaderText="Reward">
                                    <ItemTemplate>
                                        <span class='badge badge-frequent'>Priority Support</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblFrequentEmpty" runat="server" CssClass="empty-msg" Text="No customers meet this threshold." Visible="false" />
                    </div>
                </div>

                <%-- BULK --%>
                <div class="segment-card">
                    <div class="segment-header">
                        <div>
                            <div class="segment-title">Bulk Buyers</div>
                            <div class="segment-desc">High average quantity per order</div>
                        </div>
                    </div>
                    <div class="segment-body">
                        <div class="segment-count">
                            <span>
                                <asp:Label ID="lblBulkGridCount" runat="server" Text="0" /></span> customers
                        </div>
                        <asp:GridView ID="gvBulk" runat="server"
                            AutoGenerateColumns="False"
                            CssClass="seg-table"
                            GridLines="None">
                            <Columns>
                                <asp:BoundField DataField="Customer_Name" HeaderText="Name" />
                                <asp:BoundField DataField="Avg_Qty" HeaderText="Avg Qty" DataFormatString="{0:F1}" />
                                <asp:TemplateField HeaderText="Marketing Action">
                                    <ItemTemplate>
                                        <button type='button' class='btn-action' onclick='alert("30% Unit Discount Email Sent!")'>Send Discount</button>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblBulkEmpty" runat="server" CssClass="empty-msg" Text="No customers meet this threshold." Visible="false" />
                    </div>
                </div>

            </div>
        </div>

    </form>
</body>
</html>
