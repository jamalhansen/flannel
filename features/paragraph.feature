Feature: List generation
  In order to create lists
  A user of Flannel
  Will quilt list markup

  Scenario: Creating a list
    Given input of "list" text
    When I quilt it with flannel
    Then valid html should be produced