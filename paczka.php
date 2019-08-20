<?php
$servername = "localhost";
$username = "makeupma_admin20";
$password = "XyvPn7Js8rkDkn7";
$dbname = "makeupma_nowysklep";

      //File Name
      $filename = "Zamówienie";  
      $file_ending = "xls";
      // //header info for browser
      header("Content-Type: application/xls");    
      header("Content-Disposition: attachment; filename=$filename.xls");  
      header("Pragma: no-cache"); 
      header("Expires: 0");
//ps_order_payment jaka forma wysyłki 
/*
order_reference - numer zamowienia tak jak w sytemie;
amount - cena ostateczna;

*/
//ps_order_detail wszystkie dane dla sklepu 
/*
id_order_detail - numer zamówienia
product_ean13 - produkt ean
unit_price_tax_incl - cena produktu bez wysyłki
id_order - jeżeli jest ta sama cyfra to to samo zamowienie 
	product_quantity - ilość zamowionego produktu 
*/

// Create connection
$mysqli = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
} 



$query = "SELECT * FROM ps_order_detail";
$query1 = "SELECT * FROM ps_order_payment";
$query2 = "SELECT * FROM ps_orders";
$query3 = "SELECT * FROM ps_order_carrier";
$query4 = "SELECT * FROM ps_orders";
$booksArray = array();
if ($result = $mysqli->query($query)) {
 
    while ($rows[]  = $result->fetch_array(MYSQLI_NUM));
         
    $result->free();
}
// echo "ile ilość: " . $rows[137][1]. " "; // ile zamówień 
// echo "ile ilość: " . $rows[137][8]. " "; // ilość 
// echo "ean: " . $rows[137][20]. " "; // ile ean 
// echo "cena: " . $rows[137][13]. " "; // ile cena 
// echo "nazwa: " . $rows[137][7]. " "; // ile nazwa 
if ($result1 = $mysqli->query($query1)) { 
 
    while ($rows1[]  = $result1->fetch_array(MYSQLI_NUM));
         
    $result1->free();
}  
// echo "numer zamówienia unikatowy: " . $rows1[50][1]. " "; // kod ean


if ($result2 = $mysqli->query($query2)) {
 
    while ($rows2[]  = $result2->fetch_array(MYSQLI_NUM));
         
    $result2->free();
}  
if ($result3 = $mysqli->query($query3)) {
 
    while ($rows3[]  = $result3->fetch_array(MYSQLI_NUM));
         
    $result3->free();
}  
if ($result4 = $mysqli->query($query4)) {
 
    while ($rows4[]  = $result4->fetch_array(MYSQLI_NUM));
         
    $result4->free();
}  

/* close connection */
// count($rows1)
$sep = "\t";
// 12
for($z=1; $z<count($rows4);$z++) //Pobiera liczbę pól z zapytania.
{
    if($rows4[$z][12] != 4)
    {
    
        //  $dodaj = $rows4[$z][2];
        //  $dodaj1 = count($rows) +$dodaj -1;
        //  echo "test      ".$rows[139][1];
        //  echo "test         ".$rows4[$z][2];
        //  echo "test      ".count($rows);
          for($r = 0; $r<count($rows);$r++)
          {
            if($rows[$r][1] == $rows4[$z][2])
            {
                $dodaj2 = $rows[$r][0];
                // echo "tutaj      ".$dodaj2."<br>";
                // echo "140      <br>";
                break;
            }
          }
      for($i=$dodaj2-1; $i<count($rows);$i++) //Pobiera liczbę pól z zapytania.
        {
     
            $numerZamówieniaM = $rows[$i][1];
          
            //  echo "testasd      ".$numerZamówieniaM."<br>";
             if($numerZamówieniaM == $numerZamówieniaN+1){
                echo "".$sep;
                echo "".$sep;
                if($rows3[$i][5].$sep == 12.900000)
                {
                    echo "0129000".$sep ; // ile CENA DOSTAWY
                }
                else if($rows3[$i][5].$sep == 9.900000)
                {
                    echo "099000".$sep ; // ile CENA DOSTAWY
                }
                else if($rows3[$i][5].$sep == 12.000000)
                {
                    echo "012000".$sep ; // ile CENA DOSTAWY
                }
                else if($rows3[$i][5].$sep == 15.000000)
                {
                    echo "0150000".$sep ; // ile CENA DOSTAWY
                }
                else if($rows3[$i][5].$sep == 0000000)
                    {
                    echo "00000".$sep ; // ile CENA DOSTAWY
                }
                break;
            }
                $w = 0;
                if($rows[$i][1] == $rows[$i+$w][1])
                { 
                    $numerZamówieniaN = $rows[$i][1];
                // echo $rows[$i+$w][1]. " ".$rows1[$i][1]."    "; // ilość 
                    echo "".$sep;
                    echo "".$sep;
                    echo $rows[$i+$w][20].$sep; // ile ean 
                    echo $rows[$i+$w][7].$sep; // ile nazwa
                    echo "".$sep;
                    echo "".$sep;
                    echo $rows[$i+$w][13].$sep; // ile cena 
                    echo $rows[$i+$w][8].$sep; // ilość 
                $w++;
                print "\n";
                
                }
                else if($rows[$i][1] == $rows[$i][1])
                {    
                    
                    // echo $rows[$i][1]. " ".$rows1[$i][1]."    "; // ilość 
                    echo "".$sep;
                    echo "".$sep;
                    echo $rows[$i][20].$sep; // ile ean
                    echo $rows[$i][7].$sep ; // ile nazwa 
                echo "".$sep;
                    echo "".$sep;
                echo $rows[$i][13].$sep; // ile cena 
                echo $rows[$i][8].$sep; // ilość 
                print "\n";
                    echo "".$sep;
                    echo "".$sep;
                    
                    if($rows3[$i][5].$sep == 12.900000)
                    {
                        echo "0129000".$sep ; // ile CENA DOSTAWY
                    }
                    else if($rows3[$i][5].$sep == 9.900000)
                    {
                        echo "099000".$sep ; // ile CENA DOSTAWY
                    }
                    else if($rows3[$i][5].$sep == 12.000000)
                    {
                        echo "012000".$sep ; // ile CENA DOSTAWY
                    }
                    else if($rows3[$i][5].$sep == 15.000000)
                    {
                        echo "0150000".$sep ; // ile CENA DOSTAWY
                    }
                    else if($rows3[$i][5].$sep == 0000000)
                    {
                        echo "00000".$sep ; // ile CENA DOSTAWY
                    }
                // echo $rows3[$i][5].$sep ; // ile CENA DOSTAWY  
                    break;
                }
                
        }
        break;
    }
    
    }
$mysqli->close();
$schema_insert = str_replace($sep."$", "", $schema_insert);
        $schema_insert = preg_replace("/\r\n|\n\r|\n|\r/", " ", $schema_insert);
        $schema_insert .= "\t";
?>