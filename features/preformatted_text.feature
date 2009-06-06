Feature: Preformatted text conversion
  In order to create preformatted text
  A user of Flannel
  Will quilt preformatted text markup

  Scenario: Preformatting text
    Given input of "preformatted" text
    When I quilt it with flannel
    Then valid html should be produced