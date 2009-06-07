Feature: Paragraphs
  In order to create wiki links
  A user of Flannel
  Will use wiki links

  Scenario: Creating wiki links
    Given input of "wiki_links" text
    When I quilt it with flannel
    Then valid html should be produced

  Scenario: Creating wiki links with a custom url
    Given input of "wiki_links" text
    And a formatter of 'http://www.example.com/foo/#{keyword}'
    When I quilt it with flannel
    Then valid html should be produced
