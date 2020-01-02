import EmberObject from '@ember/object'
import { isBlank, isNone } from '@ember/utils'
import { later, cancel } from '@ember/runloop'

Scheduler = EmberObject.extend(

  interval: 5000
  timer: null

  reSchedule: (fn) ->
    later( this, (->
      fn.apply(this)
      @set('timer', @reSchedule(fn))
    ), @get('interval'))

  stop: ->
    if timer = @get('timer')
      cancel(timer)
      @set('timer', null)

  schedule: (fn, interval) ->
    unless @get('timer')
      @set('interval', interval) if !isBlank(interval)
      @set('timer', @reSchedule(fn))
)

export default Scheduler
