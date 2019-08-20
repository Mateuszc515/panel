<?php

$DB_Server = "localhost"; //MySQL Server    
$DB_Username = "makeupma_admin20"; //MySQL Username     
$DB_Password = "XyvPn7Js8rkDkn7";             //MySQL Password     
$DB_DBName = "makeupma_nowysklep";         //MySQL Database Name  
$DB_TBLName = "ps_order_payment"; //MySQL Table Name   
$DB_TBLName1 = "ps_order_detail"; //MySQL Table Name   
$filename = "excelfilename";         //File Name
/*******YOU DO NOT NEED TO EDIT ANYTHING BELOW THIS LINE*******/ 
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
//create MySQL connection   
$sql = "Select order_reference, amount from $DB_TBLName";
$sql1 = "Select id_order from $DB_TBLName1";
$Connect = @mysql_connect($DB_Server, $DB_Username, $DB_Password) or die("Couldn't connect to MySQL:<br>" . mysql_error() . "<br>" . mysql_errno());
//select database   
$Db = @mysql_select_db($DB_DBName, $Connect) or die("Couldn't select database:<br>" . mysql_error(). "<br>" . mysql_errno());   
//execute query 
$result = @mysql_query($sql,$Connect) or die("Couldn't execute query:<br>" . mysql_error(). "<br>" . mysql_errno());   
$result1 = @mysql_query($sql1,$Connect) or die("Couldn't execute query:<br>" . mysql_error(). "<br>" . mysql_errno());    
$file_ending = "xls";
//header info for browser
header("Content-Type: application/xls");    
header("Content-Disposition: attachment; filename=$filename.xls");  
header("Pragma: no-cache"); 
header("Expires: 0");
/*******Start of Formatting for Excel*******/   
//define separator (defines columns in excel & tabs in word)
$sep = "\t"; //tabbed character
//start of printing column names as names of MySQL fields
// for ($i = 0; $i < mysql_num_fields($result); $i++) { // pobiera liczbę pól z zapytania
// echo mysql_field_name($result,$i) . "\t"; // zwraca nazwę pola 
// }
print("\n");    
//end of printing column names  
//start while loop to get data
    while($row = mysql_fetch_row($result1)) // Zwraca tablicę numeryczną odpowiadającą pobranemu wierszowi i przesuwa wewnętrzny wskaźnik danych do przodu.
    {
       
        $schema_insert = "";
        for($j=0; $j<mysql_num_fields($result1);$j++) //Pobiera liczbę pól z zapytania.
        {
          
                if(!isset($row[$j])) //Określ, czy zmienna jest zadeklarowana i różni się odNULL
                    $schema_insert .= "NULL".$sep;
                elseif ($row[$j] != "")
                    $schema_insert .= "$row[$j]".$sep;
                else
                    $schema_insert .= "".$sep;
                    
        }
        $schema_insert = str_replace($sep."$", "", $schema_insert);
        $schema_insert = preg_replace("/\r\n|\n\r|\n|\r/", " ", $schema_insert);
        $schema_insert .= "\t";
        print(trim($schema_insert));
        print "\n";
    }   
?>