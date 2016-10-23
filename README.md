# commercetools Deleter

[![Build Status](https://secure.travis-ci.org/mmoelli/sphere-deleter.png?branch=master)](http://travis-ci.org/mmoelli/sphere-deleter)

With this component you can easily delete a bulk of resources on the [commercetools](http://dev.commercetools.com) platform.

## Getting Started

### Via `npm`
* Install the module with: `$ npm install sphere-deleter`
* Build local libraries from coffeescript: `$ grunt build`

### Via GitHub
* Clone repository: `$ git clone git@github.com:mmoelli/sphere-deleter.git`
* Install dependencies from `npm`: `$ npm i`
* Build local libraries from coffeescript: `$ grunt build`

## Documentation
General command line options can be seen by simply executing the command `node lib/run`.
```
$ node lib/run

  Usage:     --projectKey <project-key> --clientId <client-id> --clientSecret <client-secret>

  Options:

    --projectKey <key>              your commercetools project-key
    --clientId <id>                 your OAuth client id for the commercetools API
    --clientSecret <secret>         your OAuth client secret for the commercetools API
    --resource <resource>           the type of resource you want delete
    --resourceId <id>               specific id of a resource you want to delete
    --deleteHours <hours>           number of hours to go back for deletion (lastModifiedAt)    [default: 1]
    --allTime
    --logLevel <level>              specifies log level (error|warn|info|debug|trace)           [default: info]
    --logDir <directory>            specifies log file directory [.]
    --logSilent <boolean>           use console to print messages                               [default: false]
```

### Supported Resources
The following resources can be selected for deletions
```
cartDiscounts
carts
categories
channels
customObjects
customers
customerGroups
discountCodes
inventoryEntries
orders
payments
products
productDiscounts
productProjections
productTypes
reviews
shippingMethods
states
taxCategories
types
zones
```

## Tests
Tests are written using [jasmine](https://jasmine.github.io/) (Behavior-Driven Development framework for testing javascript code). Thanks to [jasmine-node](https://github.com/mhevery/jasmine-node), this test framework is also available for Node.js.

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
