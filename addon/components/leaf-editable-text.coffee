
import { oneWay, readOnly } from '@ember/object/computed'
import { defineProperty } from '@ember/object'

import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'
import { validator, buildValidations } from 'ember-cp-validations'
import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'


Validations = buildValidations(
  currentValue: [
    validator('length',
      allowBlank: readOnly('model.allowBlank')
      is: readOnly('model.length')
      min: readOnly('model.min-length')
      max: readOnly('model.max-length')
    )
    validator('format',
      allowBlank: true
      regex: readOnly('model.format')
      message: readOnly('model.format-msg')
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
    defineProperty(this, 'currentValue', oneWay('value'))
    defineProperty(this, 'errorMessage', readOnly('validations.attrs.currentValue.message'))

)


export default EditableText