<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Bookingform.aspx.cs" Inherits="WebApplication2.Bookingform" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Booking Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            height: 100vh;
        }

        #booking {
            background-color: #fff;
            width: 80%;
            height: 100%;
            margin: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
            margin-top: 50px;
        }

        #booking h2 {
            margin-bottom: 20px;
            color: #cf2e2e;
        }

        #booking input, #booking select {
            width: 50%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .service {
            display: flex;
            align-items: center;
            justify-content:space-evenly;
            margin-bottom: 10px;
        }

        .service label {
            margin-right:50px;
            width: 60%;
            text-align: left;
        }

        .service input {
            width: 10px;
            height: 10px;
        }

        #SubmitButton {
            background-color: #666;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            max-width:18%;
            cursor: pointer;
        }

        #SubmitButton:hover {
            background-color: #cf2e2e;
        }
        .services{
            display:flex;
            flex-direction:column;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="booking">
            <h2>Booking Form</h2>
            
            <asp:TextBox ID="txtVehicleNumber" runat="server" placeholder="Vehicle Number"></asp:TextBox>
            <asp:TextBox ID="txtMake" runat="server" placeholder="Make"></asp:TextBox>
            <asp:TextBox ID="txtModel" runat="server" placeholder="Model"></asp:TextBox>
            <asp:TextBox ID="txtYear" runat="server" placeholder="Year"></asp:TextBox>
           <div class="services">
                <% var services = getbookingservices(); %>
                <% if (services != null) { %>
                    <% foreach(var service in services) { %>
                       <div class="service">
                            <label for="<%= "chk" + service.serviceid %>"><%= service.servicename %></label>
                            <input type="checkbox" id="<%= "chk" + service.serviceid %>" class="checkbox"/>
                        </div>
                    <% } %>
                <% } else { %>
                    <p>No services found.</p>
                <% } %>
            </div>

                 <input type="date" id="appointmentDate" name="appointmentDate" runat="server" />
                 <asp:HiddenField ID="HiddenFieldSelectedServices" runat="server" />
                 <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="Book" OnClientClick="getCheckedServiceNames(); return true;" />


            <a href="<%= ResolveUrl("~/Home.aspx") %>">Back</a>
        </div>
    </form>
    <script type="text/javascript">
        function getCheckedServiceNames() {
            var checkedServiceNames = [];
            var checkboxes = document.querySelectorAll(".services .checkbox");

            checkboxes.forEach(function (checkbox) {
                if (checkbox.checked) {
                    var label = document.querySelector("label[for='" + checkbox.id + "']");
                    if (label) {
                        checkedServiceNames.push(label.textContent.trim());
                    }
                }
            });

            // Set the value of the hidden field
            document.getElementById('<%= HiddenFieldSelectedServices.ClientID %>').value = JSON.stringify(checkedServiceNames);
        }

</script>


</body>
</html>