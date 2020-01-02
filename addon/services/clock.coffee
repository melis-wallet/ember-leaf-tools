import Service from '@ember/service'
import { later } from '@ember/runloop'

UPDATES_EVERY = 10000

Clock = Service.extend(
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

    later(this, (->
      @tick()
    ), UPDATES_EVERY)

)

export default Clock
