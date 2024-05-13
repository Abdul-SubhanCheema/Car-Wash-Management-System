<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userbooking.aspx.cs" Inherits="WebApplication2.userbooking" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>User Booking Details</title>
    <style>
        /* CSS styles for the Repeater items */
        .booking-item {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 10px;
            background-color: #f9f9f9;
        }

        /* CSS styles for individual item properties */
        .booking-id-label {
            font-weight: bold;
            color: #333;
        }

        .booking-status-label {
            color: #777;
        }
        a{
            display:flex;
            justify-content:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>User Booking Details</h2>

            <asp:Repeater ID="BookingDetailsRepeater" runat="server">
                <ItemTemplate>
                    <div class="booking-item">
                        <span class="booking-id-label">Booking ID:</span> <%# Eval("BookingId") %><br />
                        <span class="booking-status-label">Status:</span> <%# Eval("Status") %><br />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <a href="<%= ResolveUrl("~/Home.aspx") %>">Back</a>
    </form>
</body>
</html>
