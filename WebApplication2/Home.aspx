<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="WebApplication2.WebForm5" %>

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

        nav {
            background-color: #cf2e2e;
            overflow: hidden;
            text-align: center;
        }

        nav a {
            display: inline-block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
            cursor: pointer;
        }

        nav a:hover {
            background-color: #fff;
            color: #cf2e2e;
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
    </style>
</head>

<body>
    <header>
        <h1>
            <span class="car">CAR</span>
            <span class="wash">Wash</span>
        </h1>
    </header>
    <nav>
        <a href="<%= ResolveUrl("~/userbooking.aspx") %>">Bookings</a>
        <a href="<%= ResolveUrl("~/services.aspx") %>">Services</a>
        <a href="<%= ResolveUrl("~/contactus.aspx") %>">Contact Us</a>
        <a href="<%= ResolveUrl("~/Bookingform.aspx") %>">Booking</a>
        <a href="<%= ResolveUrl("~/Profile.aspx") %>">Profile</a>
        <a href="<%= ResolveUrl("~/Userlogin.aspx") %>">Logout</a>
    </nav>
    <section>
        <h2>Welcome to our website!</h2>
        <p>This is a sample page with a navigation bar.</p>

        <div id="image-container">
            <img id="carousel-image" src="https://images.unsplash.com/photo-1605164598708-25701594473e?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="Loading" />
            <div id="text-overlay">Car Wash</div>
            <button id="prev-btn" onclick="prevImage()">&#8249;</button>
            <button id="next-btn" onclick="nextImage()">&#8250;</button>
        </div>
    </section>
    <footer>
        &copy; 2023 Softhut. All rights reserved.
    </footer>

    <script>
        var currentIndex = 0;
        var images = [
            "https://images.unsplash.com/photo-1605164598708-25701594473e?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            "https://images.unsplash.com/photo-1575844611398-2a68400b437c?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            "https://plus.unsplash.com/premium_photo-1663013309657-8b3a2a00849e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fGNhciUyMHdheHxlbnwwfHwwfHx8MA%3D%3D",
            "https://images.unsplash.com/photo-1613214149922-f1809c99b414?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
        ]; // Add your image URLs here

        function showImage(index) {
            var image = document.getElementById("carousel-image");
            currentIndex = index;

            if (currentIndex < 0) {
                currentIndex = images.length - 1;
            } else if (currentIndex >= images.length) {
                currentIndex = 0;
            }

            image.src = images[currentIndex];

            // Update text based on the index
            switch (currentIndex) {
                case 0:
                    document.getElementById("text-overlay").innerText = "Car Wash";
                    break;
                case 1:
                    document.getElementById("text-overlay").innerText = "Car Vacuum";
                    break;
                case 2:
                    document.getElementById("text-overlay").innerText = "Car Wax";
                    break;
                case 3:
                    document.getElementById("text-overlay").innerText = "Tyre Service";
                    break;
            }
        }

        function prevImage() {
            showImage(currentIndex - 1);
        }

        function nextImage() {
            showImage(currentIndex + 1);
        }
    </script>
</body>

</html>
