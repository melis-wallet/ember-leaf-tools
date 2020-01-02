import Route from '@ember/routing/route'
import StyleBody from 'ember-leaf-core/mixins/leaf-style-body'

ApplicationRoute = Route.extend(StyleBody,

  classNames: ['theme-default']
)

export default ApplicationRoute
