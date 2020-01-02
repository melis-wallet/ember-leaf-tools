
import { oneWay, readOnly } from '@ember/object/computed'
import { defineProperty } from '@ember/object'

import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'
import { validator, buildValidations } from 'ember-cp-validations'
import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'


Validations = buildValidations(
  currentValue: [
    validator('number',
      allowString: true
      allowBlank: readOnly('model.allowBlank')
      integer: readOnly('model.integer')
      positive: readOnly('model.positive')
      lt: readOnly('model.lt')
      gt: readOnly('model.gt')
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
    defineProperty(this, 'currentValue', oneWay('value'))
    defineProperty(this, 'errorMessage', readOnly("validations.attrs.currentValue.message"))

)


export default EditableNumber