<%@ Page Title="Update Product Types | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="UpdateProductType.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.UpdateProductTypes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Add New Product Type</h4>
            <hr />
            <input type="text" class="form-control" id="txtnameold" runat="server" hidden>
            <input type="text" class="form-control" id="txtid" runat="server" hidden>
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Product Type Name</label>
                <input type="text" class="form-control" id="txtname" runat="server">
            </div>
            <div class="form-group">
                <label for="">Product Type Description</label>
                <textarea class="form-control" id="txtdesc" name="description" runat="server"></textarea>
            </div>
            <button type="button" id="btnsubmit" class="btn btn-primary float-right"><i class="fa fa-save"></i>Submit</button>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        var frontField = 'content_main_'
        var nameOld = $('#' + frontField + 'txtnameold').val();
        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        $("#btnsubmit").click(function () {

            var id = $('#' + frontField + 'txtid').val();
            var name = $('#' + frontField + 'txtname').val();
            var desc = $('#' + frontField + 'txtdesc').val();
            if (name == "" || desc  == "") {
                showError("Input must be filled")
                return;
            }
            if (name.length < 5) {
                showError("Name consists of 5 characters or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "UpdateProductTypes.aspx/Update",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","nameOld":"' + nameOld + '","name":"' + name + '","desc":"' + desc + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "ProductTypes.aspx"
                    })
                }

            });
        })
    </script>
</asp:Content>
