<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Userlogin.aspx.cs" Inherits="WebApplication2.WebForm3" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>User Login</title>
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

        #login {
            background-color: #fff;
            width: 400px; 
            height: 350px;
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

        #login h2 {
            margin-bottom: 20px;
            color: #666; 
        }

        #login p {
            margin-top: 10px;
        }

        #login p a {
            color: #cf2e2e;
            text-decoration: none;
            font-weight: bold;
        }

        #login p a:hover {
            text-decoration: underline;
        }

        #login input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #loginbutton {
            background-color: #666;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #loginbutton:hover {
            background-color: #cf2e2e;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div id="login">
            <h2>Login</h2>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtPassword" runat="server" placeholder="Password"></asp:TextBox>
            <br />
            <asp:Button ID="loginbutton" runat="server" Text="Login" OnClick="login"/>
            <br />
            <p>Doesn't have account? <a href="<%= ResolveUrl("~/Signup.aspx") %>">Sign up</a></p>
        </div>
    </form>
</body>

</html>
