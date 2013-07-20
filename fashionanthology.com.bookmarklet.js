// Replaces thumbs with the full image, without watermark.
// Shows it downscaled for overview, but save it and it will be high-res.
// E.g. on http://www.fashionanthology.com/?act=galleries&do=pics&rec=420928

$(".img").css("width", "auto"); $(".img img").css("max-width", "200px"); $("img").each(function() { this.src = this.src.replace("_xs.jpg", ".jpg") })
