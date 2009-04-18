require 'test_helper'

class LicenseTest < Test::Unit::TestCase
  context "A license object" do
    
    setup do
      name = "Evan Walsh"
      email = "evan@nothingconcept.com"
      product = "License Gem Test"
      @license = License.new(name,email,product)
    end

    should "return the name supplied" do
      assert_equal "Evan Walsh", @license.name
    end
    
    should "return the email supplied" do
      assert_equal "evan@nothingconcept.com", @license.email
    end
    
    should "return the product supplied" do
      assert_equal "License Gem Test", @license.product
    end
    
    should "generate a license key" do
      assert_equal "3F7B-D428-ED3A-3636", @license.generate
    end
    
    should "return true when a valid key is validated" do
      assert_equal true, @license.validate(@license.generate)
    end
    
    should "return nil when an invalid key is validated" do
      assert_equal nil, @license.validate(@license.generate.reverse)
    end
    
  end
end
