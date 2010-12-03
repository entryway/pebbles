Factory.define(:product_image) do |pi|
  pi.filename { File.open(File.join(Rails.root, 'features', 'fixtures', 'test.jpg')) }
end
