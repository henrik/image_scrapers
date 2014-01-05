// Trigger on a photo page, e.g.
// http://www.flickr.com/photos/americanvintagehome/3655377927/in/photostream/

location.href=document.getElementsByName("og:image")[0].content;
