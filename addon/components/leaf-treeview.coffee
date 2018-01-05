`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-treeview'`
`import TreeNode from 'ember-leaf-tools/utils/node'`

LeafTreeview = Ember.Component.extend(
  layout: layout

  tagName: 'ul'
  classNames: ['leaf-tree']

  tree: null

  activeTree: ( ->
    if (tree = @get('tree'))
      if Ember.typeOf('tree.firstObject') == 'TreeNode'
        return tree
      else
        tree
  ).property('tree')

  async: false


  'in-multi-selection': false
  'multi-selection': Ember.A()
  'selected-icon': 'fa fa-check'
  'unselected-icon': 'fa fa-times'
  'expand-depth': null


  children: Ember.computed.alias('activeTree.children')

)

`export default LeafTreeview`
