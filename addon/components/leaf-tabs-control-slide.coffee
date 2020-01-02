import Component from '@ember/component'
import { oneWay, notEmpty } from '@ember/object/computed'
import { scheduleOnce, later } from '@ember/runloop'

import HasChildren from 'ember-leaf-core/mixins/leaf-has-children'
import HasSelectableChildren from 'ember-leaf-core/mixins/leaf-has-selectable-children'
import SlyEnabled from 'ember-leaf-tools/mixins/sly-enabled'

import layout from 'ember-leaf-tools/templates/components/leaf-tabs-control-slide'

LeafTabsControlSlide = Component.extend(HasChildren, HasSelectableChildren, SlyEnabled,
  layout: layout

 # classNameBindings: ['simple:nav-tabs-simple', 'justified:nav-justified']

  sly_default_options: {
      horizontal: true,
      itemNav: 'centered',
      smart: true,
      mouseDragging: true
      touchDragging: true
      releaseSwing: true
      speed: 300
    }


  classType: ( ->
    if type = @get('type')
      "nav-tabs-#{type}"
  ).property('type')

  attributeBindings: ['aria-multiselectable', 'role'],

  type: 'xlg'

  #
  # simple style
  #
  simple: false


  #
  #
  #
  justified: false

  # Tells screenreaders that only one tab can be selected at a time.
  #
  # @property aria-multiselectable
  # @type String
  # @default false
  #
  'aria-multiselectable': false

  #
  # The `role` attribute of the tab list element.
  #
  # See http://www.w3.org/TR/wai-aria/roles#tablist
  #
  # @property role
  # @type String
  # @default 'tablist'
  #
  role: 'tablist',

  selectedChanged: ( ->
    scheduleOnce 'afterRender', this, ->
      if (selected = @get('selected'))
        @_slyFrame.activate(selected.get('element'))
  ).observes('selected')


  #
  # Gives focus to the selected tab.
  #
  # @method focusSelectedTab
  #
  focusSelectedTab: ->
    @get('selected').$().focus()



  navigateOnKeyDown: ((event)->
    switch event.keyCode
      # left, up
      when 37, 38 then @selectPreviousChild()
      # right, down
      when 39, 40 then @selectNextChild()

    event.preventDefault()
    scheduleOnce('afterRender', this, @focusSelectedTab);
  ).on('keyDown')

  resizeSlider: (-> later(this, @reloadSly, 500)).on('didInsertElement')

  childUnregistered: ->
    @_super(arguments...)
    #console.error "tab unregistered"
    #@reloadSly()
    later(this, @reloadSly, 200)

  childRegistered: ->
    @_super(arguments...)
    #console.error "tab registered"
    #@reloadSly()
    later(this, @reloadSly, 200)

)

export default LeafTabsControlSlide
