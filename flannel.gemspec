# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{flannel}
  s.version = "0.2.14"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamal Hansen"]
  s.date = %q{2010-03-01}
  s.default_executable = %q{quilt-it}
  s.description = %q{Flannel is a markup language that is not intended for your web app.  It's for your local use, to write a blog entry in your text editor or a number of other uses.}
  s.email = %q{jamal.hansen@gmail.com}
  s.executables = ["quilt-it"]
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
     "examples/brainstorming.flannel",
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
     "graphics/flannel.xcf",
     "graphics/flannel_small.jpg",
     "lib/flannel.rb",
     "lib/flannel/base_block.rb",
     "lib/flannel/block.treetop",
     "lib/flannel/block_cutter.rb",
     "lib/flannel/cache_location_does_not_exist_error.rb",
     "lib/flannel/feed_parser.rb",
     "lib/flannel/file_cache.rb",
     "lib/flannel/html_formatter.rb",
     "lib/flannel/html_transformable.rb",
     "lib/flannel/wrappable.rb",
     "test/base_block_html_generation_test.rb",
     "test/base_block_test.rb",
     "test/block_cutter_test.rb",
     "test/block_parser_styles_test.rb",
     "test/block_parser_test.rb",
     "test/feed_parser_test.rb",
     "test/file_cache_test.rb",
     "test/flannel_test.rb",
     "test/html_formatter_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/rubyyot/flannel}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{flannel}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A soft comfortable worn in markup language for Ruby}
  s.test_files = [
    "test/html_formatter_test.rb",
     "test/block_cutter_test.rb",
     "test/test_helper.rb",
     "test/file_cache_test.rb",
     "test/base_block_test.rb",
     "test/block_parser_styles_test.rb",
     "test/block_parser_test.rb",
     "test/feed_parser_test.rb",
     "test/flannel_test.rb",
     "test/base_block_html_generation_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<treetop>, [">= 0"])
      s.add_runtime_dependency(%q<polyglot>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<treetop>, [">= 0"])
      s.add_dependency(%q<polyglot>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<treetop>, [">= 0"])
    s.add_dependency(%q<polyglot>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end

