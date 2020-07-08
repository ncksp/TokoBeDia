<%@ Page Title="Cart | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="TokoBeDia.View.Pages.Users.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="justify-content-center">
            <asp:GridView ID="dataCart" CssClass="table table-bordered" ShowHeaderWhenEmpty="true" runat="server"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Product ID" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server"
                                Text='<%#Eval("ProductID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Name" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%#Eval("product.name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Price" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblprice" runat="server" Text='<%#Eval("product.price")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Quantity" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblqty" runat="server" Text='<%#Eval("quantity")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Sub Total" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblsubtotal" CssClass="subtotal" runat="server" Text='<%# 
                                Int32.Parse(Eval("product.price").ToString()) * Int32.Parse(Eval("quantity").ToString())
                                %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CssClass="btn btn-info btn-sm" CommandArgument='<%#Eval("id")%>' OnClick="LinkButtonEdit_Click"><i class="fa fa-pen"></i> Update</asp:LinkButton>

                            <button type="button" class="btn btn-danger btn-sm" onclick="return deleteCart(<%#Eval("id")%>)"><i class="fa fa-trash-alt"></i>Delete </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:Panel ID="checkoutForm" runat="server">
                <p>
                    Grand Total :
                    <b id="grandtotal"></b>
                </p>
                <hr />
                <div class="row">
                    <div class="form-group col-6">
                        <label for=""><b>Select Payment Type</b></label>
                        <select class="form-control" id="txtpayment" runat="server">
                        </select>
                    </div>
                </div>
                <button type="button" id="btncheckout" class="btn btn-primary float-right"><i class="fa fa-shopping-cart"></i>Checkout</button>
            </asp:Panel>
            
        </div>
        
        <%= this.grandTotal %>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">

    <script>
        var subtotals = $('.subtotal')
        var grandTotal = 0
        subtotals.each(function () {
            grandTotal += parseInt($(this).text())
        })

        function formatRupiah(angka, prefix = "Rp. ") {
            var number_string = angka.replace(/[^,\d]/g, '').toString(),
                split = number_string.split(','),
                sisa = split[0].length % 3,
                rupiah = split[0].substr(0, sisa),
                ribuan = split[0].substr(sisa).match(/\d{3}/gi);

            if (ribuan) {
                separator = sisa ? '.' : '';
                rupiah += separator + ribuan.join('.');
            }

            rupiah = split[1] != undefined ? rupiah + ',' + split[1] : rupiah;
            return prefix == undefined ? rupiah : (rupiah ? 'Rp. ' + rupiah : '');
        }

        $("#grandtotal").text(formatRupiah(grandTotal.toString()))
    </script>
    
    <script>
        function deleteCart(id) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.value) {
                    sendRequestDelete(id)
                }
            })
        }

        function sendRequestDelete(id) {
            $.ajax({
                type: "POST",
                url: "Cart.aspx/Delete",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '"}',
                success: function (e) {
                    e = e.d
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
        }
    </script>

    <script>
        var frontField = 'content_main_'
        var typeOld = $('#' + frontField + 'txttypeold').val();
        function showError(text) {
            Swal.fire({
                icon: 'error',
                text: text,
            })
        }
        $("#btncheckout").click(function () {

            var payment = $('#' + frontField + 'txtpayment').val();
            if (payment == "") {
                showError("Payment must be choiced")
                return;
            }
            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "Cart.aspx/Checkout",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"paymentID":"' + payment + '","userID":"' + <%= this.userID%> + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success")
                            window.location = "../Home.aspx";
                    })
                }

            });
        })
    </script>
</asp:Content>
