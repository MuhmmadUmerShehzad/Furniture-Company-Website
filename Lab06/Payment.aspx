<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Payment.aspx.vb" Inherits="Payment" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Payment — Pine Valley Furniture</title>
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
                max-width: 860px;
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

            .form-row {
                display: flex;
                align-items: center;
                gap: 16px;
                margin-bottom: 16px;
            }

            .form-row label {
                min-width: 150px;
                font-size: 0.9rem;
                font-weight: 500;
                color: #2C3E50;
            }

            .form-row input[type="text"],
            .form-row input[type="password"],
            .form-row select {
                flex: 1;
            }

            input[type="text"],
            input[type="password"],
            select {
                width: 100%;
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

            input[type="text"]:focus,
            input[type="password"]:focus,
            select:focus {
                border-color: #8B7355;
                box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.15);
                background: #ffffff;
            }

            input[type="submit"] {
                display: inline-block;
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
                margin-top: 8px;
                transition: background 0.22s ease, transform 0.22s ease;
            }

            input[type="submit"]:hover {
                background: #2C3E50;
                transform: translateY(-1px);
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

            .msg-label {
                display: block;
                margin-top: 16px;
                font-size: 0.9rem;
                font-weight: 500;
                color: #8B7355;
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
                    <li>
                        <asp:HyperLink ID="lnkPayment" runat="server" NavigateUrl="Payment.aspx" Text="Payment" />
                    </li>
                </ul>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout"
                    OnClick="btnLogout_Click" />
            </nav>

            <div class="content">
                <h3>Payment</h3>

                <div class="form-row">
                    <label>Payment Method</label>
                    <asp:DropDownList ID="ddlPaymentMethod" runat="server">
                        <asp:ListItem Text="Credit Card" Value="Credit Card"></asp:ListItem>
                        <asp:ListItem Text="Sadapay" Value="Sadapay"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-row">
                    <label>Card Number</label>
                    <asp:TextBox ID="txtCardNumber" runat="server" placeholder="Card Number" />
                </div>

                <div class="form-row">
                    <label>CVV</label>
                    <asp:TextBox ID="txtCVV" runat="server" TextMode="Password" placeholder="CVV" />
                </div>

                <asp:Button ID="btnProceed" runat="server" Text="Proceed" OnClick="btnProceed_Click" />

                <asp:HyperLink ID="lnkHelp" runat="server" NavigateUrl="HelpPage.aspx" CssClass="help-link">
                    Need help?
                </asp:HyperLink>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg-label"></asp:Label>
            </div>

        </form>

    </body>

    </html>