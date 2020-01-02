/* eslint-env node */
'use strict';

const fs   = require('fs'),
      path = require('path'),
      Funnel = require('broccoli-funnel'),
      mergeTrees = require('broccoli-merge-trees'),
      stew = require('broccoli-stew'),
      rename = stew.rename,
      map = stew.map;



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


    // register library version
    app.import('vendor/ember-leaf-tools/register-version.js');
  },

  treeForVendor(vendorTree) {
    let trees = [vendorTree];


    let versionTree = rename(
      map(vendorTree, 'ember-leaf-tools/register-version.template', (c) => c.replace('###VERSION###', require('./package.json').version)),
      'register-version.template',
      'register-version.js'
    );
    trees.push(versionTree);

    return mergeTrees(trees);
  }

};
