require "sqlite3"

def load_pointer_chains(db_path)
  db = SQLite3::Database.new db_path
  sql = "SELECT moduleid, moduleoffset, offset1, offset2, offset3, offset4, offset5, offset6, offset7 FROM results"
  chains = []

  db.execute(sql) do |row|
    moduleid, moduleoffset, *offsets = row
    offsets = offsets.take_while { |o| !o.nil? } # Keep offsets until the first nil value
    if moduleid == 0
      chain = { moduleid: moduleid, moduleoffset: moduleoffset, offsets: offsets }
      chains << chain
    end
  end

  puts "Loaded #{chains.length} chains from #{db_path}"

  chains
rescue SQLite3::Exception => e
  puts "Database exception: #{e}"
  []
ensure
  db&.close
end

def find_common_chains(chains_sets)
  chains_sets.reduce do |common_chains, chains|
    common_chains & chains
  end
end

db_paths = %w[ mana-one.sqlite mana-two.sqlite mana-three.sqlite mana-six.sqlite ]
puts "Loading pointer chains from #{db_paths.join(", ")}..."

chains_sets = db_paths.map { |path| load_pointer_chains(path) }
puts "Loaded all pointer chains"

common_chains = find_common_chains(chains_sets)
puts "Found #{common_chains.length} common chains"

common_chains.each do |chain|
  puts "Stable chain found: ModuleOffset #{chain[:moduleoffset].to_s(16)}, Offsets #{chain[:offsets].map { |o| "0x" + o.to_s(16) }.join(" -> ")}"
end
