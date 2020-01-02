import Component from '@ember/component'
import { A } from '@ember/array'

import SlyEnabled from 'ember-leaf-tools/mixins/sly-enabled'
import layout from 'ember-leaf-tools/templates/components/leaf-infinite-list'

InfiniteList = Component.extend(SlyEnabled,
  layout: layout

  ActiveElements: A()

  sly_default_options: {
      scrollBy: 3
      itemNav: 'centered'
      smart: true
      speed: 100
      mouseDragging: true
      touchDragging: true
      releaseSwing: true
      elasticBounds: true
      dragHandle: true
      dynamicHandle: true
      keyboardNavBy: 'items'
    }

  currentPage: 5



  getPage: (page, perPage) ->
    perPage ||= 10

    [(page*perPage)...((page + 1) * perPage)].map((i) ->
      {id: "elem-#{i}", count: i }
    )

  activateItem: (item) ->
    if item
      el = @.$("##{item.id}")
      if el
        @_slyFrame.activate(el)

  setup: (->
    @set('currentTop', @get('currentPage'))
    @set('currentBottom', @get('currentPage'))

    @set('activeElements', @getPage(@get('currentPage'), 10))
    @activateItem(@get('activeElements.firstObject'))
  ).on('init')


  notifySly: (->


    if @get('activeElements.length')

      @slyContentChanged()
  ).observes('activeElements.[]', 'shown')


  loadBottom: (->
    newEl = @getPage(@incrementProperty('currentBottom'), 10)
    @get('activeElements').addObjects(newEl)
  ).on('bottom-scroll')


  loadTop: (->
    if @get('currentTop') > 0
      newEl = @getPage(@decrementProperty('currentTop'), 10)
      @get('activeElements').unshiftObjects(newEl)
  ).on('top-scroll')

  actions:
    selectItem: (item) ->
      @activateItem item

)

`export default InfiniteList`
