# Artists And Albums

A simple Rails application where you can search, view, and edit data.
Data is retrieved from an API before the application starts with the import service. After making sure that the necessary configs are loaded and the server is defined. 

[LIVE PROJECT (PRODUCTION)](https://artistsandalbums-production.up.railway.app/).

<img src="https://i.hizliresim.com/dtnchmk.png" alt="" width="180"/>
<img src="https://i.hizliresim.com/pjevzvo.png" alt="" width="180"/>
<img src="https://i.hizliresim.com/4se5u4j.png" alt="" width="180"/>
<img src="https://i.hizliresim.com/3zsarjc.png" alt="" width="180"/>

## Table of Contents

- [Installation](#installation)

## Installation

### Prerequisites

- Ruby (ruby-3.2.2)
- Rails (version 7.1.3 >= 7.1.3.3)
- Postgresql
- required ENV's:
```IMPORT_EXTERNAL_USERS_INFO_BASE_URL``` ```IMPORT_EXTERNAL_USERS_PHOTO_BASE_URL```

### Steps

1. Clone the repository
######

2. Install dependencies:
  ```sh 
   bundle install
  ```

3. Setup the database:
  ```sh 
  rails db:create && rails db:migrate
  ```

4. Export the env's:
  ```sh 
  export IMPORT_EXTERNAL_USERS_INFO_BASE_URL=https://jsonplaceholder.typicode.com
  export IMPORT_EXTERNAL_USERS_PHOTO_BASE_URL=https://picsum.photos
  ```

5. Precompile Assets:
  ```sh 
  rails assets:precompile
  ```

6. Run the Rails server:
  ```sh 
  bin/dev
  ```

