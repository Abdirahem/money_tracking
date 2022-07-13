<?php

 include "Connection.php";

 		 $return["error"] = false;
  		 $return["message"] = "";

		 $val = (isset($_POST["transactionType"]) && isset($_POST["transactionTitle"])
         && isset($_POST["transactionValue"]) && isset($_POST["user_id"]));
     //
         if($val){

         		$transactionType = $_POST["transactionType"]; //grabing the data from headers
       			$transactionTitle = $_POST["transactionTitle"];
       			$transactionValue = $_POST["transactionValue"];
       			$user_id = $_POST["user_id"];

            // $transactionType = "expense";
            // $transactionTitle = "Gift for kids";
            // $transactionValue = "300";
            // $user_id = "10";
         		 // validation name if there is no error before
			       // if($return["error"] == false && $user_id != null){
			       //     $return["error"] = true;
			       //     $return["message"] = "User";
			       // }

			       if($return["error"] == false){

			       	$query = "INSERT INTO transaction (`transaction_type`, `transaction_title`, `transaction_value`,`registered_date`,  `user_id`) VALUES ('".$transactionType."','".$transactionTitle."','".$transactionValue."',null,'".$user_id."')";
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
