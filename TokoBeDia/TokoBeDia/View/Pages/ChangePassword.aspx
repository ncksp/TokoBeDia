<%@ Page Title="Change Password | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="TokoBeDia.View.Pages.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container">
        <input type="text" class="form-control" id="txtid" required runat="server" hidden>
        <div class="col-md-5 mt-5">
            <div class="form-group">
                <label for="">Old Password</label>
                <input type="password" class="form-control" id="old" placeholder="Enter Old Password" runat="server">
            </div>
            <div class="form-group">
                <label for="">New Password</label>
                <input type="password" class="form-control" id="new" name="new" placeholder="Enter New Password" runat="server">
            </div>
            <div class="form-group">
                <label for="">Confirm Password</label>
                <input type="password" class="form-control" id="new-conf" placeholder="Confirm New Password">
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


        var id = $('#' + frontField + 'txtid').val();
        $('#save').click(function (e) {
            let old = $('#' + frontField + 'old').val();
            let newPass = $('#' + frontField + 'new').val();
            let confPass = $('#new-conf').val();

            if (old == "" || newPass == "" || confPass == "") {
                showError("Input must be filled")
                e.preventDefault();
                return;
            }
            if (newPass.length <= 5) {
                showError("Password must be longer than 5 characters")
                e.preventDefault();
                return;
            }
            if (newPass != confPass) {
                showError("Password doesn't match")
                e.preventDefault();
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "ChangePassword.aspx/changePassword",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","old":"' + old + '","newPass":"' + newPass + '"}',
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
