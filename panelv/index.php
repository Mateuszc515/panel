<?php
$servername = "localhost";
$username = "makeupma_admin20";
$password = "XyvPn7Js8rkDkn7";
$dbname = "makeupma_nowysklep";

$mysqli = new mysqli($servername, $username, $password, $dbname);
$query4 = "SELECT * FROM ps_orders";
$booksArray = array();
$flaga = false;
if ($result4 = $mysqli->query($query4)) {
 
    while ($rows4[]  = $result4->fetch_array(MYSQLI_NUM));
         
    $result4->free();
}  
for($z=1; $z<count($rows4);$z++) //Pobiera liczbę pól z zapytania.
{
    if($rows4[$z-1][12] != 4)
    {
        $flaga = true;
    }
}

?>

<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <title>Panel zarządzania makeupmania</title>
    <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="app.js"></script>
    <script type="text/javascript" src="appp.js"></script>
    <style>
        ul {
            float: left;
            margin: 5px 5px;
        }

        li {
            /* border: 2px solid rgb(165, 66, 66); */
            text-align: center;
            padding-top: 10px;
            /* list-style-type: none; */
        }
    </style>
</head>

<body>

    <input class="form-control" aria-describedby="emailHelp" placeholder="Nazwa bazy" id="tekst" type="text" /><div style="weight: 100vw">
    <h1 style="text-align: center" id="title">Panel zarządzania</h1>
    </div>
    <button type="button" class="btn btn-primary" id="clickme">DODAJ</button>
    <button type="button" class="btn btn-success" id="clickmee">Sortuj</button>
    <a type="button" class="" id="clickmeee" href="paczka.php">Pobierz paczki</a>
    <script type="text/javascript">
       var button = document.querySelector("#clickmeee");
       var flaga = "<?php echo $flaga ?>";
        
        if(flaga)
        {
            button.className += " btn btn-warning";
        }
        else{  
            button.disabled=true;
            button.className += " btn btn-light";
            
        }
    </script>
</body>


</html>