
Given /^input of "([^\"]*)" text$/ do |feature|
  flannel_filename = File.join("features", "fixtures", "#{feature}.flannel")
  out_filename = File.join("features", "fixtures", "#{feature}.out")
  @before = File.read(flannel_filename)
  @after = File.read(out_filename)
  @wiki_link = nil
end

When /^I quilt it with flannel$/ do
  @output = Flannel.quilt @before, :wiki_link => @wiki_link
end

Then /^valid html should be produced$/ do
  assert_equal @after, @output
end

Given /^a formatter of '([^\"']*)'$/ do |formatter|
  @wiki_link = lambda { |keyword| eval formatter }
end
