class TvdbParser

  def self.parse_series(series_hash)
    #puts series_hash.class.name
    #series_hash
    series_hash.sort_by { |entry_hash| entry_hash["firstAired"] }.reverse!

    series_hash.map { |entry| Series.new(entry['id'],entry['seriesName'],entry['network'],entry['overview'],entry['status'],entry['banner'],entry['firstAired']) }
    #series_hash.each do |series_entry|
    #end
  end

  class Series < Struct.new(:id, :name, :network, :overview, :status, :banner, :first_aired)
    def to_str
      name + ' - ' + first_aired
    end
  end
end
