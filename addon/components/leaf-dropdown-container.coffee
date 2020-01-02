import Component from '@ember/component'
import StyleBindings from 'ember-leaf-core/mixins/leaf-style-bindings'

DropdownContainer = Component.extend(StyleBindings,

  width: '200px'

  shown: false

  styleBindings: ['width']
  classNames: ['dropdown-menu', 'no-padding']
)

export default DropdownContainer
