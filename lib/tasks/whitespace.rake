desc 'List files containing trailing whitespace; specify format with FORMAT=other'
task :whitespace do
  format = ENV['FORMAT'] || 'markdown'
  files  = Dir.glob("**/*.#{format}")
  files.each do |file|
    lines = []
    File.open(file) do |f|
      f.each_with_index do |line, index|
        lines << index + 1 if (line.chomp =~ /\S+\s+$/)
      end
      if (lines.size > 0)
        puts file
        puts ' -- lines: ' + lines.join(', ')
      end
    end
  end
end
