<%@ Page Title="Update Cart | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="UpdateCart.aspx.cs" Inherits="TokoBeDia.View.Pages.Users.UpdateCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid">
        <div class="mt-3 col-md-6">
            <h4 class="display-4">Update Product</h4>
            <hr />
        </div>
        <input type="text" class="form-control" id="txtid" runat="server" hidden>
        <div class="col-md-6">
            <div class="form-group">
                <label for="">Product Name</label>
                <label class="form-control" id="txtname" runat="server"></label>
            </div>
            <div class="form-group">
                <label for="">Product Type</label>
                <label class="form-control" id="txttype" runat="server"></label>
            </div>
            <div class="form-group">
                <label for="">Qty</label>
                <input type="number" class="form-control" id="txtqty" placeholder="Enter Product Qty" runat="server">
            </div>
            <button type="button" id="btnsubmit" class="btn btn-primary float-right"><i class="fa fa-save"></i>Update</button>
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
            var qty = $('#' + frontField + 'txtqty').val();
            if (qty == "" ) {
                showError("Input must be filled")
                return;
            }
            if (qty < 1) {
                showError("Qty must be 1 or more")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "UpdateCart.aspx/Update",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","qty":"' + qty + '","userID":"' + <%= this.userID %> + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "Cart.aspx"
                    })
                }

            });
        })
    </script>
</asp:Content>
