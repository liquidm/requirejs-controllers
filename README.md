# RequireJS Controllers

requirejs-controllers is a simple gem that provides a bunch of RequireJS
modules/classes useful to build JavaScript controllers for your Rails
controllers.

## Installation

Add this line to your application's Gemfile:

    gem 'requirejs-controllers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install requirejs-controllers

## Usage

Simply add the `requirejs_controller_tag` to your view to load the controller
specific module:

    = requirejs_controller_tag

The above helper will add a `requirejs_include_tag` and a simple `main` module
to load the controller specifics:

    <script>var require = {"baseUrl":"/assets"};</script>
    <script src="/assets/require.js"></script>
    <script>
    define('main', function() {
      require(['controllers/users'], function(controller) {
        window.controller = new controller('index')
      })
    })
    </script>

## Controllers

The following controllers are shipped with `requirejs-controllers`.

### BaseController

The `BaseController` is the base class for all controllers (similar to Rails'
`ApplicationController`). The `BaseController` will bind all events specified
in subclasses (see below) and then call the class method for the current
controller action if such a method exists in your class.

### GridController

tbd

### DataViewController

tbd

## Event Binding

tbd

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
