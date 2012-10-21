<script type="text/javascript" >
	$(document).ready(function () {            
            var source ={
				datatype: "json",
				datafields: [{ name: 'AccountId' },{ name: 'UserName' },{ name: 'Email' }],
				url: '<?php echo base_url()."index.php/back_end/account/list_accout_ajax";?>'
			};
			var dataAdapter = new $.jqx.dataAdapter(source, {
                downloadComplete: function (data, status, xhr) { },
                loadComplete: function (data) { },
                loadError: function (xhr, status, error) { }
            });
			$("#jqxgrid_account").jqxGrid({
				source: source,
				theme: 'classic',
				columns: [{ text: 'STT', datafield: 'AccountId', width: 100 },{ text: 'Tên đăng nhập', datafield: 'UserName', width: 300 },{ text: 'Email', datafield: 'Email', width: 300 }]
			});
        });
</script>
<div>
	<table id="jqxgrid_account">
    </table>
     <div id="pager">
     </div>
</div>
		