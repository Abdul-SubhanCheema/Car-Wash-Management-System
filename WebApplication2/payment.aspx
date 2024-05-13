<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="WebApplication2.payment" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        #payment-summary {
            background-color: #fff;
            width: 400px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            text-align: left;
        }

        #service-list {
            margin-bottom: 20px;
        }

        #total-bill {
            font-weight: bold;
        }

        #payment_button {
            background-color: #cf2e2e;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #payment_button:hover {
            background-color: #666;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="payment-summary">
            <h2>Payment Summary</h2>
            <asp:Repeater ID="ServiceRepeater" runat="server">
                <ItemTemplate>
                    <p><strong><%# Eval("payservicename") %>:</strong> $<%# Eval("payserviceprice") %></p>
                </ItemTemplate>
            </asp:Repeater>
            <hr />

           <p id="total-bill">Total Bill: $<span id="Span1" runat="server">0.00</span></p>
           <p id="total-disc">Discount: $<span id="Span2" runat="server">0.00</span></p>

           <asp:Button ID="payment_button" runat="server" Text="Done" OnClick="processPayment"/>
        </div>
    </form>
</body>
</html>
