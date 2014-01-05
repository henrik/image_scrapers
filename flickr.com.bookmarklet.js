// Trigger on a photo page, e.g.
// http://www.flickr.com/photos/americanvintagehome/3655377927/in/photostream/
// or
// http://www.flickr.com/photos/tikitacky/8026494322/in/photostream/

var is=JSON.parse(document.body.innerHTML.match(/"sizes":({.*}),"secret"/)[1]); var url = "", max = 0; for (var k in is) { var x = is[k]; if (x.width>max) { url = x.url; max = x.width; } }; location.href=url
