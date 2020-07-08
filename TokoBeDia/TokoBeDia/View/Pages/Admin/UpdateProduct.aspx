<%@ Page Title="Update Data Product | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="UpdateProduct.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.UpdateProduct" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Update Product</h4>
            <hr />
        </div>
        <input type="text" class="form-control" id="txtid" placeholder="Enter Product Name" runat="server" hidden>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Product Name</label>
                <input type="text" class="form-control" id="txtname" placeholder="Enter Product Name" runat="server">
            </div>
            <div class="form-group">
                <label for="">Product Type</label>
                <select class="form-control" id="txttype" runat="server">
                </select>
            </div>
            <div class="form-group">
                <label for="">Product Price</label>
                <input type="number" class="form-control" id="txtprice" placeholder="Enter Product Price" runat="server">
            </div>
            <div class="form-group">
                <label for="">Product Qty</label>
                <input type="number" class="form-control" id="txtqty" placeholder="Enter Product Qty" runat="server">
            </div>
            <button type="button" id="btnsubmit" class="btn btn-primary float-right"><i class="fa fa-save"></i>Submit</button>

        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        var frontField = 'content_main_'
        
        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        $("#btnsubmit").click(function () {
            var id = $('#' + frontField + 'txtid').val();
            var name = $('#' + frontField + 'txtname').val();
            var type = $('#' + frontField + 'txttype').val();
            var price = $('#' + frontField + 'txtprice').val();
            var qty = $('#' + frontField + 'txtqty').val();
            if (name == "" || qty == "" || price == "" || type == "") {
                showError("Input must be filled")
                return;
            }
            if (price % 1000 != 0 || price == 0) {
                showError("Price must be above 1000 and multiply of 1000")
                return;
            }
            if (qty < 1) {
                showError("Qty must be 1 or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "UpdateProduct.aspx/Update",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","name":"' + name + '","productTypeID":"' + type + '","price":"' + price + '","qty":"' + qty + '"}',
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
