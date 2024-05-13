<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="updateprofile.aspx.cs" Inherits="WebApplication2.WebForm6" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Update Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        #signup {
            background-color: #fff;
            width: 400px; /* Set your desired width */
            height: 350px; /* Set your desired height */
            margin: auto; /* Center the form horizontally */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px; /* Add padding to create space between content and container boundaries */
            box-sizing: border-box; /* Include padding and border in total width/height */
        }

        #signup h2 {
            margin-bottom: 20px;
            color: #666; /* Use the same color as the button */
        }

        #signup p {
            margin-top: 10px;
        }

        #signup p a {
            color: #cf2e2e; /* Use the same color as the button */
            text-decoration: none;
            font-weight: bold;
        }

        #signup p a:hover {
            text-decoration: underline;
        }

        #signup input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #btnupdate {
            background-color: #666;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #btnupdate:hover {
            background-color: #cf2e2e;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id="signup">
            <h2>Update Profile</h2>
             <asp:TextBox ID="txtusername" runat="server"  placeholder="Username"></asp:TextBox>
             <br />
            <asp:TextBox ID="txtpassword" runat="server"  placeholder="Password"></asp:TextBox>
            <br />
            <asp:Button ID="btnupdate" runat="server" Text="Update" OnClick="update"/>
            <br />
            <a href="<%= ResolveUrl("~/Profile.aspx") %>">Back</a>
        </div>
    </form>
</body>

</html>