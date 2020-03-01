<?php
require_once 'dbconfig.php';

	
	if($_POST)
	{
		$minerIp = $_POST['minerIp'];
		$macAddress = $_POST['macAddress'];
		$minerType = $_POST['minerType'];
		$location = $_POST['location'];
		$hashrate = $_POST['hashrate'];
		
		try{
			
			$stmt = $db_con->prepare("INSERT INTO miners(minerIp,macAddress,minerType,location,hashrate) VALUES(:ename, :edept, :mtype, :esalary, :esalary2)");
			$stmt->bindParam(":ename", $minerIp);
			$stmt->bindParam(":edept", $macAddress);
			$stmt->bindParam(":mtype", $minerType);
			$stmt->bindParam(":esalary", $location);
			$stmt->bindParam(":esalary2", $hashrate);
			
			if($stmt->execute())
			{
				echo "Successfully Added";
			}
			else{
				echo "Query Problem";
			}	
		}
		catch(PDOException $e){
			echo $e->getMessage();
		}
	}

?>
