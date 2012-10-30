<script type="text/javascript" src="../../../js/jquery.validate.min.js"></script>
<script type="text/javascript" src="../../../js/messages_vi.js"></script>
<script type="text/javascript" >
	$(document).ready(function () {            
            var source ={
				datatype: "json",
				datafields:[{ name: 'MenuId' },{ name: 'Name' },{ name: 'Url' }],
				//url: '<?php echo base_url()."index.php/back_end/menu/list_menu_ajax";?>'
			};
			var dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });
            //$("#popupWindow").jqxWindow({  height:150, width: 300, resizable: false, theme: 'classic', autoOpen: false,isModal: true, modalOpacity: 0.3});
			$("#jqxgrid_account").jqxGrid({
				source: dataAdapter,
				theme: 'classic',
				width: 900,
				height:400,
                selectionmode: 'multiplerowsextended',
                enablehover:true,
                sortable: true,
                pageable: true,
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
					{ text: 'Tên chức năng', datafield: 'Name', width: 400 },
					{ text: 'Liên kết', datafield: 'Url', width: 300 }
				]
			});		
			
        });
</script>
<div id="jqxgrid_account">    
</div>
 <div id="pager">
 </div>