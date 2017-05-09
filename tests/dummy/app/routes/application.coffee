`import Ember from 'ember'`
`import StyleBody from 'ember-leaf-core/mixins/leaf-style-body'`

ApplicationRoute = Ember.Route.extend(StyleBody,

  classNames: ['theme-default']
)

`export default ApplicationRoute`
