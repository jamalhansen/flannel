Feature: Feed conversion
  In order to insert "live" links from rss feeds
  A user of Flannel
  Will quilt feed text markup

  Scenario: Inserting links from an rss feed
    Given input of "feed" text
    And the necessary feeds
    When I quilt it with flannel
    Then valid html should be produced