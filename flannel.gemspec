# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flannel}
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamal Hansen"]
  s.date = %q{2010-01-10}
  s.email = %q{jamal.hansen@gmail.com}
  s.executables = ["quilt-it~", "quilt-it"]
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
     "bin/quilt-it",
     "features/external_link.feature",
     "features/feed.feature",
     "features/fixtures/devlicious.rss",
     "features/fixtures/external_link.flannel",
     "features/fixtures/external_link.out",
     "features/fixtures/feed.flannel",
     "features/fixtures/feed.out",
     "features/fixtures/list.flannel",
     "features/fixtures/list.out",
     "features/fixtures/paragraph.flannel",
     "features/fixtures/paragraph.out",
     "features/fixtures/preformatted.flannel",
     "features/fixtures/preformatted.out",
     "features/fixtures/rubyyot.rss",
     "features/fixtures/wiki_links.flannel",
     "features/fixtures/wiki_links.out",
     "features/fixtures/wiki_links_for_lambda.flannel",
     "features/fixtures/wiki_links_for_lambda.out",
     "features/list.feature",
     "features/paragraph.feature",
     "features/preformatted_text.feature",
     "features/step_definitions/flannel_steps.rb",
     "features/support/env.rb",
     "features/wiki_links.feature",
     "flannel.gemspec",
     "lib/flannel.rb",
     "lib/flannel/cutting_board.rb",
     "lib/flannel/feed_parser.rb",
     "lib/flannel/shears.rb",
     "lib/flannel/square.rb",
     "lib/flannel/stripe.rb",
     "lib/flannel/wrappable.rb",
     "test/cutting_board_test.rb",
     "test/feed_parser_test.rb",
     "test/flannel_test.rb",
     "test/shears_test.rb",
     "test/square_test.rb",
     "test/stripe_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/rubyyot/flannel}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flannel}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A soft comfortable worn in markup language for Ruby}
  s.test_files = [
    "test/test_helper.rb",
     "test/stripe_test.rb",
     "test/cutting_board_test.rb",
     "test/feed_parser_test.rb",
     "test/flannel_test.rb",
     "test/square_test.rb",
     "test/shears_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
      s.add_development_dependency(%q<technicalpickles-shouldamocha>, [">= 0"])
    else
      s.add_dependency(%q<hpricot>, [">= 0"])
      s.add_dependency(%q<technicalpickles-shouldamocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0"])
    s.add_dependency(%q<technicalpickles-shouldamocha>, [">= 0"])
  end
end

