# Use the official Ruby image
FROM ruby:2.7.8

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev curl && \
    apt-get install -y libc6

# Install Node.js (version 14.x)
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

# Install Yarn
RUN npm install -g yarn

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Force Nokogiri to use the Ruby platform
ENV BUNDLE_FORCE_RUBY_PLATFORM=true

# Install the Ruby dependencies
RUN bundle install

# Copy the rest of the application code
COPY . ./

# Install JavaScript dependencies
RUN yarn install

# Install Webpack globally
RUN yarn global add webpack webpack-cli

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# The command to run the app
CMD ["rails", "server", "-b", "0.0.0.0"]




