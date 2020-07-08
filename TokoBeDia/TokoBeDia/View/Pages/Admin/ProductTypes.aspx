<%@ Page Title="Product Types | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="ProductTypes.aspx.cs" Inherits="TokoBeDia.View.Pages.ProductTypes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="text-right mb-2" id="btnaddproduct" runat="server">
            <a href="Admin/InsertProductType.aspx" class="btn btn-success align-content-end"><i class="fa fa-tasks"></i>Add Product Types</a>
        </div>
        <div class="justify-content-center">
            <asp:GridView ID="dataProductTypes" CssClass="table table-bordered" ShowHeaderWhenEmpty="true" runat="server"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Product Type ID" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server"
                                Text='<%#Eval("ProductTypeID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Product Type Name" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%#Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lnlstock" runat="server" Text='<%#Eval("description")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CssClass="btn btn-info btn-sm" CommandArgument='<%#Eval("ProductTypeID")%>' OnClick="LinkButtonEdit_Click"><i class="fa fa-pen"></i> Update</asp:LinkButton>

                            <button type="button" class="btn btn-danger btn-sm" onclick="return deleteProductType(<%#Eval("ProductTypeID")%>)"><i class="fa fa-trash-alt"></i>Delete </button>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        function deleteProductType(id) {
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
                url: "ProductTypes.aspx/Delete",
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
</asp:Content>
