## Word complexity API
This project is a REST API for calculating word complexity using the Free Dictionary API.

## Instruction
Do a POST request with a body in the format ["happy", "joyful", "sad", "angry"] and get a response job_id: ID. Use this ID to get the calculation result when it is completed. Add the ID into the request http://localhost:3000/api/v1/complexity-score/ID (<<-- right here) to see the status and result of words.

## Status Explanation
- Pending – task created
- In Progress – calculation started
- Done – calculation completed, result successfully saved
- Failed – calculation failed, errors saved

## Result
The API has been tested successfully. All RSpec tests pass ✅.  
Below are examples of requests and responses captured in Postman:

## Requests and response from POSTMAN:
| POST | GET | Description |
|----------|----------|----------|
| ![Postman example](./docs/images/POST_200.png)        | ![Postman example](./docs/images/GET_200.png)     | Valid example data in request body |
| ![Postman example](./docs/images/POST_200_any.png)    | ![Postman example](./docs/images/GET_200_any.png) | Array of any elements in request body |
| ![Postman example](./docs/images/POST_empty_arr.png)  | -                                                 | Empty array in request body |
| ![Postman example](./docs/images/POST_empty_body.png) | -                                                 | Empty request body |
| -                                                     | ![Postman example](./docs/images/GET_fail_id.png) | Nonexistent or invalid job ID |

## Documetation API
http://localhost:3000/api-docs

## Stek
- Ruby 3.4.4
- Ruby on Rails 8.0.3
- PostgreSQL
- RSpec + FactoryBot
- Swagger (Rswag)

#### Author
Timur Kim [Telegram](https://t.me/@Thunder_Tim) | [GitHub](https://github.com/TimDelRey)
