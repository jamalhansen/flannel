Feature: Paragraphs
  In order to create lists
  A user of Flannel
  Will quilt list markup

  Scenario: Wrapping text in paragraphs
    Given input of "paragraph" text
    When I quilt it with flannel
    Then valid html should be produced