# Use the official Ruby image as a parent image
FROM ruby:3.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs npm

# Install Yarn
RUN npm install -g yarn

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the Ruby dependencies
RUN bundle install

# Copy the rest of the application code
COPY . ./

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# The command to run the app
CMD ["rails", "server", "-b", "0.0.0.0"]

