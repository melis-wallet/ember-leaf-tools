`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-tree-node'`

EXPANDED_CLASS = 'expanded'
CLOSED_CLASS = 'closed'

TOGGLE_ICON = 'fa fa-plus-square'
EXPANDED_ICON = 'fa fa-minus-square'
LEAF_ICON = 'fa fa-square'

UNSELECTED_ICON = 'fa fa-square-o'
SELECTED_ICON = 'fa fa-check-square-o'

LeafTreeNode = Ember.Component.extend(
  layout: layout

  tagName: 'li'

  classNameBindings: ['topLevel:toplevel:deeplevel']


  #
  model: null

  #
  tree: null

  #
  rootModel: Ember.computed.alias('tree.model')

  #
  expanded: Ember.computed.alias('model.expanded')

  #
  selectable: true

  #
  leaf: Ember.computed.alias('model.leaf')


  topLevel: ( -> (@get('model.level') == 1)).property('model.level')


  expandedClass: ( ->
    if @get('expanded')
      EXPANDED_CLASS
    else
      CLOSED_CLASS
  ).property('expanded', 'leaf', 'loading')

  primaryIcon: ( ->
    if @get('async')


    else
      if @get('leaf')
        LEAF_ICON
      else if @get('expanded')
        EXPANDED_ICON
      else
        TOGGLE_ICON
  ).property('expanded', 'leaf', 'loading')


  selectionIcon: ( ->
    if @get('selectable')
      if @get('selected')
        SELECTED_ICON
      else
        UNSELECTED_ICON
    else
      # tbd


  ).property('selectable', 'selected')


  actions:
    toggleExpand: ->
      if @get('async')
        # tbd
      else
        @toggleProperty('expanded')


    toggleSelect: ->
      @toggleProperty('selected')



)

`export default LeafTreeNode`
