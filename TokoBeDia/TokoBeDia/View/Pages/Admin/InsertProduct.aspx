<%@ Page Title="Add New Product | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="InsertProduct.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.InsertProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Add New Product</h4>
            <hr />
        </div>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Product Name</label>
                <input type="text" class="form-control" id="txtname" aria-describedby="emailHelp" placeholder="Enter Product Name">
            </div>
            <div class="form-group">
                <label for="">Product Type</label>
                <select class="form-control" id="txttype" runat="server">
                </select>
            </div>
            <div class="form-group">
                <label for="">Product Price</label>
                <input type="number" class="form-control" id="txtprice" aria-describedby="emailHelp" placeholder="Enter Product Price">
            </div>
            <div class="form-group">
                <label for="">Product Qty</label>
                <input type="number" class="form-control" id="txtqty" aria-describedby="emailHelp" placeholder="Enter Product Qty">
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
            if ($('#txtname').val() == "" || $('#txtqty').val() == "" || $('#txtprice').val() == "" || $('#content_main_txttype').val() == "") {
                showError("Input must be filled")
                return;
            }
            if ($('#txtprice').val() % 1000 != 0 || $('#txtprice').val() == 0) {
                showError("Price must be above 1000 and multiply of 1000")
                return;
            }
            if ($('#txtqty').val() < 1) {
                showError("Qty must be 1 or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "InsertProduct.aspx/Insert",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"name":"' + $("#txtname").val() + '","productTypeID":"' + $("#content_main_txttype").val() + '","price":"' + $("#txtprice").val() + '","qty":"' + $("#txtqty").val() + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "../Product.aspx"
                    })
                }

            });
        })
    </script>
</asp:Content>
