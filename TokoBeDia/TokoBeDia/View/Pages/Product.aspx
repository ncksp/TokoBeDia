<%@ Page Title="Product | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="TokoBeDia.View.Pages.Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="text-right mb-2" id="btnaddproduct" runat="server" hidden>
            <a href="Admin/InsertProduct.aspx" class="btn btn-success align-content-end"><i class="fa fa-tasks"></i>Add Product</a>
        </div>
        <div class="justify-content-center">
            <asp:GridView ID="dataProduct" CssClass="table table-bordered" ShowHeaderWhenEmpty="true" runat="server"
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
                            <asp:Label ID="lblname" runat="server" Text='<%#Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Stock" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lnlstock" runat="server" Text='<%#Eval("stock")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Type" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lbltypename" runat="server" Text='<%#Eval("producttype.name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Product Price" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblprice" runat="server" Text='<%#Eval("price")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField> 
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CssClass="btn btn-info btn-sm" CommandArgument='<%#Eval("productid")%>' OnClick="LinkButtonEdit_Click"><i class="fa fa-pen"></i> Update</asp:LinkButton>

                            <button type="button" class="btn btn-danger btn-sm" onclick="return deleteProduct(<%#Eval("productid")%>)"><i class="fa fa-trash-alt"></i>Delete </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <button type="button" class="btn btn-info btn-sm" onclick="return addCart(<%#Eval("ProductID")%>)"><i class="fa fa-shopping-cart"></i></button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <asp:Panel ID="addCartScript" runat="server">
         <script>
             function showError(text) {
                 Swal.fire({
                     icon: 'error',
                     text: text,
                 })
             }
             function addCart(id) {
                 $.ajax({
                     type: "POST",
                     url: "Users/Cart.aspx/Add",
                     contentType: 'application/json; charset=utf-8',
                     dataType: 'json',
                     data: '{"productID":"' + id + '","userID":"' + <%= this.userID %> + '"}',
                     success: function (e) {
                         e = e.d
                         $('button').removeAttr('disabled')
                         Swal.fire({
                             icon: e[0],
                             title: e[1],
                             text: e[2],
                         })
                     }
                 });
             }
        </script>
    </asp:Panel>

    <asp:Panel ID="productManagement" runat="server">
        <script>
            function deleteProduct(id) {
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
                    url: "Product.aspx/Delete",
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
    </asp:Panel>
    
</asp:Content>
