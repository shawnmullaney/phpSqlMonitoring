<?php
include_once 'dbconfig.php';

if($_GET['edit_id'])
{
	$id = $_GET['edit_id'];	
	$stmt=$db_con->prepare("SELECT * FROM miners WHERE minerId=:id");
	$stmt->execute(array(':id'=>$id));	
	$row=$stmt->fetch(PDO::FETCH_ASSOC);
}

?>
<style type="text/css">
#dis{
	display:none;
}
</style>


	
    
    <div id="dis">
    
	</div>
        
 	
	 <form method='post' id='emp-UpdateForm' action='#'>
 
    <table class='table table-bordered'>
 		<input type='hidden' name='id' value='<?php echo $row['minerId']; ?>' />
        <tr>
            <td>Miner IP</td>
            <td><input type='text' name='minerIp' class='form-control' value='<?php echo $row['minerIp']; ?>' required></td>
        </tr>
 
        <tr>
            <td>Mac Address</td>
            <td><input type='text' name='macAddress' class='form-control' value='<?php echo $row['macAddress']; ?>' required></td>
        </tr>
 
        <tr>
            <td>Miner Type</td>
            <td><input type='text' name='minerType' class='form-control' value='<?php echo $row['minerType']; ?>' required></td>
        </tr>

        <tr>
            <td>Physical Location</td>
            <td><input type='text' name='location' class='form-control' value='<?php echo $row['location']; ?>' required></td>
        </tr>
 
 
        <tr>
            <td colspan="2">
            <button type="submit" class="btn btn-primary" name="btn-update" id="btn-update">
    		<span class="glyphicon glyphicon-plus"></span> Save Changes
			</button>
            </td>
        </tr>
 
    </table>
</form>
     
