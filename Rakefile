require "rubygems"
require "tmpdir"
require 'open-uri'

require "bundler/setup"
require "jekyll"


# Change your GitHub reponame
GITHUB_REPONAME = "pastisrb/pastisrb.github.io"

desc "Generate blog files"
task :generate do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end

desc "Create .ics"
task :ics, [:date, :pastis_n] do |t, args|
  file_path = "downloads/ics/pastis_rb##{args[:pastis_n]}.ics"
  content = <<eos
BEGIN:VCALENDAR
PRODID:You-Must-Not-Know
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:PUBLISH
BEGIN:VEVENT
DTSTART:#{args[:date]}T183000Z
DTEND:#{args[:date]}T235900Z
URL:https://maps.google.fr/maps?hl=fr&q=La+Boate
CREATED:#{Time.now.strftime('%Y%m%d%H%M%S')}Z
DESCRIPTION:
LAST-MODIFIED:#{Time.now.strftime('%Y%m%d%H%M%S')}Z
LOCATION:La Boate
SEQUENCE:6
STATUS:CONFIRMED
SUMMARY:pastis.rb édition ##{args[:pastis_n]}
TRANSP:OPAQUE
END:VEVENT
END:VCALENDAR
eos
  ics = File.new(file_path, "w")
  ics.write(content)
  ics.close     
  system "echo /#{URI::encode(file_path)} | pbcopy"
  puts 'path to ics copyed to clipboard'
end

desc "Generate and publish blog to gh-pages"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    cp_r "_site/.", tmp
    Dir.chdir tmp
    system "git init"
    system "git add ."
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m #{message.inspect}"
    system "git remote add origin git@github.com:#{GITHUB_REPONAME}.git"
    system "git push origin master --force"
  end
end