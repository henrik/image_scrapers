# Download all high-res images (more than the limited number of thumbs shown)
# from a fashionanthology.com gallery.

require "open-uri"

URL = "http://www.fashionanthology.com/?act=galleries&do=pics&rec=420510"
LOCAL_DIR = File.expand_path("~/Downloads")

base_image_url = "http://www.fashionanthology.com/" + open(URL).read[/"(image\.php.*?\.jpg)"/, 1]
base_image_url.sub!("_m.jpg", ".jpg")

1.upto(999) do |i|
  image_url = base_image_url.sub("001.jpg", format("%03i.jpg", i))
  local_name = image_url[/\|(.*)/, 1]
  image_url = image_url.sub!("|", "%7C")

  puts local_name

  data = open(image_url, "Referer" => "http://www.fashionanthology.com/").read

  if data.length == 0
    # No more images in this gallery.
    break
  else
    File.write("#{LOCAL_DIR}/#{local_name}", data)
  end
  sleep 0.3
end
