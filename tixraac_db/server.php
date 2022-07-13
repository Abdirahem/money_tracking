<?php

	include "Connection.php";


		 $res = array();


			$sql = "Select * from users";
			// execute the query
			$result = mysqli_query($conn, $sql);

			while($row = mysqli_fetch_array($result))
			{
				 $new_row["user_id"] = $row["user_id"];
				 $new_row["email"] = $row["email"];
				 $new_row["fullname"] = $row["fullname"];
				 $new_row["password"] = $row["password"];
				 $new_row["registered_date"] = $row["registered_date"];

				array_push($res, $new_row);
			}

      header("Content-type: application/json", 'Charset: utf-8');
	    echo json_encode( $res, JSON_PRETTY_PRINT);


?>
