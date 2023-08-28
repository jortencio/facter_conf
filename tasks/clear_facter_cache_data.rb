#! /opt/puppetlabs/puppet/bin/ruby
# Task to clear out facter cache
require 'facter'

fact_cache_dir = if Facter.value('os')['family'] == 'windows'
                   'C:/ProgramData/PuppetLabs/facter/cache/cached_facts'
                 else
                   '/opt/puppetlabs/facter/cache/cached_facts'
                 end

all_files = Dir["#{fact_cache_dir}/*"]
all_files.each do |relative_file_name|
  # Make sure that the path is an absolute path
  file_path = File.expand_path(relative_file_name)

  # Delete only if it is a file
  next unless File.file?(file_path)

  # Delete the file
  File.unlink(file_path)

  puts "Deleted: #{file_path}"
end
