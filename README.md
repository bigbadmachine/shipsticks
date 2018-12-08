# ShipSticks.com Code Test

Back-End
———————-
Directions: Build a minimal API, using Rails and MongoDB, for our products

Front-End
————————-
Build a calculator, using HTML, CSS, and JavaScript, that takes dimensional inputs and weight from the user and returns the product that matches our products in the DB. Use the above API to fill the results.


## Installation

Follow these easy steps to install and start the app:

### Prerequisites
  
    Ruby v2.5.1
    MongoDB


### Set up Rails app

First, install the gems required by the application:

    bundle

Next, execute the database migrations/schema setup:

    bundle exec rake db:create

Next, seed the database with initial products:

    bundle exec rake db:import


### Start the app

Start MongoDB

    update config/mongoid.yml if necessary to match your local configuration.

Start the Rails app:

    bundle exec rails server

App should be running at [http://localhost:3000](http://localhost:3000). 


## API

### Calculate
Returns the best sized product based on dimensional inputs

GET /products/calculate

* Required Params
  * product[width]=[integer] *in inches*
  * product[length]=[integer] *in inches*
  * product[height]=[integer] *in inches*
  * product[weight]=[integer] *in lbs*

* Optional Params
  * product[type]=[string] *must be [Golf, Luggage or Ski]*

* Success Response
  * Code: 200 OK
  * Content: { name: "Small Package", type: "Golf", id: { $oid: "5c09515a10a9ae6537903add"},...}

* Error Response
  * Code: 422 UNPROCESSABLE ENTRY 
  * Content: { params: ["Missing/Invalid params..."] }


### Read
Returns all products

GET /products

* Success Response
  * Code: 200 OK
  * Content: [{ name: "Small Package", type: "Golf", id: { $oid: "5c09515a10a9ae6537903add"},...}]


### Create
Creates a product

POST /products

* Required Params
  * product[name]=[string]
  * product[width]=[integer] *in inches*
  * product[length]=[integer] *in inches*
  * product[height]=[integer] *in inches*
  * product[weight]=[integer] *in lbs*
  * product[type]=[string] *must be [Golf, Luggage or Ski]*

* Success Response
  * Code: 201 CREATED
  * Content: { name: "Small Package", type: "Golf", id: { $oid: "5c09515a10a9ae6537903add"},...}

* Error Response
  * Code: 422 UNPROCESSABLE ENTRY 
  * Content: { name: ["can't be blank"],... }


### Update
Updates a product

PUT /products/:id

* Optional Params
  * product[name]=[string]
  * product[width]=[integer] *in inches*
  * product[length]=[integer] *in inches*
  * product[height]=[integer] *in inches*
  * product[weight]=[integer] *in lbs*
  * product[type]=[string] *must be [Golf, Luggage or Ski]*

* Success Response
  * Code: 200 OK
  * Content: { name: "Small Package", type: "Golf", id: { $oid: "5c09515a10a9ae6537903add"},...}

* Error Response
  * Code: 422 UNPROCESSABLE ENTRY 
  * Content: { name: ["can't be blank"],... }


### Destroy
Deletes a product

DELETE /products/:id

* Success Response
  * Code: 204 NO CONTENT

* Error Response
  * Code: 404 NOT FOUND


## Running Tests

    bundle exec rspec

