<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <!-- CSS only -->
    <link rel="stylesheet" href="//cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <title></title>
  </head>
  <body>
    <div class="container" style="width: 70%;">
      <div class="col mt-5">
        <table class="table table-dark ">
          <thead>
            <th>ID</th>
              <th>Email</th>
                <th>Name</th>
                  <th>Password</th>
                    <th>Date</th>
          </thead>
          <tbody class="tbody">

          </tbody>
        </table>
      </div>
    </div>
    <script src="//cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>

    <script>
    fetch('http://localhost/tixraac/server.php')
    .then(function(response){
      return response.json();

    })
    .then(function(users){
      let tbodys = document.querySelector('.tbody');
      let out = "";


      for(let user in users){
          console.log(users[user]);
        out +=`
        <tr>
        <td>${users[user].user_id}</td>
        <td>${users[user].email}</td>
        <td>${users[user].fullname}</td>
        <td>${users[user].password}</td>
        <td>${users[user].registered_date}</td>
        </tr>
        `;
    }
      tbodys.innerHTML = out;
  });

  $(document).ready( function () {
    $('.table').DataTable();
} );
</script>
  </body>
</html>
