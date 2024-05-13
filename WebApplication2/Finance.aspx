<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Finance.aspx.cs" Inherits="WebApplication2.Finance" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Finance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background-color: white;
            color: #666;
            padding: 10px;
            text-align: center;
        }

        h1 {
            text-align: center;
            font-family: Arial, sans-serif;
            color: #cf2e2e;
        }

        h1 span.car {
            color: #cf2e2e;
        }

        h1 span.wash {
            color: #666;
        }

        section {
            flex: 1;
            padding: 20px;
        }

        .finance-item {
            background-color: #fff;
            width: 80%;
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            text-align: left;
        }

        .finance-item h2 {
            color: #cf2e2e;
            margin-bottom: 10px;
        }

        .finance-item p {
            margin: 0;
            color: #666;
        }
        h1{
            display:flex;
            justify-content:center;
             color: #666;
        }
        footer {
            background-color: #666;
            color: white;
            text-align: center;
            padding: 10px;
        }
        a{
            display:flex;
            justify-content:center;

        }
    </style>
</head>

<body>
    <header>
        <h1>
            <span class="car">CAR</span>
            <span class="wash">Wash</span>
        </h1>
    </header>

    <section>
        <h1>Finance Overview</h1>

   
        <div class="finance-item">
            <asp:Repeater ID="PaymentInfoRepeater" runat="server">
            <ItemTemplate>
                <div class="payment-item">
                    <h2>Payment for Booking #<%# Eval("BookingId") %></h2>
                    <p><strong>Customer:</strong> <%# Eval("CustomerName") %></p>
                    <p><strong>Date:</strong> <%# Eval("PaymentDate", "{0:dd/MM/yyyy}") %></p>
                    <p><strong>Amount:</strong> $<%# Eval("PaymentAmount") %></p>
                    <p><strong>Discount:</strong> $<%# Eval("Discounts") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        </div>
    </section>
       <a href="<%= ResolveUrl("~/Adminhome.aspx") %>">Back</a>
    <footer>
        &copy; 2023 Softhut. All rights reserved.
    </footer>
</body>

</html>
