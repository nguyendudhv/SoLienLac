<script type="text/javascript" src="../../../js/jquery.validate.min.js"></script>
<script type="text/javascript" src="../../../js/messages_vi.js"></script>
<script type="text/javascript" >
	$(document).ready(function () {            
            var source ={
				datatype: "json",
				datafields:[{ name: 'Name' },{ name: 'Url' },{ name: 'MenuId' }],
				url: '<?php echo base_url()."index.php/back_end/menu/list_menu_ajax";?>'
			};
			
			var dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });
            $("#popupWindow").jqxWindow({  height:400, width: 500, resizable: false, theme: 'classic', autoOpen: false,isModal: true, modalOpacity: 0.3});
			$("#jqxgrid_menu").jqxGrid({
				source: dataAdapter,
				theme: 'classic',
				width: 900,
				height:400,
                selectionmode: 'multiplerowsextended',
                enablehover:true,
                sortable: true,
                pageable: true,
                rowdetails:true,
                columnsresize: true,
                showstatusbar: true,
                renderstatusbar: function (statusbar) {
                    // appends buttons to the status bar.
                    var container = $("<div style='overflow: hidden; position: relative; margin: 5px;'></div>");
                    var addButton = $("<div style='float: left; margin-left: 5px;'><img id='addRow' style='position: relative; margin-top: 2px;' src='../../../images/add.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Thêm</span></div>");
                    var deleteButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../../images/close.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Xóa</span></div>");
                    var reloadButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../../images/refresh.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Tải lại</span></div>");
                    var searchButton = $("<div style='float: left; margin-left: 5px;'><img style='position: relative; margin-top: 2px;' src='../../../images/search.png'/><span style='margin-left: 4px; position: relative; top: -3px;'>Tìm kiếm</span></div>");
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
                    	$('#popupWindow').jqxWindow('setTitle', 'Thêm chức năng');
                        $("#popupWindow").jqxWindow('show');
                        $('input[type=text]').val('');
                    });
                    
                },
				columns: [
					{ text: '', datafield: 'STT', columntype: 'checkbox', width: 40,
                      renderer: function () {
                          return '<div style="margin-left: 10px; margin-top: 5px;"></div>';
                      }},
					{ text: 'Tên chức năng', datafield: 'Name', width: 400 },
					{ text: 'Liên kết', datafield: 'Url', width: 300 },
					{ text: 'Thao tác', datafield: 'MenuId', cellsrenderer: function () {
						return "<img id='editRow' src='../../../images/edit.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Sua\"><img id='deleteRow' src='../../../images/delete.gif'/ style='cursor:pointer;margin:3px 5px' title=\"Xoa\"/>";
	                }
                 },
				]
			});
			
			/*treeview menu*/
			var tree = $('#jqxTreeMenu');
            var source1 = [{ label: "Root", expanded: true,
                items: [
                    { label: "Root Folder 1", items: [{ value: "Child 1", label: 'Loading...'}] },
                    { label: "Root Folder 2", items: [{ value: "Child 2", label: 'Loading...'}] }
                ]
            }];
            tree.jqxTree({ source: source1, theme:'classic', width: 200 });
            tree.bind('expand', function (event) {
                if (tree.jqxTree('getItem', event.args.element).label == "Root")
                    return;
                var $element = $(event.args.element);
                var loader = false;
                var loaderItem = null;
                var children = $element.find('li');
                $.each(children, function () {
                    var item = tree.jqxTree('getItem', this);
                    if (item.label == 'Loading...') {
                        loaderItem = item;
                        loader = true;
                        return false
                    };
                });
                if (loader) {
                    $.ajax({
                        url: loaderItem.value,
                        success: function (data, status, xhr) {
                            var items = jQuery.parseJSON(data);
                            tree.jqxTree('addTo', items, $element[0]);
                            tree.jqxTree('removeItem', loaderItem.element);
                        }
                    });
                }
            });
			/*end treeview menu*/
			
			$('img#editRow').live('click',function(){
				var offset = $("#jqxgrid_menu").offset();
                $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 300, y: parseInt(offset.top) + 100} });
                $('#popupWindow').jqxWindow('setTitle', 'Cập nhập thông tin tài khoản');
				var selectedRowsCount = $("#jqxgrid_menu").jqxGrid('getselectedrowindexes');
                var rowData = $("#jqxgrid_menu").jqxGrid('getrowdata',selectedRowsCount);
                $('input#menuId').val(rowData.menuId);
                $('input#Name').val(rowData.Name);
                $('input#Url').val(rowData.Url);
                $("#popupWindow").jqxWindow('show');
			});
			
			$('img#deleteRow').live('click',function(){
				if(confirm('Bạn có chắc chắn xóa hay không?'))
				{
					var selectedRowsCount = $("#jqxgrid_menu").jqxGrid('getselectedrowindexes');
	                var rowData = $("#jqxgrid_menu").jqxGrid('getrowdata',selectedRowsCount);
	                $.ajax({
		            url: '<?php echo base_url();?>/index.php/back_end/menu/DeletemenuById?id='+rowData.MenuId,
		            type:'POST',
		            success: function(d){
		            		if(d=="0")
		            		{
		            			alert('Khong ton tai menu');
		            		}
		            		else if(d=="2")
		            		{
		            			alert('Xoa thanh cong');
		            			$("#jqxgrid_menu").jqxGrid('updatebounddata');
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
            $("#Cancel").click(function () {
                 $("#popupWindow").jqxWindow('hide');
            });
            
            //Validate form
            $("#frmUpdateMenu").validate({
				errorElement: "span", // Định dạng cho thẻ HTML hiện thông báo lỗi
				submitHandler: function() {
					var selectedRowsCount = $("#jqxgrid_menu").jqxGrid('getselectedrowindexes');
		            var rowData = $("#jqxgrid_menu").jqxGrid('getrowdata',selectedRowsCount);
	                $.ajax({
			            //url: '<?php echo base_url();?>/index.php/back_end/menu/UpdatemenuById/'+rowData.menuId+'/'+$('#Name').val()+'/'+$('#Url').val(),
			            url: rowData.menuId!=0?'<?php echo base_url();?>/index.php/back_end/menu/UpdatemenuById?id='+rowData.menuId+'&Name='+$('#Name').val()+'&Url='+$('#Url').val():'<?php echo base_url();?>/index.php/back_end/menu/Insertmenu?Name='+$('#Name').val()+'&Url='+$('#Url').val(),
			            type:'POST',
			            success: function(d){
			            		if(d=="0")
			            		{
			            			$("#popupWindow").jqxWindow('hide');
			            			alert('Khong ton tai menu');
			            		}
			            		else if(d=="1")
			            		{
			            			$("#popupWindow").jqxWindow('hide');
			            			$("#jqxgrid_menu").jqxGrid('updatebounddata');
			            			//alert('Cap nhap thanh cong');
			            			
			            		}
			            		else
			            		{
			            			$("#popupWindow").jqxWindow('hide');
			            			alert('Cap nhap khong thanh cong');
			            		}
			                } 
			            }); // End of ajax call
				},
				rules: {
					cpassword: {
						equalTo: "#password" // So sánh trường cpassword với trường có id là password
					},
					min_field: { min: 5 }, //Giá trị tối thiểu
					max_field: { max : 10 }, //Giá trị tối đa
					range_field: { range: [4,10] }, //Giá trị trong khoảng từ 4 - 10
					rangelength_field: { rangelength: [4,10] } //Chiều dài chuỗi trong khoảng từ 4 - 10 ký tự
				}
			});
			
                
        });
</script>
<div id="jqxgrid_menu">    
</div>
 <div id="pager">
 </div>
 <div id="popupWindow">
            <div>Cập nhập thông tin chức năng</div>
            <div style="overflow: hidden;">
            	<div id="jqxTreeMenu" style="float:left;width:200px;overflow:auto">
            		
            	</div>
	            <form id='frmUpdateMenu' style="float:right">
		                <table>
		                    <tr>
		                    	<input type="hidden" id="menuId" />
		                        <td align="right">Tên chức năng:</td>
		                        <td align="left"><input id="Name" type="text" class="required" /></td>
		                    </tr>
		                    <tr>
		                        <td align="right">Liên kết:</td>
		                        <td align="left"><input id="Url" type="text" class="required Url" /></td>
		                    </tr>
		                    <tr>
		                        <td align="right"></td>
		                        <td style="padding-top: 10px;" align="right">
		                        <input style="margin-right: 5px;" type="submit" id="Save" value="Save" />
		                        <input id="Cancel" type="button" value="Cancel" />
		                        </td>
		                    </tr>
		                </table>
	            	
	            </form>
            </div>
       </div>
		