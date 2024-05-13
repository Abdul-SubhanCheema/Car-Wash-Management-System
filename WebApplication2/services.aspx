
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="services.aspx.cs" Inherits="WebApplication2.services" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Services</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    #services-container {
        text-align: center;
        width: 80%; /* Responsive width */
        max-width: 1200px; /* Maximum width */
        margin: auto;
    }

    .service {
        background-color: #fff;
        width: calc(100% / 3 - 40px); /* Responsive width */
        margin: 20px;
        padding: 1em; /* Responsive padding */
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        box-sizing: border-box;
        text-align: left;
        display: inline-block;
        vertical-align: top;
    }

    .service h2 {
        color: #cf2e2e;
        margin-bottom: 0.5em; /* Responsive margin */
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .description {
        display: none;
        margin-top: 0.5em; /* Responsive margin */
    }

    .btn-toggle {
        cursor: pointer;
        border: none;
        background-color: transparent;
        font-size: 1em; /* Responsive font size */
        color: #666;
    }
    a{
        display: flex;
    justify-content: center;
    align-items: center;
    }
    @media (max-width: 768px) {
        .service {
            width: calc(100% / 2 - 30px); /* Adjust for smaller screens */
        }
    }

    @media (max-width: 480px) {
        .service {
            width: 100%; /* Full width for very small screens */
        }
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="services-container">
            <h1>Services</h1>

           <% foreach(var service in getservices()) { %>
                <div class="service">
                    <h2>
                        <%= service.servicename %>
                        <button id="<%= "btn" + service.serviceid %>" class="btn-toggle" type="button" onclick="toggleDescription('<%= "desc"+service.serviceid %>', '<%= "btn"+service.serviceid %>')">+</button>
                    </h2>
                    <div id="<%= "desc" + service.serviceid %>" class="description">
                        <p><%= service.description %></p>
                    </div>
                </div>
                <% } %>

        </div>
        <a href="<%= ResolveUrl("~/Home.aspx") %>">Back</a>
    </form>
    <script>
        function toggleDescription(descriptionId, buttonId) {
            var description = document.getElementById(descriptionId);
            var button = document.getElementById(buttonId);

            if (description.style.display === 'none' || description.style.display === '') {
                description.style.display = 'block';
                button.innerText = '-';
            } else {
                description.style.display = 'none';
                button.innerText = '+';
            }
        }
    </script>
</body>
</html>
