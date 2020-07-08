<%@ Page Title="Update Payment Type | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="UpdatePaymentType.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.UpdatePaymentType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Add New Product Type</h4>
            <hr />
            <input type="text" class="form-control" id="txttypeold" runat="server" hidden>
            <input type="text" class="form-control" id="txtid" runat="server" hidden>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Payment Type</label>
                <input type="text" class="form-control" id="txttype" runat="server">
            </div>
            <button type="button" id="btnsubmit" class="btn btn-primary float-right"><i class="fa fa-save"></i>Submit</button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        var frontField = 'content_main_'
        var typeOld = $('#' + frontField + 'txttypeold').val();
        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        $("#btnsubmit").click(function () {

            var id = $('#' + frontField + 'txtid').val();
            var type = $('#' + frontField + 'txttype').val();
            if (type == "") {
                showError("Input must be filled")
                return;
            }
            if (type.length < 3) {
                showError("Type consists of 3 characters or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "UpdatePaymentType.aspx/Update",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","oldType":"' + typeOld + '","type":"' + type + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "PaymentTypes.aspx"
                    })
                }

            });
        })
    </script>
</asp:Content>
