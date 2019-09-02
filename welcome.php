<?php
// Initialize the session
session_start();
 
// Check if the user is logged in, if not then redirect him to login page
if(!isset($_SESSION["loggedin"]) || $_SESSION["loggedin"] !== true){
    header("location: index.php");
    exit;
}
?>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css">
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="style.css">
    <title>Panel zarządzania makeupmania</title>
 
    <script type="text/javascript" src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-1.7.1.min.js"></script>
  
    <script type="text/javascript" src="app.js"></script>
  
    <style>
        ul {
            float: left;
            margin: 5px 5px;
        }
        ol {
            float: left;
            margin: 5px 5px;
        }

        li {
            /* border: 2px solid rgb(165, 66, 66); */
            text-align: center;
            padding-top: 10px;
            /* list-style-type: none; */
        }
        
        .clearfix::after {
  content: "";
  clear: both;
  display: table;
}
      
    </style>
    <style type="text/css">
        body{ font: 14px sans-serif; text-align: center; }
    </style>
</head>
<body>
    <div class="page-header">
        <h1>Cześć, <b><?php echo htmlspecialchars($_SESSION["username"]); ?></b>.Witaj w panelu zarządzania.</h1>
    </div>
    <p>
        <a href="reset-password.php" class="btn btn-warning">Zmiana hasła</a>
        <a href="logout.php" class="btn btn-danger">Wyloguj</a>
    </p>
    
        
   
    <div>
    <h1 style="text-align: center" id="title">Panel zarządzania</h1>
    </div>
    <div style="width: 150px;display:inline-block;">
    <form action="usun.php" method="GET">
            <input class="form-control" name="imie" aria-describedby="emailHelp" placeholder="Nazwa bazy" id="tekst" type="text" />
        </div>
    <button type="button" class="btn btn-primary" id="clickme">DODAJ</button>
    <input  type=submit class="btn btn-success" id="usuwaniePlikow" name="size" value="Usuń">
    </form>
    <button type="button" class="btn btn-success" id="clickmee">Szczegóły</button>
    <a type="button" class="btn btn-primary" href="./wys/prz/uploader/demo/">Prześlij plik</a>
    <a type="button" class="" id="clickmeee" href="paczka.php">Pobierz paczki</a>
   
    <button type="button" class="btn btn-success" id="lista">Rozwiń liste</button>
  
        <div class="lista">
            
            <ol style="display:none" id="zwinRozwin">
            <h3>Baza danych</h3>
    <?
    $dir = opendir('./wys/prz/uploader/demo/backend/wys');
    $i = 0;
while(false !== ($file = readdir($dir)))
  if($file != '.' && $file != '..') {
    $file = "<li style='float:left; margin-top:5px'  class='list-group-item' id='plik{$i}'>{$file} </li><button style=' margin-top:10px' id='dodaj' type='button' class='btn btn-success' id='clickme'>+</button>
    <button style=' margin-top:10px' id='odjac' type='button' class='btn btn-danger' id='clickmee'>-</button>
    <div class='clearfix'></div>
   "

   ;
  echo $file;
  $i++;
}
?> 
</ol>

    </div>
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
    <script>
  var baza = document.querySelector("#lista");
var zwinRozwin = document.querySelector("#zwinRozwin");

var flaga1 = true;
baza.addEventListener("click", () => {

  if (flaga1) {
    
    zwinRozwin.style.display = "block";
    flaga1 = false;
    baza.textContent = "Zwiń baze"
  } else {
    zwinRozwin.style.display = "none";
    flaga1 = true;
    baza.textContent = "Rozwiń baze"
  }
});
    
    </script>
    <script type="text/javascript" src="panel.js"></script>
    
</body>

</html>