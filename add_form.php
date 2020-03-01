
<style type="text/css">
#dis{
	display:none;
}
</style>


	
    
    <div id="dis">
    <!-- here message will be displayed -->
	</div>
        
 	
	 <form method='post' id='emp-SaveForm' action="#">
 
    <table class='table table-bordered'>
 
        <tr>
            <td>Miner IP</td>
            <td><input type='text' name='minerIp' class='form-control' placeholder='EX : 10.1.2.3' required /></td>
        </tr>
 
        <tr>
            <td>Mac Address</td>
            <td><input type='text' name='macAddress' class='form-control' placeholder='EX : AA:BB:CC:11:22:33' required></td>
        </tr>
 
        <tr>
            <td>Miner Type</td>
            <td><input type='text' name='minerType' class='form-control' placeholder='EX : Antminer S9' required></td>
        </tr>

        <tr>
            <td>Physical Position</td>
            <td><input type='text' name='location' class='form-control' placeholder='EX : 1-1-1-5' required></td>
        </tr>

        <tr>
            <td>Expected HashRate</td>
            <td><input type='text' name='hashrate' class='form-control' placeholder='EX : 13.5' required></td>
        </tr>
 
        <tr>
            <td colspan="2">
            <button type="submit" class="btn btn-primary" name="btn-save" id="btn-save">
    		<span class="glyphicon glyphicon-plus"></span> Save Miner
			</button>  
            </td>
        </tr>
 
    </table>
</form>
     
