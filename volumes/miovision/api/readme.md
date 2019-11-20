# API Puller

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Input Parameters](#input-parameters)
  - [API Key and URL](#api-key-and-url)
- [Relevant Calls and Outputs](#relevant-calls-and-outputs)
  - [Turning Movement Count (TMC)](#turning-movement-count-tmc)
  - [Turning Movement Count (TMC) Crosswalks](#turning-movement-count-tmc-crosswalks)
  - [Error responses](#error-responses)
- [Input Files](#input-files)
- [How to run the api](#how-to-run-the-api)
  - [Virtual Environment](#virtual-environment)
  - [Command Line Options](#command-line-options)
- [Classifications](#classifications)
  - [Exisiting Classification (csv dumps and datalink)](#exisiting-classification-csv-dumps-and-datalink)
  - [API Classifications](#api-classifications)
- [PostgreSQL Functions](#postgresql-functions)
- [Invalid Movements](#invalid-movements)
- [How the API works](#how-the-api-works)

## Overview

The puller can currently grab crosswalk and TMC data from the Miovision API using specified intersections and dates, upload the results to the database and aggregates data to 15 minute bins. The puller can support date ranges longer than 24 hours. The output is the same format as existing csv dumps sent by miovision. This script creates a continuous stream of volume data from Miovision.

## Input Parameters

### API Key and URL

Emailed from Miovision. Keep it secret. Keep it safe.

The API can be accessed at [https://api.miovision.com/intersections/](https://api.miovision.com/intersections/). The general structure is the `base url+intersection id+tmc or crosswalk endpoint`. Additional documentation can be found in here: [http://beta.docs.api.miovision.com/](http://beta.docs.api.miovision.com/)

## Relevant Calls and Outputs

Each of these returns a 1-minute aggregate, maximum 48-hrs of data, with a two-hour lag (the end time for the query cannot be more recent than two-hours before the query). If the volume is 0, the 1 minute bin will not be populated. 

### Turning Movement Count (TMC)

Every movement through the intersection except for pedestrians.

Response:

```json
[
  {
    "class": {'type': "string", 'desc': "Class of vehicle/bike"},
    "entrance": {'type':"string", 'desc': "Entrance leg, e.g. 'N'"},
    "exit": {'type':"string",'desc': "Exit leg, e.g. 'W'"},
    "qty": {'type':"int", 'desc': "Count of this movement/class combination"}
  }
]
```

### Turning Movement Count (TMC) Crosswalks

Crosswalk Counts

```json
[
  {
    "class": {'type': "string", 'desc':"They're all pedestrian"},
    "crosswalkSide": {'type':"string", 'desc': "Intersection leg the crosswalk is on"},
    "direction": {'type':"string",'desc': "ClockWise (CW) or CounterCW (CCW)"},
    "qty": {'type':"int", 'desc': "Count"}
  }
]
```

Through the API, the script converts it to a table like this:

**intersection\_uid**|**datetime\_bin**|**classification\_uid**|**leg**|**movement\_uid**|**volume**|
:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
1|2018-07-03 23:01:00|1|N|1|5
1|2018-07-03 23:03:00|1|N|1|9
1|2018-07-03 23:06:00|1|N|1|7
1|2018-07-03 23:13:00|1|N|1|7
1|2018-07-03 23:28:00|1|N|1|8
1|2018-07-03 23:14:00|1|N|1|5
1|2018-07-03 23:07:00|1|N|1|8
1|2018-07-03 23:15:00|1|N|1|5
1|2018-07-03 23:16:00|1|N|1|3
1|2018-07-03 23:08:00|1|N|1|8

which is the same format as the `miovision.volumes` table, and directly inserts it to `miovision_api.volumes`. The script converts the movements, classifications and intersections given by the API to uids using the same lookup table structure that exists in the `miovision` schema.

### Error responses

These errors are a result of invalid inputs to the API, or the API having an internal error of some kind. 

```json
[
    {400: "The provided dates were either too far apart (the limit is 48 hours) or too recent (queries are only permitted for data that is at least 2 hours old)."},
    {404: "No intersection was found with the provided IDs."}
]
```

There is also a currently unkown `504` error. The script has measures to handle this error, but if the data cannot be pulled, retrying will successfully pull the data. The script has the capapbility to individually pull specific intersections.

There are other errors relating to inserting/processing the data on PostgreSQL and requesting the data. Instead of an error code, details about these kinds of errors are usually found in the logs and in the traceback. 

All errors the API encounters are logged in the `logging.log` file, and emailed to the user. The log also logs the time each intersection is pulled, and the time when each task in PostgreSQL is completed. This makes it useful to check if any single processes is causing delays. 

## Input Files

`config.cfg` is required to access the API, the database, and perform email notification. It has the following format:

```ini
[API]
key=your api key
[DBSETTINGS]
host=10.160.12.47
dbname=bigdata
user=database username
password=database password
[EMAIL]
from=from@email.com
to=to@email.com
```

## How to run the api

In command prompt, navigate to the folder where the python file is located and run `python intersection_tmc.py run_api`. This will collect data from the previous day as the default date range.

The script can also customize the data it pulls and processes with various command line options.

For example, to collect data from a custom date range, run `python intersection_tmc.py run_api --start=YYYY-MM-DD --end=YYYY-MM-DD`. The start and end variables will indicate the start and end date to pull data from the api.

`start` and `end` must be separated by at least 1 day, and `end` cannot be a future date. Specifying `end` as today will mean the script will pull data until the start of today (Midnight, 00:00). 

If the API runs into an error, an email will be sent notifying the general error category along with the traceback. The logging file also logs the error. For some minor errors that can be fixed by repulling the data, the API will email which intersection-date combination could not be pulled. 

### Virtual Environment

If the script is running on the EC2, then a virtual environment is required to run the script. In addition, it is no longer necessary to specify the proxy since the script is being run outside the firewall. 

First, install pipenv by running `pip install --user pipenv`. The script is written around python 3.x, so run `pipenv --three` to setup a python 3.x virtual environment. To install the required packages such as the click module, run `pipenv intstall click`. 

To run the python script, or any python commands, replace `python` at the start of your command with `pipenv run python`. For example, to run this script, run `pipenv run python intersection_tmc.py run_api`.

More information can be found [here](https://python-docs.readthedocs.io/en/latest/dev/virtualenvs.html).

### Command Line Options

|Option|Format|Description|Example|Default|
|-----|-------|-----|-----|-----|
|start_date|YYYY-MM-DD|Specifies the start date to pull data from|2018-08-01|The previous day|
|end_date|YYYY-MM-DD|Specifies the end date to pull data from|2018-08-05|Today|
|intersection|integer|Specifies the `intersection_uid` from the `miovision.intersections` table to pull data for|12|Pulls data for all intersection|
|path|path|Specifies the directory where the `config.cfg` file is|`C:\Users\rliu4\Documents\GitHub\bdit_data-sources\volumes\miovision\api`|`config.cfg` is located in the same directory as the `intersection_tmc.py` file.|
|pull|string|Specifies if the script should only pull data and not process the data|Yes|Processes data in PostgreSQL

`python intersection_tmc.py --start=2018-08-01 --end=2018-08-05 --intersection=12 --path=C:\Users\rliu4\Documents\GitHub\bdit_data-sources\volumes\miovision\api --pull=Yes` is an example with all the options specified.

## Classifications

The classification given in the api is different than the ones given in the csv dumps, or the datalink. 

### Exisiting Classification (csv dumps and datalink)

|classification_uid|classification|location_only|class_type|
|-----|-----|-----|-----|
1|Lights|f|Vehicles
2|Bicycles|f|Cyclists
3|Buses|f||
4|Single-Unit Trucks|f|Vehicles
5|Articulated Trucks|f|Vehicles
6|Pedestrians|t|Pedestrians
7|Bicycles|t|Cyclists

### API Classifications

|classification_uid|classification|location_only|class_type|
|-----|-----|-----|-----|
1|Light|f|Vehicles
2|Bicycle|f|Cyclists
3|Bus|f||
4|SingleUnitTruck|f|Vehicles
5|ArticulatedTruck|f|Vehicles"
6|Pedestrian|t|Pedestrians"
8|WorkVan|f|Vehicles"

The API assigns a classification of 0 if the classification matches none of the above. This is possible if the classification given from the API does not exactly match any of the ones in the script. One example is if `Light` is pluralized as `Lights`, like in the CSV dumps.

## PostgreSQL Functions

To perform the data processing, the API script calls several postgres functions in the `miovision_api` schema. These functions are the same/very similar to the ones used to process the csv dumps. More information can be found in the [miovision readme](https://github.com/CityofToronto/bdit_data-sources/blob/master/volumes/miovision/README.md)

|Function|Purpose|
|-----|-----|
|[`aggregate_15_min_tmc`](https://github.com/CityofToronto/bdit_data-sources/blob/miovision_api/volumes/miovision/sql/function-aggregate-volumes_15min_tmc.sql)|Aggregates data with valid movementsto 15 minutes turning movement count (TMC) bins and fills in gaps with 0-volume bins. |
|[`aggregate_15_min`](https://github.com/CityofToronto/bdit_data-sources/blob/miovision_api/volumes/miovision/sql/function-aggregate-volumes_15min.sql)|Turns 15 minute TMC bins to 15 minute automatic traffic recorder (ATR) bins|
[`find_invalid_movments`](https://github.com/CityofToronto/bdit_data-sources/blob/miovision_api/volumes/miovision/sql/function-find_invalid_movments.sql)|Finds the number of invalid movements|
[`api_log`](https://github.com/CityofToronto/bdit_data-sources/blob/miovision_api/volumes/miovision/sql/function-api_log.sql)|Populates when the data is pulled
[`report_dates`](https://github.com/CityofToronto/bdit_data-sources/blob/miovision_api/volumes/miovision/sql/function-report_dates.sql)|Populates `report_dates`.

## Invalid Movements

The API also checks for invalid movements by calling the [`miovision_api.find_invalid_movements`](https://github.com/CityofToronto/bdit_data-sources/blob/automate_miovision_aggregation/volumes/miovision/sql/function-find_invalid_movements.sql) PostgreSQL function. This function will evaluate whether the number of invalid movements is above or below 1000 in a single day, and warn the user if it is. The function does not stop the API script with an exception so manual QC would be required if the count is above 1000. A warning is also emailed to the user if the number of invalid movements is over 1000.

## How the API works

This flow chart provides a high level overview of the script:

![Flow Chart of the API](img/api_script1.png)