<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication2.Profile" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Profile</title>
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

        #profile {
            background-color: #fff;
            width: 400px;
            height: 400px;
            text-align: center;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            box-sizing: border-box;
        }

        #profile img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin-bottom: 20px;
        }

        #profile h2 {
            color: #cf2e2e;
        }

        #profile p {
            margin-bottom: 10px;
        }

        #btnEdit {
            background-color: #666;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #btnEdit:hover {
            background-color: #cf2e2e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="profile">
            <img src="https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D" alt="Profile Picture" />
            <div>
        <label>Name:</label>
            <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
        </div>
        <div><br/>
            <label>Email:</label>
            <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
        </div>
        <div><br/>
            <label>Address:</label>
            <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
        </div><br/>
            
            <asp:Button ID="btnEdit" runat="server" Text="Edit Profile" onClick="updateprofile" />
            <br /><br />
            <a href="<%= ResolveUrl("~/Home.aspx") %>">Back</a>
        </div>
    </form>

    <script>
        
    </script>
</body>
</html>