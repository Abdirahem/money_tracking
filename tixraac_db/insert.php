<?php

 include "Connection.php";

 		 $return["error"] = false;
  		 $return["message"] = "";

		 $val = (isset($_POST["email"]) && isset($_POST["name"])
         && isset($_POST["password"]) && isset($_POST["retypePassword"]));
         
         if($val){

         		$email = $_POST["email"]; //grabing the data from headers
       			$name = $_POST["name"];
       			$password = $_POST["password"];
       			$retypePass = $_POST["retypePassword"];


         		 //validation name if there is no error before
			       if($return["error"] == false && $retypePass != $password){
			           $return["error"] = true;
			           $return["message"] = "Enter the same password";
			       }
			       
			       if($return["error"] == false){

			       	$query = "INSERT INTO users (`email`, `fullname`, `password`, `registered_date`) VALUES ('".$email."', '".$name."','".$password."', null)";
			       		$result = mysqli_query($conn, $query);
			       		if($result){
			       		$return["error"] = false;
						$return["message"]  = "succefully Regisetered";
						}
						else{
							$return["error"] = true;
							$return["message"] = "Database error";
						}

			       }
		
         }
         else{
         	$return["error"] = true;
			$return["message"] = "Please fill all the fields";
         } 


 		echo json_encode($return);

	
?>