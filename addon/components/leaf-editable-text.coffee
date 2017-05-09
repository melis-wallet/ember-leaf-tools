`import Ember from 'ember'`
`import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'`
`import { validator, buildValidations } from 'ember-cp-validations'`
`import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'`


Validations = buildValidations(
  currentValue: [
    validator('length',
      allowBlank: Ember.computed.readOnly('model.allowBlank')
      is: Ember.computed.readOnly('model.length')
      min: Ember.computed.readOnly('model.min-length')
      max: Ember.computed.readOnly('model.max-length')
    )
    validator('format',
      allowBlank: true
      regex: Ember.computed.readOnly('model.format')
      message: Ember.computed.readOnly('model.format-msg')
    )

  ]
)

EditableText = EditableValue.extend(Validations, ValidationsHelper,

  type: 'text'

  allowBlank: true
  length: null
  'min-length': null
  'max-length': null

  format: null
  'format-msg': null


  #
  #
  #
  initValue: ->
    Ember.defineProperty(this, 'currentValue', Ember.computed.oneWay('value'))
    Ember.defineProperty(this, 'errorMessage', Ember.computed.readOnly("validations.attrs.currentValue.message"))

)


`export default EditableText`