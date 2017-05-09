`import Ember from 'ember'`
`import { validator, buildValidations } from 'ember-cp-validations'`
`import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'`


AnotherModelValidations = buildValidations(
  value: [
    validator('presence', true)
    validator('length', min: 4, max: 16, allowBlank: false)
  ]
)


MyModel = Ember.Object.extend(AnotherModelValidations, ValidationsHelper,

  value: 'hello'
)


PathModelValidations = buildValidations(
  'foo.bar': [
    validator('presence', true)
    validator('length', min: 4, max: 16, allowBlank: false)
  ]
)


PathModel = Ember.Object.extend(PathModelValidations, ValidationsHelper,

  foo: null

  init: ->
    @set('foo', Ember.Object.create(bar: 'foo.bar'))
)



ModelValidations = buildValidations(
  myOtherValue: [
    validator('presence', true)
    validator('length', min: 4, max: 8, allowBlank: false)
  ]
)

EditValueController = Ember.Controller.extend(ModelValidations, ValidationsHelper,

  myValue: 'foobar'
  myOtherValue: null

  myModel: null
  myPathModel: null
  myNumberValue: 40

  myTextValue: 'a text'
  textFormat: /^\w+$/

  tempValue: 'Hello'


  init: ->
    @_super(arguments...)
    @set 'myModel', MyModel.create(Ember.getOwner(this).ownerInjection())
    @set 'myPathModel', PathModel.create(Ember.getOwner(this).ownerInjection())

  actions:
    valueChanged: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'myValue', newvalue

    numberChanged: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'myNumberValue', newvalue

    textChanged: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'myTextValue', newvalue

    valueChangedOther: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'myOtherValue', newvalue

    valueChangedModel: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'myModel.value', newvalue

    tempChanged: (newvalue) ->
      console.log "New Value: ", newvalue
      @set 'tempValue', newvalue
)
`export default EditValueController`
