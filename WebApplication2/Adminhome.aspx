<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Adminhome.aspx.cs" Inherits="WebApplication2.Adminhome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Your Page Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            background-color: #f4f4f4;
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
            text-align: center;
        }

        #image-container {
            position: relative;
            width: 100%;
            max-width: 800px;
            margin: auto;
        }

        #carousel-image {
            width: 100%;
            max-width: 100%;
            height: auto;
            position: relative;
            opacity: 0.8; /* Adjust the opacity as needed */
        }

        #text-overlay {
            position: absolute;
            top: 30px;
            left: 50%;
            transform: translateX(-50%);
            color: #cf2e2e;
            font-size: 32px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.8);
        }

        #prev-btn,
        #next-btn {
            background-color: #666;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            position: absolute;
            top: 50%;
            cursor: pointer;
            transform: translateY(-50%);
        }

        #prev-btn {
            left: 10px;
        }

        #next-btn {
            right: 10px;
        }

        #prev-btn:hover,
        #next-btn:hover {
            background-color: #cf2e2e;
            cursor: pointer;
        }

        footer {
            background-color: #666;
            color: white;
            text-align: center;
            padding: 10px;
        }
         #dashboard {
            display: flex;
            justify-content: space-around;
            align-items: center;
            flex-grow: 1;
        }

        .dashboard-option {
            background-color: #fff;
            width: 200px;
            height: 150px;
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .dashboard-option:hover {
            background-color: #666;
        }
        .dashboard-option:hover h2 {
    color: #cf2e2e; /* Change h2 color to red on hover */
}

.dashboard-option:hover a {
    color: #f4f4f4; /* Change link color to white on hover */
}


        h2 {
            color: #cf2e2e;
        }

        a {
            color: #666;
            text-decoration: none;
            font-weight: bold;
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
        <h2>Welcome to Admin Page</h2>
        <div id="dashboard">
            <div class="dashboard-option">
                <h2>Inventory</h2>
                <a href="#">View Details</a>
            </div>

            <div class="dashboard-option">
                <h2>Bookings</h2>
               <a href="<%= ResolveUrl("~/Bookingdetails.aspx") %>">Services</a>
            </div>

            <div class="dashboard-option">
                <h2>Finance</h2>
                <a href="<%= ResolveUrl("~/Finance.aspx") %>">Services</a>
            </div>
            <div class="dashboard-option">
                <h2>Logout</h2>
                <a href="<%= ResolveUrl("~/Adminlogin.aspx") %>">Services</a>
            </div>

        </div>


    </section>
    <footer>
        &copy; 2023 Softhut. All rights reserved.
    </footer>

    <script>
        
    </script>
</body>

</html>
