<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="contactus.aspx.cs" Inherits="WebApplication2.contactus" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us</title>
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

        #contact-form {
            background-color: #fff;
            width: 400px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            box-sizing: border-box;
            text-align: left;
        }

        #contact-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        #contact-form input,
        #contact-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #btnSubmit {
            background-color: #cf2e2e;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #btnSubmit:hover {
            background-color: #666;
        }
        h2{
            display:flex;
            justify-content:center;
        }
        #appointmentDate{
            margin-top:5px;
        } 
        a{
            display:flex;
            justify-content:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="contact-form">
            <h2>Contact Us</h2>
            
            <asp:Label runat="server" AssociatedControlID="txtSubject" Text="Subject:"></asp:Label>
            <asp:TextBox runat="server" ID="txtSubject" placeholder="Subject"></asp:TextBox>

            <asp:Label runat="server" AssociatedControlID="txtMessage" Text="Message:"></asp:Label>
            <asp:TextBox runat="server" ID="txtMessage" TextMode="MultiLine" Rows="5" placeholder="Your Message"></asp:TextBox>
           
            <asp:Label ID="lblRange" runat="server" Text="Rating:"></asp:Label>
            <asp:DropDownList ID="ddlRange" runat="server"></asp:DropDownList>

             <input type="date" id="appointmentDate" name="appointmentDate" runat="server" />
            <asp:Button runat="server" ID="btnSubmit" Text="Send Message" onClick="contact" />

              <a href="<%= ResolveUrl("~/Home.aspx") %>">Back</a>
        </div>
        </div>
    </form>
</body>
</html>
