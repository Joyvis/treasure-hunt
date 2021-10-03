# Treasure Hunt Challenge

This is a simple project to calculate distance (in meters) between a hunter and the treasure.

## How to run?

### Development

First of all run in your terminal the following command to create a new `.env` file containing all the necessary variables to run the project.

```
cp .env.development .env
```

it will create a new a `.env` file and then you will be set a value for all empty variables.

Once you set the treasure coordinates and email configs you will be able to start the project, so, the first thing is create and migrate a database using the following commands:

```
bundle exec rails db:create

bundle exec rails db:migrate
```

**NOTE: When you run this project in development mode the email messages are not sent!**

### Production

First of all you need to export all the variables that the project needs. Copy and paste the following commands in your terminal and
**Do not forgot to set values for SMTP variables, in production mode the project really depends of those variables**

```
export TREASURE_LATITUDE='50.051227 N'
export TREASURE_LONGITUDE='19.945704 E'

export SMTP_USER=
export SMTP_PASS=
export SMTP_HOST=smtp.gmail.com
export SMTP_PORT=587
```

### Testing

To run specs in this project you just need to run the following command:

```
bundle exec rspec spec
```
