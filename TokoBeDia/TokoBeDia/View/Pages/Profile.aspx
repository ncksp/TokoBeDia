<%@ Page Title="Profile | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="TokoBeDia.View.Pages.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <input type="text" class="form-control" id="txtid" required runat="server" hidden>
        <div class="col-md-5 mt-5">
            <div class="form-group">
                <label for="">Email</label>
                <input type="email" class="form-control" id="email" placeholder="Enter Email" required runat="server">
            </div>
            <div class="form-group">
                <label for="">Name</label>
                <input type="text" class="form-control" id="name" placeholder="Enter Name" required runat="server">
            </div>
            <div class="form-group">
                <label for="">Gender</label>
                <select class="form-control" id="gender" runat="server">
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
            </div>
            <button type="button" id="save" class="btn btn-primary">Submit</button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        var frontField = 'content_main_'
        var oldEmail = $('#' + frontField + 'email').val();
        $('#save').click(function (e) {

            var email = $('#' + frontField + 'email').val();
            var name = $('#' + frontField + 'name').val();
            var gender = $('#' + frontField + 'gender').val();
            var id = $('#' + frontField + 'txtid').val();

            if (email == "" || name == "" || gender == "") {
                showError("Input must be filled")
                e.preventDefault();
                return;
            }

            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "Profile.aspx/update",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","oldEmail":"' + oldEmail + '","email":"' + email + '","name":"' + name + '","gender":"' + gender + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location.reload();
                    })
                }

            });
            e.preventDefault();
        })
    </script>
</asp:Content>
