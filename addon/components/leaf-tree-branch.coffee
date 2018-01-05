`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-tree-branch'`

LeafTreeBranch = Ember.Component.extend(
  layout: layout

  tagName: 'ul'

  model: null

  async: false

  children: Ember.computed.alias('model.children')
)

`export default LeafTreeBranch`
