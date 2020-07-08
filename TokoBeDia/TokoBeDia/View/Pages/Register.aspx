<%@ Page Title="Register | TokoBeDia" Language="C#" MasterPageFile="~/View/App.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TokoBeDia.View.Pages.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../../Assets/css/login.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="server">

    <form class="form-signin center mt-3" runat="server">
        <div class="text-center">
            <img class="mb-4 " src="../../Assets/images/logo.png" alt="" width="200" height="120">
        </div>

        <h1 class="h3 mb-3 font-weight-normal text-center">Sign Up</h1>

        <div class="form-group">
            <label for=""><i class="fas fa-address-card"></i>&nbsp;Email address</label>
            <input type="email" class="form-control" id="email" placeholder="Enter email" required>
        </div>
        <div class="form-group">
            <label for=""><i class="fas fa-user"></i>&nbsp;Name</label>
            <input type="text" class="form-control" id="name" placeholder="Enter name" minlength="5" required>
        </div>
        <div class="form-group">
            <label for=""><i class="fas fa-key"></i>&nbsp;Password</label>
            <input type="password" class="form-control" id="password" placeholder="Enter password" minlength="8" required>
        </div>
        <div class="form-group">
            <label for=""><i class="fas fa-key"></i>&nbsp;Confirm Password</label>
            <input type="password" class="form-control" id="conf-password" placeholder="Confirm Password" minlength="8" required>
        </div>
        <div class="form-group">
            <label for=""><i class="fas fa-venus-mars"></i>&nbsp;Gender</label>
            <select class="form-control" name="gender" id="gender" required>
                <option value="" hidden>-----</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </div>

        <div class="form-group">
            <small id="register" class="form-text text-muted">Have an account? <a href="Login.aspx"><b>Login</b></a></small>
        </div>

        <a href="Home.aspx"><small>Back to home</small></a>
        <button type="submit" id="submit" class="btn btn-success btn-sm float-right">Register</button>
        <button type="reset" class="btn btn-secondary btn-sm float-right mr-2">Reset</button>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="script" runat="server">

    <script>

        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        $('form').submit(function (e) {
            if ($('#password').val() !== $('#conf-password').val()) {
                showError("Password doesn't match")
                e.preventDefault();
                return;
            }

            if ($('#email').val() == "" || $('#name').val() == "" || $('#gender').val() == "") {
                showError("Input must be filled")
                e.preventDefault();
                return;
            }

            $('button').attr('disabled', 'disabled')
            $('a').attr('hidden', 'hidden')
            $.ajax({
                type: "POST",
                url: "Register.aspx/Regist",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"email":"' + $("#email").val() + '","name":"' + $("#name").val() + '","password":"' + $("#password").val() + '","gender":"' + $("#gender").val() + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    $('a').removeAttr('hidden')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "Login.aspx"
                    })
                }

            });
            e.preventDefault();
        })
    </script>
</asp:Content>
