<?php

	include "Connection.php";


		 $res = array();

      if(isset($_POST["user_id"]))
      {
        $user_id = $_POST["user_id"];
        $sql = "Select * from transaction where user_id = '".$user_id."'";
        // execute the query
        $result = mysqli_query($conn, $sql);

        while($row = mysqli_fetch_array($result))
        {
           $new_row["type"] = $row["transaction_type"];
           $new_row["title"] = $row["transaction_title"];
           $new_row["tvalue"] = $row["transaction_value"];
           array_push($res, $new_row);
        }
      }



      header("Content-type: application/json", 'Charset: utf-8');
	    echo json_encode( $res = array('transactions' => $res, ), JSON_PRETTY_PRINT);


?>
