<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookingdetails.aspx.cs" Inherits="WebApplication2.Bookingdetails" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Booking List</title>
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

        .booking-item {
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

        .booking-item h2 {
            color: #cf2e2e;
            margin-bottom: 10px;
        }
        .service-item{
            text-decoration:none;
             color: #666;
             list-style-type:none;
        }
        .booking-item p {
            margin: 0;
            color: #666;
        }

        footer {
            background-color: #666;
            color: white;
            text-align: center;
            padding: 10px;
        }
        h2{
            display:flex;
            justify-content:center;
        }
        a{
                display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }
        #ProcessButton{
             background-color: #666;
             color: #fff;
             padding: 10px 20px;
             border: none;
             border-radius: 4px;
             cursor: pointer;
        }
         #ProcessButton:hover{
                 background-color: #cf2e2e;
         }
     
    </style>
</head>

<body>
     <form id="form1" runat="server">
    <header>
        <h1>
            <span class="car">CAR</span>
            <span class="wash">Wash</span>
        </h1>
    </header>

    <section>
        <h2>Booking List</h2>
        <asp:Repeater ID="BookingDetailsRepeater" runat="server">
            <ItemTemplate>
                <div class="booking-item">
                    <h2>Booking #<%# Eval("BookingId") %></h2>
                    <p><strong>Name:</strong> <%# Eval("CustomerName") %></p>
                    <p><strong>Phone:</strong> <%# Eval("CustomerPhone") %></p>
                    <p><strong>Car Details:</strong> <%# Eval("VehicleMake") %> <%# Eval("VehicleModel") %>, <%# Eval("VehicleYear") %></p>
                    <p><strong>Status:</strong> <%# Eval("Status") %></p>
                    <asp:Button ID="ProcessButton" runat="server" 
                        Text="Process Booking" 
                        CommandArgument='<%# Eval("BookingId") %>' 
                        OnCommand="ProcessBooking_Command" 
                        Visible='<%# Eval("Status").ToString().ToLower() == "pending" %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </section>
    <a href="<%= ResolveUrl("~/Adminhome.aspx") %>">Back</a>
    <footer>
        &copy; 2023 Softhut. All rights reserved.
    </footer>
         </form>
</body>

</html>
