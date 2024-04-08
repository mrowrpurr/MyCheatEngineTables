require "sqlite3"

def compare_rows(row1, row2)
  return 0 if row1[0] != row2[0] || row1[1] != row2[1]

  row1_offsets = row1[2..-1]
  row2_offsets = row2[2..-1]

  common_offsets = row1_offsets.zip(row2_offsets).take_while { |a, b| a == b }
  common_offsets.count
end

def format_row(row)
  row.map { |value| value.nil? ? "nil" : "0x#{value.to_s(16)}" }
end

if ARGV.length != 3
  puts "Usage: ruby BEST_COMPARE.rb <db1.sqlite> <db2.sqlite> <tolerance>"
  exit 1
end

db1_path = ARGV[0]
db2_path = ARGV[1]
tolerance = ARGV[2].to_i

db1 = SQLite3::Database.new(db1_path)
db2 = SQLite3::Database.new(db2_path)

db1_rows = db1.execute("SELECT moduleid, moduleoffset, offset1, offset2, offset3, offset4, offset5, offset6, offset7 FROM results")
db2_rows = db2.execute("SELECT moduleid, moduleoffset, offset1, offset2, offset3, offset4, offset5, offset6, offset7 FROM results")
puts "Comparing #{db1_path} and #{db2_path} with tolerance #{tolerance}..."

similar_rows = []

puts "Looking..."
i = 0
db1_rows.each do |row1|
  i += 1
  print "Row #{i}/#{db1_rows.length}\r"
  db2_rows.each do |row2|
    common_offsets_count = compare_rows(row1, row2)
    if common_offsets_count >= tolerance
      similar_rows << [row1, row2, common_offsets_count]
    end
  end
end
puts "Done!"

similar_rows.sort_by! { |row| -row[2] }

similar_rows.each do |row|
  formatted_row1 = format_row(row[0])
  formatted_row2 = format_row(row[1])
  puts "Row 1: #{formatted_row1.inspect}\nRow 2: #{formatted_row2.inspect}\nMatching offsets: #{row[2]}\n\n"
end
