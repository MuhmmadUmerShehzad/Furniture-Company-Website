<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelpPage.aspx.vb" Inherits="HelpPage" %>

    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Help — Pine Valley Furniture</title>
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

            .content h2 {
                font-family: 'Playfair Display', Georgia, serif;
                font-size: 1.5rem;
                color: #2C3E50;
                margin-bottom: 24px;
                padding-bottom: 12px;
                border-bottom: 1px solid #E2DDD6;
            }

            .content h3 {
                font-size: 1.0rem;
                font-weight: 600;
                color: #8B7355;
                margin: 20px 0 6px;
                letter-spacing: 0.02em;
            }

            .content p {
                font-size: 0.925rem;
                color: #8A8A8A;
                line-height: 1.75;
                margin-bottom: 8px;
            }
        </style>
    </head>

    <body>

        <form id="form1" runat="server">

            <h1>Pine Valley Furniture</h1>

            <nav class="navbar">
                <ul>
                    <li><a href="Login.aspx">Login</a></li>
                    <li><a href="CustomerSegmentation.aspx">Segmentation</a></li>
                </ul>
            </nav>

            <div class="content">
                <h2>Page Definitions</h2>

                <h3>Login</h3>
                <p>Allows existing users to authenticate and access their account using their credentials.</p>

                <h3>Registration</h3>
                <p>Enables new users to create an account by providing required personal and account information.</p>

                <h3>Products</h3>
                <p>Displays available furniture items with descriptions, images, and options to place an order.</p>

                <h3>Catalog</h3>
                <p>Admin-only page to add or update product listings in the store catalog.</p>

                <h3>Segmentation</h3>
                <p>Admin-only dashboard for analysing customer spend, order frequency, and bulk buying behaviour.</p>

                <h3>Order</h3>
                <p>Manages and displays orders placed by customers, including quantity and shipping details.</p>

                <h3>Payment</h3>
                <p>Handles payment processing and collection of billing information for completed purchases.</p>
            </div>

        </form>

    </body>

    </html>