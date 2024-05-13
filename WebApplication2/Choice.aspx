<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Choice.aspx.cs" Inherits="WebApplication2.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        #form1 {
            text-align: center;
            margin-top: 100px;
        }

        .button-container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .button-container .btnUser,
        .button-container .btnAdmin {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .btnUser {
            background-color: #4CAF50;
            color: white;
            border: none;
        }

        .btnAdmin {
            background-color: #f44336;
            color: white;
            border: none;
        }

        .btnUser:hover, .btnAdmin:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="button-container">
            <asp:Button ID="btnUser" runat="server" CssClass="btnUser" Text="User" OnClick="BtnUser_Click" />
            <asp:Button ID="btnAdmin" runat="server" CssClass="btnAdmin" Text="Admin" OnClick="BtnAdmin_Click" />
        </div>
    </form>
</body>
</html>


