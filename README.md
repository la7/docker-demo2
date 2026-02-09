# docker-demo2

## Project description
This is a REST API project to add players and view Montreal Canadians' Hokey Team.

PS : The project can be upgraded for demonstration purpose.

## Models

Team

```
{
    "id": long,
    "coach": string
    "teamYear" : long
    "players": [
        {
            "number": long,
            "name": string,
            "lastname": string,
            "position":"defenseman",
            "isCaptain" : boolean
        }
    ]
}

```

## Endpoints

### GET /api/team/{year}

-   Request: Year in the URI
-   Response: Team Object
-   Status: 200 OK


    http://localhost:8080/api/team/2022
    {
       "id":2,
       "coach":"Dominique Ducharme",
       "teamYear":"2022",
       "players":[
          {
             "number":31,
             "name":"Carey",
             "lastname":"Price",
             "position":"goaltender"
          },
          {
             "number":14,
             "name":"Nick",
             "lastname":"Suzuki",
             "position":"forward"
          },
          {
             "number":15,
             "name":"Jesperi",
             "lastname":"Kotkaniemi",
             "position":"forward"
          },
          {
             "number":71,
             "name":"Jake",
             "lastname":"Evans",
             "position":"forward"
          },
          {
             "number":27,
             "name":"Alexander",
             "lastname":"Romanov",
             "position":"defenseman"
          },
          {
             "number":6,
             "name":"Shea",
             "lastname":"Weber",
             "position":"defenseman",
             "isCaptain" : true
          }
       ]
    }

    http://localhost:8080/api/team/2022
    {
       "id":1,
       "coach":"Dominique Ducharme",
       "teamYear":"2022",
       "players":[
          {
             "number":31,
             "name":"Carey",
             "lastname":"Price",
             "position":"goaltender"
          },
          {
             "number":14,
             "name":"Nick",
             "lastname":"Suzuki",
             "position":"forward"
          },
          {
             "number":15,
             "name":"Jesperi",
             "lastname":"Kotkaniemi",
             "position":"forward"
          },
          {
             "number":71,
             "name":"Jake",
             "lastname":"Evans",
             "position":"forward"
          },
          {
             "number":27,
             "name":"Alexander",
             "lastname":"Romanov",
             "position":"defenseman"
          },
          {
             "number":6,
             "name":"Shea",
             "lastname":"Weber",
             "position":"defenseman",
             "isCaptain" : true
          }
       ]
    }

### POST /api/team/{Year}

-   Request: Player Object in the body
-   Response: Created Player Object
-   Status: 201 CREATED


```
http://localhost:8080/api/player  --header "Content-Type:application/json"

{
  "number":99,
  "name":"Marion",
  "lastname":"Félix",
  "position":"forward",
  "isCaptain" : false
}

```

### PUT /api/player/captain/{ID}

-   Request: ID of Player in the URI
-   Response: Object Player
-   Status: 200 OK

