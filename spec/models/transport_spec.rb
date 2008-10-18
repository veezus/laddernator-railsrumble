require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Transport do
  describe "validations" do
    it "should require an address" do
      transport = Transport.new
      transport.valid?
      transport.errors.should be_invalid(:address)
    end
  end
end
