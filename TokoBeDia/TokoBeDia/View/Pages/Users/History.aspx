<%@ Page Title="Transaction History | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="TokoBeDia.View.Pages.Users.History" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="justify-content-center">
            <asp:GridView ID="dataHistory" CssClass="table table-bordered" ShowHeaderWhenEmpty="true" runat="server"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Transaction ID" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server"
                                Text='<%#Eval("ID")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Date" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%#Eval("DateTime")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Payment Type" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblprice" runat="server" Text='<%#Eval("Payment")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Total Item" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblqty" runat="server" Text='<%#Eval("TotalItem")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Total Quantity" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblprice" runat="server" Text='<%#Eval("TotalQuantity")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="Total" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblprice" runat="server" Text='<%#Eval("TotalPrice")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#detailModal" onclick="return viewDetails(<%#Eval("id")%>)"><i class="fa fa-info"></i> Details </button>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="text-right">
            <asp:LinkButton ID="LinkButtonReport" runat="server" CssClass="btn btn-info btn-sm" OnClick="LinkButtonReport_Click"><i class="fa fa-pen"></i> Show Report</asp:LinkButton>
        </div>
    </div>
    <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Product Name</th>
                                <th scope="col">Product Type</th>
                                <th scope="col">Quantity</th>
                                <th scope="col">Price</th>
                                <th scope="col">Sub Total</th>
                            </tr>
                        </thead>
                        <tbody class="data">
                        </tbody>
                        <tfoot>
                            <tr>
                                <th scope="row" style="text-align:right" colspan="4">Total</th>
                                <td id="grand_total"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>
        function viewDetails(id) {
            $.ajax({
                type: "POST",
                url: "History.aspx/GetDetails",
                data: '{"userid":"' + <%= this.userID %> + '", "headerid":"' + id + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    data = data.d
                    data = JSON.parse(data)
                    generateTable(data)
                },
                failure: function (response) {
                    alert(response.d);
                },
                error: function (response) {
                    alert(response.d);
                }
            });
        };

        function generateTable(data) {
            let total = 0
            $(".modal tbody.data").empty()
            data.forEach(element => {
                var tdata = `<tr>
                                <th scope="row">`+ element.ProductName +`</th>
                                <td>`+ element.ProductType +`</td>
                                <td>`+ element.Quantity +`</td>
                                <td>`+ element.Price +`</td>
                                <td>`+ element.SubTotal +`</td>
                            </tr>`
                $(".modal tbody.data").append(tdata)

                total += element.SubTotal
            });

            $("#grand_total").text(total)
        }
    </script>
</asp:Content>
