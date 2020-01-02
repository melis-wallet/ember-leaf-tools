import Component from '@ember/component'
import { scheduleOnce } from "@ember/runloop"

import TypeSupport from 'ember-leaf-core/mixins/leaf-type-support'
import TooltipSupport from 'ember-leaf-core/mixins/leaf-tooltip-support'
import layout from 'ember-leaf-tools/templates/components/leaf-dropdown-icon'


LeafDropdownIcon = Component.extend(TypeSupport, TooltipSupport,
  layout: layout

  tagName: 'li'
  classNames: ['nav-icon-btn', 'dropdown']
  classTypePrefix: 'nav-icon-btn'

  icon: 'fa fa-cog'

  count: null

  shown: false

  stateHandler: (->
    scheduleOnce 'afterRender', this, @_stateHandler
  ).on('didInsertElement')


  _stateHandler: ->
    @.$().on('shown.bs.dropdown', =>
      @set('shown', true)
    )
    @.$().on('hidden.bs.dropdown', =>
      @set('shown', false)
    )

)

export default LeafDropdownIcon
