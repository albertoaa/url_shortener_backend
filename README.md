# README

## Installation and setup

### Ruby version

Check that you have installed and currently using ruby version `2.6.5` with `ruby -v`.

### Clone the project

Clone the project into your computer with `git clone <url of this project>`

### Install dependencies

Go into the project folder and install dependencies with `bundler install` if you don't have bundler installed already install it with `gem install bundler`

### Database

To create the database be sure that you have a Postgres local installation configured properly.
Create the database with `rails db:create`
Migrate tables with `rails db:migrate`

- Optional: Add some example seeds with `rails db:seed`

### Tests

Run the projects tests executing `rspec` in the project folder.

### Start the project

Run the project with: `rails s`

- Note: If your started the react-frontend project, associated with the project, first please specify a port with `-p` option like this: `rails s -p 8080` and change the file `src/utils/url.js` on the react-frontend project to match the specified port
