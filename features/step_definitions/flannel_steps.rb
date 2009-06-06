
Given /^input of "([^\"]*)" text$/ do |feature|
  flannel_filename = File.join("features", "fixtures", "#{feature}.flannel")
  out_filename = File.join("features", "fixtures", "#{feature}.out")
  @before = File.read(flannel_filename)
  @after = File.read(out_filename)
end

When /^I quilt it with flannel$/ do
  @output = Flannel.quilt(@before)
end

Then /^valid html should be produced$/ do
  assert_equal @after, @output
end