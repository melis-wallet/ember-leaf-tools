import Ember from 'ember'
import MomentFromNow from 'ember-moment/helpers/moment-from-now'

import { inject as service } from '@ember/service'

#
# like moment-from-now but keeps updating every minute
#
LiveMomentFromNow = MomentFromNow.extend(

  clock: service('clock')

  setup: ( -> @get('clock.minutes')).on('init')

  onTimeChange: ( ->
    @recompute()
  ).observes('clock.minutes')
)

export default LiveMomentFromNow
