// Replaces URL with image URL.
// E.g. on http://blowuparchive.com/details.php?gal=BLOW-UP&image=3.%20Veruschka%20in%20_Blow-Up_%20(1966)%20by%20Arthur%20Evans.jpg

location.href = document.getElementsByTagName("embed")[0].src.replace(/\.com\/.*&img=/, ".com/");
