require 'test_helper'

class FlannelTest < Test::Unit::TestCase
  context "Flannel" do
    path_match = File.join("test", "fixtures", "*.flannel")
    files = Dir.glob(path_match)

    files.each do |flannel_filename|
      flannel = File.read(flannel_filename)
      out_filename = "#{flannel_filename[0..flannel_filename.index(".")]}out"

      should "convert #{flannel_filename} to be the same as #{out_filename}" do
        out = File.read(out_filename)
        assert_equal out, Flannel.to_h(flannel)
      end
    end
  end
end
