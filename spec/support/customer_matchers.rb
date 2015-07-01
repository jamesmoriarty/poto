RSpec::Matchers.define :be_json_of_files do |expected|
  match do |actual|
    expect(actual[:_embedded][:files].size).to eq expected.size
    expect(actual[:_links][:self]).to eq(href: "//example.org:80/files?page=")
    expect(actual[:_links][:next]).to eq(href: "//example.org:80/files?page=example.png")
  end
end
