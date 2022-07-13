<?php

	include "Connection.php";

	// variables
	$return["message"]='';
	$return["error"]= false;
	$return["success"]= false;

// if is data isset in the fields
	if(isset($_POST["email"]) && isset($_POST["password"]))
	{
	// 	// varibales for our submited data
			$email = $_POST["email"];
			$password = $_POST["password"];

			 $email = mysqli_real_escape_string($conn, $email);
			 $password = mysqli_real_escape_string($conn, $password);

				// $email = "hem@gmail.com";
				// $password = "12345";

			// sql query for reading users data
			$sql = "Select * from users where email ='".$email."' and password = '".$password."'";
			// execute the query
			$result = mysqli_query($conn, $sql);
			// read number of rows of this user
			$numrow = mysqli_num_rows($result);
			// checking number of rows
			if($numrow > 0)
			{
				// create obj of user data and assign users data from database
				$obj = mysqli_fetch_object($result);


				//hold user data for future use
				$return["uid"] = $obj->user_id;
				$return["fname"] = $obj->fullname;
				$return["success"] = true;
			}
			else {
				// checking if user has rows of data
				$return["error"] = true;
				$return["message"] = "We didn't found a data for this user";
			}

	}
	else
	{
		// checking is user filled all the fields
		$return["error"] = true;
		$return["message"] = "Please enter values";
	}

 header("Content-type: application/json", 'Charset: utf-8');
	echo json_encode( $return );


?>
