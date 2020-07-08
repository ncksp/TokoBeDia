<%@ Page Title="Insert Payment Type | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="InsertPaymentType.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.InsertPaymentType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Add New Product Type</h4>
            <hr />
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Payment Type</label>
                <input type="text" class="form-control" id="txttype" aria-describedby="" placeholder="Enter Payment Type">
            </div>
            <button type="button" id="btnsubmit" class="btn btn-primary float-right"><i class="fa fa-save"></i>Submit</button>

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
        $("#btnsubmit").click(function () {
            if ($('#txttype').val() == "") {
                showError("Input must be filled")
                return;
            }
            if ($('#txttype').val().length < 3) {
                showError("Type consists of 5 characters or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "InsertPaymentType.aspx/Insert",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"type":"' + $("#txttype").val() + '"}',
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
