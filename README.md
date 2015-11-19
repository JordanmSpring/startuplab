# StartupLab

## Development

Clone the repo:

    git clone git@github.com:JordanmSpring/startuplab.git

Bundle:

    bundle

Install bower:

    npm install -g bower

Install bower components:

    rake bower:install['-f']

Precompile:

    rake assets:precompile

Setup database:

    rake db:setup

Run the server:

    rails s
