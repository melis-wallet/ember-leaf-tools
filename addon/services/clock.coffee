`import Ember from 'ember'`

UPDATES_EVERY = 10000

Clock = Ember.Service.extend(
  hours: null
  minutes: null
  seconds: null

  setup: (->
    @tick()
  ).on('init')

  tick: ->
    now = new Date()

    @setProperties(
      hours: now.getHours()
      minutes: now.getMinutes()
      seconds: now.getSeconds()
    )

    Ember.run.later(this, (->
      @tick()
    ), UPDATES_EVERY)

)
`export default Clock`
