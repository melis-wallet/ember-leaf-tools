/* eslint-env node */
'use strict';

var fs   = require('fs'),
    path = require('path')


module.exports = {
  name: 'ember-leaf-tools',

  included: function( app, parentAddon ) {
    this._super.included(app);

    var target = (parentAddon || app);

    var componentsPath = target.bowerDirectory;

    // Sly
    app.import(componentsPath + '/sly/dist/sly.js');


    // clipboard support
    app.import(componentsPath + "/clipboard/dist/clipboard.js");


    // taggle support
    app.import(componentsPath + "/taggle/src/taggle.js");

  }
};
