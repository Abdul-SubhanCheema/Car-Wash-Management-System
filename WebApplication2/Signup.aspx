<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="WebApplication2.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Sign up</title>
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
            width: 450px; 
            height: 680px; 
            margin: auto; 
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px; 
            box-sizing: border-box;
        }

        #signup h2 {
            margin-bottom: 20px;
            color: #666; 
        }

        #signup p {
            margin-top: 10px;
        }

        #signup p a {
            color: #cf2e2e;
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

        #SignupButton  {
            background-color: #666;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #SignupButton:hover {
            background-color: #cf2e2e;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id="signup">
            <h2>Sign up</h2>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtAdress" runat="server" placeholder="Address"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtPassword" runat="server"  placeholder="Password"></asp:TextBox>
            <br />
            <asp:TextBox ID="Txtphone" runat="server"  placeholder="Phone No"></asp:TextBox>
             <br />
            <asp:TextBox ID="TxtGender" runat="server"  placeholder="Gender"></asp:TextBox>
            <br />
            <asp:Button ID="SignupButton" runat="server" Text="Sign up" OnClick="Signup"/>
            <br />
            <p>Already have an account? <a href="<%= ResolveUrl("~/Userlogin.aspx") %>">Login</a></p>
            <br />
           <p>Home Page <a href="<%= ResolveUrl("~/Choice.aspx") %>">Back</a></p>
        </div>
    </form>
</body>

</html>