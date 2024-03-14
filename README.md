##### Prerequisites

The setups steps expect following tools installed on the system.

- Ruby 3.0.0
- Rails 7.1.3
- PostgreSQL

##### 1. Clone the Repository
Open your terminal and run the following command to clone the repository:

```bash
git clone git@github.com:BRMonte/colonies-challenge.git
```

##### 2. Navigate to Project Directory
Change into the project directory:

```bash
cd app
```

##### 3. Install Dependencies

Run the following command.

```ruby
bundle install
```

##### 4. Create, Migrate, and Seed the Database

You can start the rails server using the command given below.

```ruby
rails db:create
rails db:migrate
rails db:seed

```

##### 5. Run test files

You can start the rails server using the command given below.

```ruby
bundle exec rspec ./spec/models
bundle exec rspec ./spec/routes
bundle exec rspec ./spec/requests

```

##### . Start the Rails Server

You can start the rails server using the command given below.

```ruby
rails s

```

##### Gems used

- rspec-rails: Testing framework
- factory_bot_rails: Test data generation

