Feature: External link conversion
  In order to create external links
  A user of Flannel
  Will quilt external link markup

  Scenario: Preformatting text
    Given input of "external_link" text
    When I quilt it with flannel
    Then valid html should be produced