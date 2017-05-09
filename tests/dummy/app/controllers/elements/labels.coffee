`import Ember from 'ember'`


LabelsController = Ember.Controller.extend(

  labels: [
    'foo'
    'bar'
    'baz'
  ]

  selected: Ember.A()

  actions:
    fooBar: ->
      console.log "hellO"

)
`export default LabelsController`
