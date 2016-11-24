module Poto
  module FileRepository
    FileCollection = Struct.new("FileCollection", :files, :page, :next_page)
  end
end
