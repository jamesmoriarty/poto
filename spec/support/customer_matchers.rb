RSpec::Matchers.define :be_json_of_files do |expected|
  match do |actual|
    expect(actual[:_embedded][:files]).to eq expected
    expect(actual[:_links][:self]).to eq(href: "//example.org:80/files?page=Marker")
  end
end
