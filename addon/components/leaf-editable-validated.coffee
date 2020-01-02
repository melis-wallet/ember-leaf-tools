
import { oneWay, readOnly, alias } from '@ember/object/computed'
import { defineProperty } from '@ember/object'

import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'


EditableValidated = EditableValue.extend(

  model: null
  property: 'value'

  oldValue: null
  'text-area': false


  #
  #
  doneEdit: (value, newValue) ->
    @sendAction('on-change', newValue, @get('ident'), @get('property'))
    @resetValue()


  resetValue: ->
    if !@get('model')
      defineProperty(this, 'currentValue', oneWay('value'))
      @set('isValid', true)

  #
  #
  #
  initValue: ->
    if model = @get('model')
      property = @get('property')

      defineProperty(this, 'currentValue', alias("model.#{property}"))
      defineProperty(this, 'isValid',  alias("model.validations.attrs.#{property}.isValid"))
      defineProperty(this, 'errorMessage', alias("model.validations.attrs.#{property}.message"))
    else
      @resetValue()

)


export default EditableValidated