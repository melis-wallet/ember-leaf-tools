'use strict';

const path = require('path');
const EmberAddon = require('ember-cli/lib/broccoli/ember-addon');

module.exports = function(defaults) {
  let app = new EmberAddon(defaults, {
    // Add options here
    sassOptions: {implementation: require("node-sass"), outputFile: 'dummy.css'},

    'ember-bootstrap': {
      bootstrapVersion: 3,
      importBootstrapFont: false,
      importBootstrapCSS: false,
      whitelist: ['bs-collapse', 'bs-dropdown', 'bs-carousel']
    }
  });


  const componentsPath  = path.join('bower_components/');

  /*
    This build file specifies the options for the dummy test app of this
    addon, located in `/tests/dummy`
    This build file does *not* influence how the addon or the app using it
    behave. You most likely want to be modifying `./index.js` or app's build file
  */

  return app.toTree();
};
