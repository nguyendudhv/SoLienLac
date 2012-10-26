<script type="text/javascript" >
	$(document).ready(function () {            
            var source ={
				datatype: "json",
				datafields:[{ name: 'UserName' },{ name: 'Email' },{ name: 'AccountId' }],
				url: '<?php echo base_url()."index.php/back_end/account/list_accout_ajax";?>'
			};
			var dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });
			$("#jqxgrid_account").jqxGrid({
				source: dataAdapter,
				theme: 'classic',
				width: 900,
				height:400,
                selectionmode: 'multiplerowsextended',
                enablehover:true,
                sortable: true,
                pageable: true,
                //autoheight: true,
                columnsresize: true,
                showstatusbar: true,
                renderstatusbar: function (statusbar) {
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                    var addButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../images/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Thêm</span></div>");
                    var deleteButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../images/close.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Xóa</span></div>");
                    var reloadButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../images/refresh.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Tải lại</span></div>");
                    var searchButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../images/search.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Tìm kiếm</span></div>");
                    container.append(addButton);
                    container.append(deleteButton);
                    container.append(reloadButton);
                    container.append(searchButton);
                    statusbar.append(container);
                    addButton.jqxButton({theme: 'classic', width: 90, height: 20 });
                    deleteButton.jqxButton({ theme: 'classic', width: 65, height: 20 });
                    reloadButton.jqxButton({ theme: 'classic', width: 65, height: 20 });
                    searchButton.jqxButton({ theme: 'classic', width: 100, height: 20 });
                    // add new row.
                    addButton.click(function (event) {
                        var datarow = generatedata(1);
                        $("#jqxgrid_account").jqxGrid('addrow', null, datarow[0]);
                    });
                    // delete selected row.
                    deleteButton.click(function (event) {
                        var selectedrowindex = $("#jqxgrid_account").jqxGrid('getselectedrowindex');
                        var rowscount = $("#jqxgrid_account").jqxGrid('getdatainformation').rowscount;
                        if (selectedrowindex >= 0 && selectedrowindex < rowscount) {
                            var id = $("#jqxgrid").jqxGrid('getrowid', selectedrowindex);
                            $("#jqxgrid_account").jqxGrid('deleterow', id);
                        }
                    });
                    // reload grid data.
                    reloadButton.click(function (event) {
                        $("#jqxgrid_account").jqxGrid({ source: getAdapter() });
                    });
                    // search for a record.
                    /*searchButton.click(function (event) {
                        var offset = $("#jqxgrid").offset();
                        $("#jqxwindow").jqxWindow('open');
                        $("#jqxwindow").jqxWindow('move', offset.left + 30, offset.top + 30);
                    });*/
                    
                },
				columns: [
					{ text: '', datafield: 'STT', columntype: 'checkbox', width: 40,
                      renderer: function () {
                          return '<div style="margin-left: 10px; margin-top: 5px;"></div>';
                      }},
					{ text: 'Tên đăng nhập', datafield: 'UserName', width: 400 },
					{ text: 'Email', datafield: 'Email', width: 300 },
					{ text: 'Thao tac', datafield: 'AccountId', cellsrenderer: function () {
					return "<img id='editRow' src='../../images/edit.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Sua\"><img id='deleteRow' src='../../images/delete.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Xoa\"/>";
                     //return "<img id='editRow' src='../../images/edit.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Sua\"><img id='deleteRow' src='../../images/delete.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Xoa\" onclick=\"return confirm(\'Ban co chac chan xoa hay khong?')\"/>";
	                }
                 },
				]
			});
			$("#popupWindow").jqxWindow({  height:150, width: 300, resizable: false, theme: 'classic', isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
			$('img#editRow').live('click',function(){
				var offset = $("#jqxgrid_account").offset();
                $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 100} });
				var selectedRowsCount = $("#jqxgrid_account").jqxGrid('getselectedrowindexes');
                var rowData = $("#jqxgrid_account").jqxGrid('getrowdata',selectedRowsCount);
                $('input#AccountId').val(rowData.AccountId);
                $('input#UserName').val(rowData.UserName);
                $('input#Email').val(rowData.Email);
                $("#popupWindow").jqxWindow('show');
			});
			
			$('img#deleteRow').live('click',function(){
				if(confirm('Bạn có chắc chắn xóa hay không?'))
				{
					var selectedRowsCount = $("#jqxgrid_account").jqxGrid('getselectedrowindexes');
	                var rowData = $("#jqxgrid_account").jqxGrid('getrowdata',selectedRowsCount);
	                $.ajax({
		            url: '<?php echo base_url();?>/index.php/back_end/account/DeleteAccountById?id='+rowData.AccountId,
		            type:'POST',
		            success: function(d){
		            		if(d=="0")
		            		{
		            			alert('Khong ton tai account');
		            		}
		            		else if(d=="2")
		            		{
		            			alert('Xoa thanh cong');
		            			$("#jqxgrid_account").jqxGrid('updatebounddata');
		            		}
		                    else
		                    {
		                    	alert('Khong the xoa');
		                    }
		                } // End of success function of ajax form
		            }); // End of ajax call 
	            }
			});
			 // initialize the popup window and buttons.
            
            $("#Cancel").jqxButton({ theme: 'classic' });
            $("#Save").jqxButton({ theme: 'classic' });
            // update the edited row when the user clicks the 'Save' button.
            $("#Save").click(function () {
                
            });
            $("#Cancel").click(function () {
                 $("#popupWindow").jqxWindow('hide');
            });
			
        });
</script>
<div id="jqxgrid_account">    
</div>
 <div id="pager">
 </div>
 <div id="popupWindow">
            <div>Cập nhập thông tin tài khoản</div>
            <form id='frmUpdateAccount'>
            	
            </form>
            <div style="overflow: hidden;">
                <table>
                    <tr>
                    	<input type="hidden" id="AccountId" />
                        <td align="right">Username:</td>
                        <td align="left"><input id="UserName" /></td>
                    </tr>
                    <tr>
                        <td align="right">Email:</td>
                        <td align="left"><input id="Email" /></td>
                    </tr>
                    <tr>
                        <td align="right"></td>
                        <td style="padding-top: 10px;" align="right">
                        <input style="margin-right: 5px;" type="button" id="Save" value="Save" /><input id="Cancel" type="button" value="Cancel" /></td>
                    </tr>
                </table>
            </div>
       </div>
		