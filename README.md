# DemoApp

This project is the API part of DemoApp.

## Description

DemoApp is a collaborative tool.

## Installing and getting the project running

This project is meant to run in a docker container.

### System Dependencies

- Docker

### Setup project

Make sure you have Docker or Rancher installed and it is running.

### Build the project

You will only need to run this once to build the project.

```
~> docker-compose build
```

### Run the project

Once you have the project build you will only ever need to run the following command.

```
~> docker-compose up
```

## Database Setup

Once you have the project up in running you will need to initialize the database.

It will be easier if you have two other terminals open for the rest of the commands. One for the _demoapp-api_ container, and one for the _demoapp-postgres_ container.

Use the commands:

```
docker exec -it demoapp-api bash
docker exec -it demoapp-postgres bash
```

If the database currently exists, then remove the existing databases in the _demoapp-postgres_ container.

```
psql -U demoapp -c "DROP DATABASE demoapp_development;"
psql -U demoapp -c "DROP DATABASE demoapp_test;"
```

### Using the basic setup

```
~> rails db:create
~> rails db:migrate
~> rails db:migrate RAILS_ENV=test
```

### Using the database with seed data

Once in the _demoapp-api_ run the following commands:

```
~> rails db:create
~> rails db:schema:load
~> rails db:schema:load RAILS_ENV=test
~> rails db:migrate
~> rails db:migrate RAILS_ENV=test
~> rails db:seed
```

### Using the database with a database backup

Once in the _demoapp-api_ run the following commands:

```
~> rails db:create
~> rails db:schema:load RAILS_ENV=test
```

Copy databaes backup file to the _demoapp-postgres_ container from outside the container.

```
~> docker cp ~/demoapp_database.dump demoapp-postgres:./demoapp_database.dump
```

Then run the pg*restore command from within the \_demoapp-postgres* container.

```
pg_restore --no-owner -U demoapp -d demoapp_development ./demoapp_database.dump
```

Then run the rails db:migrate command

```
~> rails db:migrate
-> rails db:migrate RAILS_ENV=test
```

### Stopping the project

If you want to stop the project run the following command.

```
~> docker-compose down
```

### Running background workers

To run background workers you will need to run the following command in a demoapp-api container.

```
~> QUEUE=* rake resque:work
```

## Formatting Guidelines

- Use Rails 7 standards - RuboCop will enforce standards
- Rails Best Practices will enforce code quality
- Use the gem active_model_serializers for JSON responses

## Get emails to your development environment

In your environment file set DEMOAPP_DEV_EMAIL to the email address you want to receive emails.

## Testing

- Code must be tested using RSpec.
- Code will be checked with RuboCop.
- Code will be checked with Rails Best Practices

To run the RSpec tests you will run them from the _demoapp-api_ container.

Login to the _demoapp-api_ container:

```
~> docker exec -it demoapp-api bash
```

Once in the container run the following commands:

```
~> rake spec
```

## Contributing

EVERY BRANCH SHOULD PASS CIRCLECI BEFORE BEING MERGED

- Master should always be deployable and stable
- For each feature, task, or bug:
- Branch from Master
- Name your branch username/feature-name
- Commits:
  - At minimum a commit should be done at the end of every working day even if not finished.
  - Commits should contain a comment that explains what was done.
  - Each ticket should have a corresponding branch that is prefixed with the authors name and has the story name.
  - Examples:
    - If Wes worked on feature, "User Login", I would have a branch "weshays/feature-user-login,
    - If Blake worked on bug, "User Login Bug", it would be "blake/bug-user-login".
- When a feature or bug is ready to merge you will make sure your branch is up to date with master, and then issue a pull request on Github.
- Make sure all your code is commited for your branch.
- Before you do a pull request make sure your branch is updated with the latest on master/main.
- Create a pull request for your branch
- You should not merge your own pull requests into master unless it's an emergency.
- Another team member should review the pull request and do the merge if everything looks good.

---

# Docker commands

## Remove all images and caches

Run the following commands

```
~> docker rm $(docker ps -aq)
~> docker image rm $(docker images -aq)
~> docker volume prune -f
~> docker system prune -f
~> docker system df
```

## Accessing a container

```
docker exec -it [CONTAINER ID/NAME] bash
```

example:

```
~> docker exec -it demoapp-api bash
```

# Docker connect to database

```
docker exec -it [CONTAINER ID/NAME] psql -U [POSTGRES_USER] [DATABASE_NAME]
```

# Docker does not install all the gems

If docker does not install all the gems, then you can run to rebuild the Gemfile.lock.

```
~> docker-compose run app bundle install
~> docker-compose run worker bundle install
```

# Copy from credentials file

In the vi editor run
set mouse=r

This can also be added in .vimrc

# Access Rails credentials file

docker-compose run --rm -e EDITOR=vi app rails credentials:edit -e development
docker-compose run --rm -e EDITOR=vi app rails credentials:edit -e staging
docker-compose run --rm -e EDITOR=vi app rails credentials:edit -e production
docker-compose run --rm -e EDITOR=vi app rails credentials:edit -e test

You will not be able to copy/paste from VI by default. You will need to follow the instructions above to enable mouse support.
