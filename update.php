<?php
require_once 'dbconfig.php';

	
	if($_POST)
	{
		$minerId = $_POST['minerId']; 
		$minerIp = $_POST['minerIp'];
		$macAddress = $_POST['macAddress'];
		$minerType = $_POST['minerType'];
		$location = $_POST['location'];
		
		$stmt = $db_con->prepare("UPDATE tbl_miners SET minerIp=:en, macAddress=:ed, minerType=:mt, location=:es WHERE minerId=:id");
		$stmt->bindParam(":en", $minerIp);
		$stmt->bindParam(":ed", $macAddress);
		$stmt->bindParam(":mt", $minerType);
		$stmt->bindParam(":es", $location);
		$stmt->bindParam(":id", $minerId);		
		
		if($stmt->execute())
		{
			echo "Successfully updated";
		}
		else{
			echo "Query Problem";
		}
	}

?>
