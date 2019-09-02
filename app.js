var licznik = 0;
var licznik_z = 0;
var plik = "";
var tablica = [""];
var tablica2 = [""];
var zmianna = 0;
const input = document.querySelector("tekst");
document.addEventListener('input', (e) => {
  plik = e.target.value;

})


$(function () {


  $('#clickme').click(function () {
    plik = document.querySelector("#tekst").value;
    $.ajax({
      url: `https://makeupmania.com.pl/sklep/panel/wys/prz/uploader/demo/backend/wys/${plik}.json`,
      dataType: 'json',
      success: function (data) {
        var items = [];
        licznik++;
        if (licznik === 1) {
          $.each(data, function (key, val) {
            tablica[key] = val;
          });

        }
        $.each(data, function (key, val) {
          tablica2[key] = val;

        });

        for (key = 0; key < tablica.length; key++) {
          for (licz = 0; licz < tablica2.length; licz++) {

            if (tablica[key].EAN == tablica2[licz].EAN) {
              console.log(key);
              console.log(licz);
              items.push('<li class="list-group-item" id="' + "a" + key + licznik + '">' + tablica2[licz].EAN + '<p>' + tablica2[licz].CENA_NETTO + '</p>' + '</li>');
              licz = tablica2.length;
            } else if (licz == tablica2.length - 1) {
              items.push('<li class="list-group-item" id="' + key + licznik + '">' + "brak" + '<p>' + " brak " + '</p>' + '</li>');

            }
            licznik_z = licz + 1
          };

        }
        tablica2.length = 0

        $('<input/>', {
          'class': ` input${zmianna}`,

        }).appendTo('body');

        $('<button/>', {
          'class': `btn btn-success button${zmianna}`,
          html: "x"
        }).appendTo('body');
        zmianna++;

        $('<ul/>', {
          'class': 'interest-list',
          html: items.join('')
        }).appendTo('body');

      },
      statusCode: {
        404: function () {
          alert('eeeerrrooorrr !!!');
        }
      }

    });
  });

  $('#clickmee').click(function () {
    var osdw = "";
    var znsaksa = document.querySelector("ul").lastChild.id
    for (var a = 1; a < znsaksa.length; a++) {
      osdw += znsaksa[a];
    }
    console.log("input");
    // var ostatni = document.querySelector(`li#a${ile} p`);
    var ile2 = 1;
    for (var ile = 0; ile < osdw; ile++) {


      var tabela1 = document.querySelector('li#a' + ile + '1 p');
      var tabela2 = document.querySelector('li#a' + ile + '2 p');
      console.log('li#a' + ile + '1 p');
      console.log('li#a' + ile + '2 p');

      if (tabela2 == null || tabela1 == null) {
        console.log('nullesk');
      } else if (tabela1.textContent === tabela2.textContent) {
        console.log('tak');
        tabela2.style.backgroundColor = "yellow";
      } else if (tabela1.textContent < tabela2.textContent) {
        console.log('tak');
        tabela2.style.backgroundColor = "green";
      } else if (tabela1.textContent > tabela2.textContent) {
        console.log('tak');
        tabela2.style.backgroundColor = "red";
      }
    }
  });
});
// const asw = document.getElementById("clickmee");
// asw.addEventListener("click", () => {
//   const as = document.querySelector("#01");

// })