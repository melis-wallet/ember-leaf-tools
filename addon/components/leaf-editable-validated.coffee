`import Ember from 'ember'`
`import EditableValue from 'ember-leaf-tools/components/leaf-editable-value'`


EditableValidated = EditableValue.extend(

  model: null
  property: 'value'

  oldValue: null
  'text-area': false


  #
  #
  doneEdit: (value, newValue) ->
    Ember.Logger.debug("- changed new: #{newValue}, old:  #{value}")
    @sendAction('on-change', newValue, @get('ident'), @get('property'))
    @resetValue()


  resetValue: ->
    if !@get('model')
      Ember.defineProperty(this, 'currentValue', Ember.computed.oneWay('value'))
      @set('isValid', true)

  #
  #
  #
  initValue: ->
    if model = @get('model')
      property = @get('property')

      Ember.defineProperty(this, 'currentValue', Ember.computed.alias("model.#{property}"))
      Ember.defineProperty(this, 'isValid', Ember.computed.alias("model.validations.attrs.#{property}.isValid"))
      Ember.defineProperty(this, 'errorMessage', Ember.computed.alias("model.validations.attrs.#{property}.message"))
    else
      @resetValue()

)


`export default EditableValidated`