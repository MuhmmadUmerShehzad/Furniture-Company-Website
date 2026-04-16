<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UserRegsistration.aspx.vb" Inherits="UserRegsistration" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Registration — Pine Valley Furniture</title>
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

            .customer-info {
                position: absolute;
                left: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                color: #8B7355;
                letter-spacing: 0.02em;
            }

            /* ── Content Cards ── */
            .page-wrapper {
                max-width: 860px;
                margin: 48px auto;
                display: flex;
                flex-direction: column;
                gap: 32px;
                padding: 0 16px 48px;
            }

            .content {
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

            .section-badge {
                display: inline-block;
                font-size: 0.7rem;
                font-weight: 600;
                letter-spacing: 0.08em;
                text-transform: uppercase;
                padding: 3px 10px;
                border-radius: 99px;
                margin-bottom: 18px;
            }

            .badge-register {
                background: #EAF4EC;
                color: #27AE60;
            }

            .badge-update {
                background: #FEF3E2;
                color: #E67E22;
            }

            label {
                display: block;
                font-size: 0.8rem;
                font-weight: 500;
                color: #6B7280;
                margin-bottom: 5px;
                letter-spacing: 0.02em;
                text-transform: uppercase;
            }

            .field-group {
                margin-bottom: 14px;
            }

            input[type="text"] {
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
            }

            input[type="text"]:focus {
                border-color: #8B7355;
                box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.15);
                background: #ffffff;
            }

            .admin-field input[type="text"] {
                border-color: #E8C98A;
                background: #FFFBF2;
            }

            .admin-field input[type="text"]:focus {
                border-color: #E67E22;
                box-shadow: 0 0 0 3px rgba(230, 126, 34, 0.15);
            }

            .btn-register {
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

            .btn-register:hover {
                background: #2C3E50;
                transform: translateY(-1px);
            }

            .btn-update {
                display: inline-block;
                padding: 11px 32px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.875rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                color: #ffffff;
                background: #E67E22;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-top: 8px;
                transition: background 0.22s ease, transform 0.22s ease;
            }

            .btn-update:hover {
                background: #CA6F1E;
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
                font-size: 0.875rem;
                font-weight: 500;
            }
        </style>
    </head>

    <body>

        <form id="form1" runat="server">

            <h1>Pine Valley Furniture</h1>

            <nav class="navbar">
                <ul>
                    <li>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="UserRegsistration.aspx"
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
                <asp:Label ID="lblCustomerName" runat="server" CssClass="customer-info" />
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout"
                    OnClick="btnLogout_Click" />
            </nav>

            <div class="page-wrapper">

                <!-- ── Register New Customer ── -->
                <div class="content">
                    <span class="section-badge badge-register">New</span>
                    <h3>Register New Customer</h3>

                    <div class="field-group">
                        <label for="txtName">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" placeholder="Full Name" />
                    </div>
                    <div class="field-group">
                        <label for="txtAddress">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" placeholder="Address" />
                    </div>
                    <div class="field-group">
                        <label for="txtCity">City</label>
                        <asp:TextBox ID="txtCity" runat="server" placeholder="City" />
                    </div>
                    <div class="field-group">
                        <label for="txtState">State</label>
                        <asp:TextBox ID="txtState" runat="server" placeholder="State (e.g. NY)" MaxLength="2" />
                    </div>
                    <div class="field-group">
                        <label for="txtPostal">Postal Code</label>
                        <asp:TextBox ID="txtPostal" runat="server" placeholder="Postal Code" />
                    </div>

                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register"
                        OnClick="btnRegister_Click" />
                    <asp:Label ID="lblRegisterMsg" runat="server" CssClass="msg-label" />

                    <br />
                    <asp:HyperLink ID="lnkHelpPage" runat="server" NavigateUrl="HelpPage.aspx" CssClass="help-link"
                        Text="Need help?" />
                </div>

                <!-- ── Update Customer ── -->
                <div class="content">
                    <span class="section-badge badge-update">Update</span>
                    <h3>Update Customer Information</h3>

                    <%-- Admin-only: target a specific Customer ID --%>
                        <asp:Panel ID="pnlAdminCustomerId" runat="server" Visible="false"
                            CssClass="field-group admin-field">
                            <label for="txtUpdateCustomerId">Customer ID <small style="color:#E67E22;">(Admin – leave
                                    blank to skip)</small></label>
                            <asp:TextBox ID="txtUpdateCustomerId" runat="server" placeholder="Customer ID to update" />
                        </asp:Panel>

                        <div class="field-group">
                            <label for="txtUpdName">Full Name</label>
                            <asp:TextBox ID="txtUpdName" runat="server" placeholder="Full Name" />
                        </div>
                        <div class="field-group">
                            <label for="txtUpdAddress">Address</label>
                            <asp:TextBox ID="txtUpdAddress" runat="server" placeholder="Address" />
                        </div>
                        <div class="field-group">
                            <label for="txtUpdCity">City</label>
                            <asp:TextBox ID="txtUpdCity" runat="server" placeholder="City" />
                        </div>
                        <div class="field-group">
                            <label for="txtUpdState">State</label>
                            <asp:TextBox ID="txtUpdState" runat="server" placeholder="State (e.g. NY)" MaxLength="2" />
                        </div>
                        <div class="field-group">
                            <label for="txtUpdPostal">Postal Code</label>
                            <asp:TextBox ID="txtUpdPostal" runat="server" placeholder="Postal Code" />
                        </div>

                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-update"
                            OnClick="btnUpdate_Click" />
                        <asp:Label ID="lblUpdateMsg" runat="server" CssClass="msg-label" />
                </div>

            </div>

        </form>

    </body>

    </html>