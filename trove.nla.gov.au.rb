# Root page: http://trove.nla.gov.au/aww/covers

#YEARS = 1940..1967
YEARS = 1960..1960
QUALITY_LEVEL = 4  # 7 is highest at ~3200x4300 px; 4 is ~1700x2400
SAVE_TO = "#{ENV["HOME"]}/Downloads/AWW"

require "nokogiri"
require "open-uri"
require "fileutils"

YEARS.each do |year|
  year_url = "http://trove.nla.gov.au/aww/covers?year=#{year}"
  doc = Nokogiri(open(year_url))

  paths_and_dates = doc.search("dt").map { |dt| [ dt.at("a")[:href], dt.at("img")[:alt].sub("Cover of AWW, ", "") ] }

  paths_and_dates.each do |path, date_string|
    date = Date.parse(date_string)

    issue_dir = "#{SAVE_TO}/#{date} - #{date_string}"
    FileUtils.mkdir_p(issue_dir)

    issue_url = "http://trove.nla.gov.au#{path}"
    puts "#{issue_url} => #{issue_dir}"

    text = open(issue_url).read
    page_ids = text[/var pages = \[(.+)\];/, 1].gsub(/[^\d,]/, "").split(",")

    page_ids.each_with_index do |page_id, index|
      page_url = "http://trove.nla.gov.au/ndp/imageservice/nla.news-page#{page_id}/level#{QUALITY_LEVEL}"
      page_path = "#{issue_dir}/#{index}.jpg"
      File.write(page_path, open(page_url).read) unless File.exist?(page_path)
      puts "  Page #{index}/#{page_ids.length-1}"
    end
  end
end
