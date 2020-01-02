import EmberObject from '@ember/object'
import Mixin from '@ember/object/mixin'
import { alias } from '@ember/object/computed'
import { assert } from '@ember/debug'
import { isBlank, isNone } from '@ember/utils'


Error = EmberObject.extend()

ValidationsHelper = Mixin.create

  isValid: alias('validations.isValid')

  init: ->
    @_super(arguments...)

    assert('This mixin requires an object with validations', @get('validations'))

    @set('errors', Error.create()) if !@get('errors')
    @get('validations.validatableAttributes')?.forEach((va) =>
      @addObserver("validations.attrs.#{va}.messages", this, (=> @_copyErrors(this, va) ))
    )


  validate: ->
    modelErrors = @get('errors')

    @get('validations').validate(arguments...).then((validations) =>
      if !isNone(modelErrors) && Ember.canInvoke(modelErrors, 'add')
        @get('validations.validatableAttributes')?.forEach((va) => @_copyErrors(this, va))
      return validations
    )


  _copyErrors: (model, attribute) ->
    modelErrors = model.get('errors')
    wasEmpty = modelErrors.get('isEmpty')

    #if modelErrors.get(attribute)
    #  modelErrors.delete(attribute)

    messages = @get("validations.attrs.#{attribute}.messages")
    #console.error "mess: ", messages
    #console.error "attrs:",  "validations.attrs.#{attribute}.messages",  @get("validations.attrs.#{attribute}.messages")

    # i don't know how to handle nested validations
    if !attribute.includes('.')
      modelErrors.set(attribute, messages)
    else
      console.warn("[VALIDATION] nested attribute", attribute)

    #if (messages && messages.length > 0)
    #  messages.forEach((m) => modelErrors.set(attribute, m))

    #console.error "err", modelErrors


export default ValidationsHelper


