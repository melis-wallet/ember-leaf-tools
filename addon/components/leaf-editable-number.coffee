`import Ember from 'ember'`
`import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'`
`import { validator, buildValidations } from 'ember-cp-validations'`
`import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'`


Validations = buildValidations(
  currentValue: [
    validator('number',
      allowString: true
      allowBlank: Ember.computed.readOnly('model.allowBlank')
      integer: Ember.computed.readOnly('model.integer')
      positive: Ember.computed.readOnly('model.positive')
      lt: Ember.computed.readOnly('model.lt')
      gt: Ember.computed.readOnly('model.gt')
    )
  ]
)

EditableNumber = EditableValue.extend(Validations, ValidationsHelper,

  type: 'number'

  allowBlank: true
  integer: false
  positive: false

  lt: Infinity
  gt: -Infinity

  #
  #
  #
  initValue: ->
    Ember.defineProperty(this, 'currentValue', Ember.computed.oneWay('value'))
    Ember.defineProperty(this, 'errorMessage', Ember.computed.readOnly("validations.attrs.currentValue.message"))

)


`export default EditableNumber`