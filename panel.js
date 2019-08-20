przyciskDodaj = document.querySelectorAll('#dodaj');
napis = document.querySelectorAll('#plik');
przyciskUsun = document.querySelectorAll('#odjac');
odliczanie = 0;
napis1 = "";
przyciskDodaj.forEach((element, k) => {
    element.addEventListener("click", () => {
        var napis = document.querySelector('#plik' + k).textContent;
        for (var i = 0; i < napis.length; i++) {
            if (napis[i] == ".") {
                break;
            } else {
                napis1 += napis[i];
            }
        }
        console.log(napis.textContent);
        var input = document.querySelector('#tekst');
        input.value = napis1;
        var button = document.querySelector('#clickme');
        button.click();
        napis1="";
        input.value="";
    });
});

przyciskUsun.forEach((elementy, ks) => {

    elementy.addEventListener("click", () => {
        var asd = document.querySelector('#plik' + ks).textContent;
        for (var i = 0; i < asd.length; i++) {
            if (asd[i] == ".") {
                break;
            } else {
                napis1 += asd[i];
            }
        }
      
        var input = document.querySelector('#tekst');
        input.value = napis1 + ".json";
        var button = document.querySelector('#usuwaniePlikow');
        button.click();
    });
    console.log("asd");
});