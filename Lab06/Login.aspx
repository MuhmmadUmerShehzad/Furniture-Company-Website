<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Login — Pine Valley Furniture</title>
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

            .login-wrapper {
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding: 60px 16px;
                min-height: calc(100vh - 90px);
            }

            .login-card {
                width: 100%;
                max-width: 420px;
                background: #ffffff;
                border: 1px solid #E2DDD6;
                border-radius: 16px;
                padding: 44px 40px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12);
            }

            .page-label {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.35rem;
                font-weight: 500;
                color: #2C3E50;
                text-align: center;
                margin-bottom: 32px;
                padding-bottom: 12px;
                border-bottom: 1px solid #E2DDD6;
            }

            input[type="text"],
            input[type="password"] {
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
                margin-bottom: 16px;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                border-color: #8B7355;
                box-shadow: 0 0 0 3px rgba(139, 115, 85, 0.15);
                background: #ffffff;
            }

            .login-actions {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-top: 8px;
            }

            input[type="submit"] {
                width: 100%;
                padding: 12px;
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
                margin-bottom: 0;
            }

            input[type="submit"]:hover {
                background: #2C3E50;
                transform: translateY(-1px);
            }

            .btn-secondary {
                width: 100%;
                padding: 12px;
                font-family: 'Inter', Arial, sans-serif;
                font-size: 0.875rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                color: #8B7355;
                background: transparent;
                border: 1.5px solid #8B7355;
                border-radius: 6px;
                cursor: pointer;
                transition: background 0.22s ease, color 0.22s ease;
            }

            .btn-secondary:hover {
                background: #8B7355;
                color: #ffffff;
            }

            .help-link {
                display: block;
                text-align: center;
                margin-top: 20px;
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

        <h1>Pine Valley Furniture</h1>

        <form id="form1" runat="server">
            <div class="login-wrapper">
                <div class="login-card">
                    <div class="page-label">Welcome Back</div>

                    <asp:TextBox ID="txtName" runat="server" placeholder="Enter Full Name" TextMode="SingleLine" />
                    <asp:TextBox ID="txtPassword" runat="server" placeholder="Enter Password" TextMode="Password" />

                    <div class="login-actions">
                        <asp:Button ID="btnLogin" runat="server" Text="Login" />
                    </div>

                    <asp:HyperLink ID="lnkHelpPage" runat="server" NavigateUrl="HelpPage.aspx" CssClass="help-link"
                        Text="Need help?" />
                </div>
            </div>
        </form>

    </body>

    </html>