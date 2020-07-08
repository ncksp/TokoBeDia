<%@ Page Title="Insert Product Type | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="InsertProductType.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.InsertProductTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Add New Product Type</h4>
            <hr />
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Product Type Name</label>
                <input type="text" class="form-control" id="txtname" aria-describedby="emailHelp" placeholder="Enter Product Name">
            </div>
            <div class="form-group">
                <label for="">Product Type Description</label>
                <textarea class="form-control" id="txtdesc" name="description" placeholder="Enter Description"></textarea>
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
            if ($('#txtname').val() == "" || $('#txtdesc').val() == "") {
                showError("Input must be filled")
                return;
            }
            if ($('#txtname').val().length < 5) {
                showError("Name consists of 5 characters or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "InsertProductTypes.aspx/Insert",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"name":"' + $("#txtname").val() + '","desc":"' + $("#txtdesc").val() + '"}',
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
