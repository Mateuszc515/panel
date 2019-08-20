 <?php
 $res = $_GET['imie'];
$file = "./wys/prz/uploader/demo/backend/wys/${res}";

if (!unlink($file)) {
  echo ("Błąd ");
} else {
  echo ("Usunięto plik ");
}
?>