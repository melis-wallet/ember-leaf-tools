`import Ember from 'ember'`
`import StyleBindings from 'ember-leaf-core/mixins/leaf-style-bindings'`

DropdownContainer = Ember.Component.extend(StyleBindings,

  width: '200px'

  shown: false

  styleBindings: ['width']
  classNames: ['dropdown-menu', 'no-padding']
)

`export default DropdownContainer`
