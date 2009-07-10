# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flannel}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamal Hansen"]
  s.date = %q{2009-07-09}
  s.email = %q{jamal.hansen@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "features/external_link.feature",
     "features/fixtures/external_link.flannel",
     "features/fixtures/external_link.out",
     "features/fixtures/list.flannel",
     "features/fixtures/list.out",
     "features/fixtures/paragraph.flannel",
     "features/fixtures/paragraph.out",
     "features/fixtures/preformatted.flannel",
     "features/fixtures/preformatted.out",
     "features/fixtures/wiki_links.flannel",
     "features/fixtures/wiki_links.out",
     "features/fixtures/wiki_links_for_lambda.out",
     "features/fixtures/wiki_links_for_lamdba.flannel",
     "features/list.feature",
     "features/paragraph.feature",
     "features/preformatted_text.feature",
     "features/step_definitions/flannel_steps.rb",
     "features/support/env.rb",
     "features/wiki_links.feature",
     "lib/cutting_board.rb",
     "lib/flannel.rb",
     "lib/shears.rb",
     "lib/square.rb",
     "lib/stripe.rb",
     "lib/wrappable.rb",
     "test/cutting_board_test.rb",
     "test/flannel_test.rb",
     "test/shears_test.rb",
     "test/square_test.rb",
     "test/stripe_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rubyyot/flannel}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flannel}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A soft comfortable worn in markup language for Ruby}
  s.test_files = [
    "test/shears_test.rb",
     "test/stripe_test.rb",
     "test/test_helper.rb",
     "test/cutting_board_test.rb",
     "test/square_test.rb",
     "test/flannel_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<technicalpickles-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<technicalpickles-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<technicalpickles-shoulda>, [">= 0"])
  end
end
