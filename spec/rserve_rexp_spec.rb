require File.dirname(__FILE__)+"/spec_helper.rb"

describe Rserve::REXP do
  before do
    @r=Rserve::Connection.new
  end
  describe "with matrix" do
    before {@m=@r.eval('matrix(c(1,2,3,4,5,6,7,8,9), 3,3)') }
    it "method as_integers should return correct values for original vector" do
      @m.as_integers.should==[1,2,3,4,5,6,7,8,9] # verification
    end
    it "method dim should return correct dimensions" do
      @m.dim.should==[3,3]
    end
    it "method as_double_matrix returns a valid double matrix" do
      @m.as_double_matrix.should==[[1,4,7],[2,5,8],[3,6,9]]
    end
    it "method as_matrix returns a valid standard library matrix" do
      @m=@r.eval('matrix(c(1,2,3,4,5,6,7,8,9), 3,3)')
      @m.as_matrix.should==Matrix[[1,4,7],[2,5,8],[3,6,9]]
    end
  end
  describe "common methods" do
    before do
      @v=@r.eval("c(1.5,2.5,3.5)")
      @l=@r.eval("list(at='val')")
    end
    it "method as_integer should return first value as integer" do
      @v.as_integer.should==1
    end
    it "method as_double should  return first value as float" do
      @v.as_double.should==1.5
    end
    it "method as_string should return first value as string (float representation)" do
      @v.as_string.should=="1.5"
    end
    it "method has_attribute? should return false for non-lists" do
      @v.has_attribute?('randomattribute').should be_false
    end
    it "method has_attribute? should return true for existing value" do
      @l.has_attribute?('names').should be_true
    end
    it "method has_attribute? should return false for non existing value" do
      @l.has_attribute?('at2').should be_false
    end
    it "method get_attribute should return correct value for attribute" do
      @l.get_attribute('names').as_strings.should==['at']
    end

  end

end