<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="servervars.aspx.cs" Inherits="Referrals.servervars" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    
    <table border="1" cellpadding="5" cellspacing="0" bordercolor="#e7e7e7">

        <%
        foreach (string var in Request.ServerVariables)
        {
            %><tr>
                <th><% = var %></th>
                <td><% = Request[var] %></td>
            </tr><%
        }
        %>

    </table>

</body>
</html>
