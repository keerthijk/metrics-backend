# README

This application is a Ruby on Rails backend for creating and visualizing metrics. Each metric has a name and it has many records with value and timestamps, and can be used to find average value of each metric per minute, hour, and day.

## Features
Create metrics: Add new metrics with a name.
Record metric values: Add values to each metric with a timestamp.
Calculate averages: Retrieve average values of metrics per minute, hour, and day.
RESTful API: Access and manage metrics via a RESTful API.
PostgreSQL: Uses PostgreSQL for data storage.

## Versions
Ruby '3.2.2'
Rails '7.0.8'
PostgreSQL

## Installing

```
git clone 
cd 
```

## Install gems
```
bundle install
```

## Setup the database
```
rails db:create
rails db:migrate
```

## Run the tests
```
rspec
```

## Start the server
```
rails s -p 4000
```

## API Endpoints
* Metrics
    - GET /metrics: Retrieve all metrics
    - POST /metrics: Create a new metric
        - Parameters: name (string, required)

* Metric Records

    - POST /metrics/id/metric_records: Create a new metric record for a specific metric
        - Parameters: value (decimal, required), timestamp (datetime, required)

* Averages
  
    - GET /metrics/id/averages: Retrieve average values for a specific metric
        - Response format: json
        {
          "minute": [...],
          "hour": [...],
          "day": [...]
## Todos
* To keep the challenge minimal I have not added Edit and Delete options for Metrics and MetricRecords.

