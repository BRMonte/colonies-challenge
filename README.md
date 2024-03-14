# Colonies tech challenge

##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby 3.0.0
- Rails 7.1.3
- PostgreSQL

### I. Instructions

#### 1. Clone the Repository
Open your terminal and run the following command to clone the repository:

```bash
git clone git@github.com:BRMonte/colonies-challenge.git
```

#### 2. Navigate to Project Directory
Change into the project directory:

```bash
cd app
```

#### 3. Install Dependencies

Run the following command.

```ruby
bundle install
```

#### 4. Set up Database

You can create and set up the DB with the below command.

```ruby
rails db:create
rails db:migrate
rails db:seed

```

#### 5. Run test files

In the terminal run tests with the below command.

```ruby
bundle exec rspec ./spec

```

#### II. Make requests

#### 1. Start the Rails Server

You can start the rails server with the below command.

```ruby
rails s

```

#### 2. Endpoints

You can list absences and create absences with the below endpoints.

```ruby
GET /api/v1/absences: Retrieve a list of absences
POST /api/v1/absences: Create an absence

```

#### 3. Make requests
Split your terminal and with the server running make requests with the below commands.
Install curl command if needed.

```ruby
// GET /api/v1/absences: Retrieve a list of absences
curl http://localhost:3000/api/v1/absences
```

```ruby
// POST /api/v1/absences: Create an absences
curl -X POST \
  http://localhost:3000/api/v1/absences \
  -H 'Content-Type: application/json' \
  -d '{
    "studio_id": 1,
    "start_date": "2024-01-01",
    "end_date": "2024-01-08"
  }'

```

##### Gems used

- rspec-rails: Testing framework
- factory_bot_rails: Test data generation

