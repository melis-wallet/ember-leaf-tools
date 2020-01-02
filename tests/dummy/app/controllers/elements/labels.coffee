import Controller from '@ember/controller'
import { A } from '@ember/array'

LabelsController = Controller.extend(

  labels: [
    'foo'
    'bar'
    'baz'
  ]

  selected: A()

  actions:
    fooBar: ->
      console.log "hellO"

)

export default LabelsController
