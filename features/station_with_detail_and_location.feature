Feature: Choose a station to start or end my itinerary according to its details and location.
  In order to select a station
  As a client software API
  I need to be able to retrieve a list of station filterable by GeoLocation with their details and location.

  @database
  Scenario: Can Retrieve station list with their details and location.
    Given a list of station:
      | stationId                            | name               | type          | address           | addressNumber | zipCode | latitude  | longitude |
      | 15cff96c-de06-4606-9870-b82eb9219339 | 08 - PG. PUJADES 2 | BIKE          | Pg Lluis Companys | 2             | 08018   | 41.389088 | 2.183568  |
      | 374c5b80-cb51-46d8-8f7d-48bce9044f23 | 492 - PL. TETUAN   | ELECTRIC_BIKE | PL. DE TETUAN     | 8-9           | 08010   | 41.394232 | 2.175278  |
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/api/stations"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
      {
        "@context": "/api/contexts/station",
        "@id": "/api/stations",
        "@type": "hydra:Collection",
        "hydra:member": [
          {
            "@id": "/api/stations/15cff96c-de06-4606-9870-b82eb9219339",
            "@type": "station",
            "id": "15cff96c-de06-4606-9870-b82eb9219339",
            "name": "08 - PG. PUJADES 2",
            "type": "BIKE",
            "address": "Pg Lluis Companys",
            "addressNumber": "2",
            "zipCode": "08018",
            "latitude": 41.389088,
            "longitude": 2.183568
          },
          {
            "@id": "/api/stations/374c5b80-cb51-46d8-8f7d-48bce9044f23",
            "@type": "station",
            "id": "374c5b80-cb51-46d8-8f7d-48bce9044f23",
            "name": "492 - PL. TETUAN",
            "type": "ELECTRIC_BIKE",
            "address": "PL. DE TETUAN",
            "addressNumber": "8-9",
            "zipCode": "08010",
            "latitude": 41.394232,
            "longitude": 2.175278
          }
        ]
      }
    """

  @database
  Scenario: Can Retrieve station list with their details and location filtered by Geo location queries.
    Given a list of station:
      | stationId                            | name                      | type          | address                | addressNumber | zipCode | latitude  | longitude |
      | 15cff96c-de06-4606-9870-b82eb9219339 | 50 - AV. PARAL.LEL, 54    | BIKE          | 50 - AV. PARAL.LEL, 54 | 2             | 08001   | 41.375    | 2.17035   |
      | 374c5b80-cb51-46d8-8f7d-48bce9044f23 | 114 - PL. JEAN GENET, 1   | ELECTRIC_BIKE | Av. Paral.lel          | 8-9           | 08001   | 41.376801 | 2.173039  |
      | 02ec1e88-4c3d-4b3d-af0a-0d11eb4ce1ab | 352 - C/RADI, 10/GRAN VIA | BIKE          | Radi                   | 8-9           | 08098   | 41.36335  | 2.134144  |
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/api/stations?geo_location_filter=41.373,2.17031,800.00"
    Then the response status code should be 200
    And the JSON should be equal to:
    """
    {
      "@context": "/api/contexts/station",
      "@id": "/api/stations",
      "@type": "hydra:Collection",
      "hydra:member": [
        {
          "@id": "/api/stations/15cff96c-de06-4606-9870-b82eb9219339",
          "@type": "station",
          "id": "15cff96c-de06-4606-9870-b82eb9219339",
          "name": "50 - AV. PARAL.LEL, 54",
          "type": "BIKE",
          "address": "50 - AV. PARAL.LEL, 54",
          "addressNumber": "2",
          "zipCode": "08001",
          "latitude": 41.375,
          "longitude": 2.17035
        },
        {
          "@id": "/api/stations/374c5b80-cb51-46d8-8f7d-48bce9044f23",
          "@type": "station",
          "id": "374c5b80-cb51-46d8-8f7d-48bce9044f23",
          "name": "114 - PL. JEAN GENET, 1",
          "type": "ELECTRIC_BIKE",
          "address": "Av. Paral.lel",
          "addressNumber": "8-9",
          "zipCode": "08001",
          "latitude": 41.376801,
          "longitude": 2.173039
        }
      ],
      "hydra:view": {
          "@id": "/api/stations?geo_location_filter=41.373%2C2.17031%2C800.00",
          "@type": "hydra:PartialCollectionView"
      }
    }
    """

  @database
  Scenario: Can't Retrieve station list with their details and location with bad query parameters
    Given a list of station:
      | stationId                            | name                      | type          | address                | addressNumber | zipCode | latitude  | longitude |
      | 15cff96c-de06-4606-9870-b82eb9219339 | 50 - AV. PARAL.LEL, 54    | BIKE          | 50 - AV. PARAL.LEL, 54 | 2             | 08001   | 41.375    | 2.17035   |
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/api/stations?geo_location_filter=bad_query_type,2.17031,800.00"
    Then the response status code should be 400
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"


  @database
  Scenario: Can Retrieve a station with its detail and location.
    Given a list of station:
      | stationId                            | name               | type | address           | addressNumber | zipCode | latitude  | longitude |
      | feb78515-1b8b-42fa-b8f4-da8f80b44733 | 08 - PG. PUJADES 2 | BIKE | Pg Lluis Companys | 2             | 08018   | 41.389088 | 2.183568  |
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/api/stations/feb78515-1b8b-42fa-b8f4-da8f80b44733"
    Then the response status code should be 200
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
    And the JSON should be equal to:
    """
      {
        "@context": "/api/contexts/station",
        "@id": "/api/stations/feb78515-1b8b-42fa-b8f4-da8f80b44733",
        "@type": "station",
        "id": "feb78515-1b8b-42fa-b8f4-da8f80b44733",
        "name": "08 - PG. PUJADES 2",
        "type": "BIKE",
        "address": "Pg Lluis Companys",
        "addressNumber": "2",
        "zipCode": "08018",
        "latitude": 41.389088,
        "longitude": 2.183568
      }
    """

  @database
  Scenario: Can Not Retrieve a station with its detail and location that does not exists.
    Given a list of station:
      | stationId                            | name               | type | address           | addressNumber | zipCode | latitude  | longitude |
      | feb78515-1b8b-42fa-b8f4-da8f80b44733 | 08 - PG. PUJADES 2 | BIKE | Pg Lluis Companys | 2             | 08018   | 41.389088 | 2.183568  |
    When I add "Accept" header equal to "application/ld+json"
    And I send a "GET" request to "/api/stations/15cff96c-de06-4606-9870-b82eb9219339"
    Then the response status code should be 404
    And the response should be in JSON
    And the header "Content-Type" should be equal to "application/ld+json; charset=utf-8"
