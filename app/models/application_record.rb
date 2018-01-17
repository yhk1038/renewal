class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    scope :filter, -> (records, associated_children, count) do
        arr = []
        records.each do |res|
            eval("arr << res unless res.#{associated_children}.count.zero?")
            break if arr.count >= count
        end
        arr
    end
end

