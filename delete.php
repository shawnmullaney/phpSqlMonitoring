<?php
include_once 'dbconfig.php';

if($_POST['del_id'])
{
	$id = $_POST['del_id'];	
	$stmt=$db_con->prepare("DELETE FROM tbl_miners WHERE minerId=:id");
	$stmt->execute(array(':id'=>$id));	
}
?>
