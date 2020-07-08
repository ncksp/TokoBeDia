<%@ Page Title="Home | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TokoBeDia.View.Pages.Home" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Hello!</h1>
            <p class="lead">Selamat datang di website TokoBeDia.</p>
            <hr class="my-4">
            <p>Kami menjual beberapa jenis barang seperti Baju, Celana dan kebutuhan rumah lainnya</p>
            <p class="lead">
                <a class="btn btn-primary btn-sm" href="<%= ResolveUrl("~/View/Pages/Product.aspx") %>" role="button">See Another Product</a>
            </p>
        </div>
        <%--<% for (int i = 0; i < this.total ; i++){%>
            <div class="col-3">
                <div class="card" style="width: 18rem;">
                    <img class="card-img-top" src="..." alt="Card image cap">
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                        <a href="#" class="btn btn-primary">Go somewhere</a>
                    </div>
                </div>
            </div>
         <%}%>--%>
        <%--</div>--%>
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
                            <asp:Label ID="lblService" runat="server" Text='<%#Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Stock" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblService" runat="server" Text='<%#Eval("stock")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Type" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblService" runat="server" Text='<%#Eval("producttype.name")%>'></asp:Label>
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
</asp:Content>
