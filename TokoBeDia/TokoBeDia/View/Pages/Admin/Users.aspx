<%@ Page Title="User | TokoBeDia" Language="C#" MasterPageFile="~/View/Master/Pages.master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="TokoBeDia.View.Pages.Admin.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container mt-5">
        <div class="justify-content-center">
            <asp:GridView ID="dataUser" CssClass="table table-bordered" ShowHeaderWhenEmpty="true" runat="server"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="User ID" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblID" runat="server"
                                Text='<%#Eval("userid")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Role" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblrole" runat="server" Text='<%#Eval("role.name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Name" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblname" runat="server" Text='<%#Eval("name")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Email" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblemail" runat="server" Text='<%#Eval("email")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:Label ID="lblstatus" runat="server" Text='<%#Eval("status")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action" HeaderStyle-Wrap="false">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButtonEdit" runat="server" CssClass="btn btn-info btn-sm" CommandArgument='<%#Eval("userid")%>' OnClick="LinkButtonEdit_Click1"><i class="fa fa-pen"></i> Update</asp:LinkButton>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>
    <hr />
    <div class="container mt-5 mb-5 col-md-5 text-center" id="errordiv" runat="server" hidden>
        <h4 id="errortxt" style="color: red" runat="server">Cannot edit your role and status</h4>
    </div>
    <div class="container mt-5 mb-5 col-md-5 float-left" id="formEdit" runat="server" hidden>
        <input type="text" id="txtid" runat="server"  hidden/>
        <h1 class="h3 mb-3 font-weight-normal" id="lblHeader" runat="server"></h1>
        <div class="form-group">
            <label for=""><i class="fas fa-address-card"></i>&nbsp;Role</label>
            <select class="form-control"  id="role" runat="server">
                
            </select>
        </div>
        <div class="form-group">
            <label for=""><i class="fas fa-user"></i>&nbsp;Status</label>
            <select class="form-control" id="status" runat="server">
                
            </select>
        </div>
        <button type="button" id="save" class="btn btn-success btn-sm float-right">Save</button>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="script" runat="server">
    <script>

        var frontField = 'content_main_'
        $('#save').click(function (e) {

            var id = $('#' + frontField + 'txtid').val();
            var role = $('#' + frontField + 'role').val();
            var status = $('#' + frontField + 'status').val();

            $('button').attr('disabled', 'disabled')
            $.ajax({
                type: "POST",
                url: "Users.aspx/updateRole",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: '{"id":"' + id + '","role":"' + role + '","status":"' + status + '"}',
                success: function (e) {
                    e = e.d
                    $('button').removeAttr('disabled')
                    Swal.fire({
                        icon: e[0],
                        title: e[1],
                        text: e[2],
                    }).then(function () {
                        if (e[0] === "success") {
                            $('#' + frontField + 'formEdit').attr("hidden","hidden")
                            window.location.reload();
                        }
                    })
                }

            });
            e.preventDefault();
        })
    </script>
</asp:Content>
