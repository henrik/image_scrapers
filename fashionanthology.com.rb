# Download all high-res images (more than the limited number of thumbs shown)
# from a fashionanthology.com gallery.

require "open-uri"
require "nokogiri"
require "fileutils"

LOCAL_DIR = File.expand_path("~/Downloads")

def download_index(url)
  Nokogiri(URI.open(url)).search("a.designer").each do |x|
    url = "http://www.fashionanthology.com/" + x[:href]
    name = x.text.gsub(/\s+/, " ").strip
    dir = LOCAL_DIR + "/" + name
    FileUtils.mkdir_p(dir)

    download_gallery(url, dir)
  end
end

def download_gallery(url, dir = LOCAL_DIR)
  base_image_url = "http://www.fashionanthology.com/" + URI.open(url).read[/"(image\.php.*?\.jpg)"/, 1]
  base_image_url.sub!("_m.jpg", ".jpg")

  1.upto(999) do |i|
    digit_count = base_image_url[/(\d+)\.jpg/, 1].length
    format_pattern = "%0#{digit_count}i.jpg"
    image_url = base_image_url.sub(format(format_pattern, 1), format(format_pattern, i))
    local_name = image_url[/\|(.*)/, 1]
    image_url = image_url.sub!("|", "%7C")

    puts local_name

    data = URI.open(image_url, "Referer" => "http://www.fashionanthology.com/").read

    if data.length == 0
      # No more images in this gallery.
      break
    else
      File.write("#{dir}/#{local_name}", data)
    end
    sleep 0.3
  end
end

#download_gallery "http://www.fashionanthology.com/?act=galleries&do=pics&rec=420510"
download_index "http://www.fashionanthology.com/?act=galleries&do=designers&rec=343"
