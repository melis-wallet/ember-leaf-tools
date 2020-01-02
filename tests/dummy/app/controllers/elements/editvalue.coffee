import EmberObject from '@ember/object'
import Controller from '@ember/controller'
import { getOwner } from '@ember/application'

import { validator, buildValidations } from 'ember-cp-validations'
import ValidationsHelper from 'ember-leaf-tools/mixins/ember-cp-validations-helper'


AnotherModelValidations = buildValidations(
  value: [
    validator('presence', true)
    validator('length', min: 4, max: 16, allowBlank: false)
  ]
)


MyModel = EmberObject.extend(AnotherModelValidations, ValidationsHelper,

  value: 'hello'
)


PathModelValidations = buildValidations(
  'foo.bar': [
    validator('presence', true)
    validator('length', min: 4, max: 16, allowBlank: false)
  ]
)


PathModel = EmberObject.extend(PathModelValidations, ValidationsHelper,

  foo: null

  init: ->
    @set('foo', EmberObject.create(bar: 'foo.bar'))
)



ModelValidations = buildValidations(
  myOtherValue: [
    validator('presence', true)
    validator('length', min: 4, max: 8, allowBlank: false)
  ]
)

EditValueController = Controller.extend(ModelValidations, ValidationsHelper,

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
    @set 'myModel', MyModel.create(getOwner(this).ownerInjection())
    @set 'myPathModel', PathModel.create(getOwner(this).ownerInjection())

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

export default EditValueController
