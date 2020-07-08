<%@ Page Title="Login | TokoBeDia" Language="C#" MasterPageFile="~/View/App.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TokoBeDia.View.Pages.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../../Assets/css/login.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    <form class="form-signin center mt-3" runat="server">

        <div class="text-center">
            <img class="mb-4 " src="../../Assets/images/logo.png" alt="" width="200" height="120">
        </div>

        <h1 class="h3 mb-3 font-weight-normal text-center">Please sign in</h1>

        <div class="form-group">
            <label for="exampleInputEmail1"><i class="fas fa-address-card"></i>&nbsp;Email address</label>
            <asp:TextBox ID="txtemail" TextMode="Email" runat="server" CssClass="form-control"></asp:TextBox>

            <%--<input type="text" class="form-control" id="txtemail" placeholder="Enter email" runat="server" required>--%>
        </div>

        <div class="form-group">
            <label for="exampleInputPassword1"><i class="fas fa-key"></i>&nbsp;Password</label>
            <asp:TextBox ID="txtpassword" TextMode="Password" runat="server" CssClass="form-control"></asp:TextBox>

            <%--<input type="password" class="form-control" id="txtpassword" placeholder="Password" runat="server" required>--%>
        </div>

        <div class="checkbox mb-3">
            <label>

                <asp:CheckBox ID="remember" runat="server" Text="Remember" />
            </label>
        </div>
        <div class="form-group">
            <asp:Label ID="lblerror" ForeColor="Red" runat="server" Text=""></asp:Label>
        </div>
        <div class="form-group">
            <small id="register" class="form-text text-muted">Don't have an account? <a href="Register.aspx"><b>Register</b></a></small>
        </div>

        <a href="Home.aspx"><small>Back to home</small></a>
        <asp:Button ID="BtnSubmit" Text="Login" runat="server" CssClass="btn btn-success btn-sm float-right" OnClick="BtnSubmit_Click"></asp:Button>
    </form>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">
    <script>
        //alert(document.cookie)
        $('form').submit(function (e) {

            if ($("#<%= txtemail.ClientID %>").val() == "" || $("#<%= txtpassword.ClientID %>").val() == "") {
                Swal.fire({
                    icon: 'error',
                    text: "Input must be filled",
                })
                e.preventDefault();
                return;
            }
        })
    </script>
</asp:Content>
