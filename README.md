# SPHERE.IO Deleter

[![Build Status](https://secure.travis-ci.org/mmoelli/sphere-deleter.png?branch=master)](http://travis-ci.org/mmoelli/sphere-deleter)

With this component you can easily delete a bulk of resources on the [SPHERE.IO](https://admin.sphere.io) platform.

## Getting Started
Install the module with: `npm install sphere-deleter`


## Documentation
General command line options can be seen by simply executing the command `node lib/run`.
```
node lib/run

  Usage:     --projectKey <project-key> --clientId <client-id> --clientSecret <client-secret> --ipAddress <ip-address>

  Options:

    --projectKey <key>              your SPHERE.IO project-key
    --clientId <id>                 your OAuth client id for the SPHERE.IO API
    --clientSecret <secret>         your OAuth client secret for the SPHERE.IO API
    --resource <resource>           the type of resource you want delete
    --deleteHours <hours>           number of hours to go back for deletion (lastModified)  [default: 1]
    --logLevel <level>              specifies log level (error|warn|info|debug|trace)       [default: info]
    --logDir <directory>            specifies log file directory [.]
    --logSilent <boolean>           use console to print messages                           [default: false]
```

## Tests
Tests are written using [jasmine](http://pivotal.github.io/jasmine/) (Behavior-Driven Development framework for testing javascript code). Thanks to [jasmine-node](https://github.com/mhevery/jasmine-node), this test framework is also available for Node.js.

To run tests, simple execute the *test* task using `grunt`.

```bash
$ grunt test
```

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/). More info [here](CONTRIBUTING.md)

## Releasing
Releasing a new version is completely automated using the Grunt task `grunt release`.

```javascript
grunt release // patch release
grunt release:minor // minor release
grunt release:major // major release
```

## Styleguide
We <3 CoffeeScript here at commercetools! So please have a look at this referenced [coffeescript styleguide](https://github.com/polarmobile/coffeescript-style-guide) when doing changes to the code.

## License
Copyright (c) 2015 Martin Möllmann
Licensed under the MIT License