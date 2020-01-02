import Route from '@ember/routing/route'

ElementsRoute = Route.extend(
  model: () ->
    [

      Ember.Object.create({title: "Tabs", route: "elements.tabs"})
      Ember.Object.create({title: "Editable Value", route: "elements.editvalue"})
      Ember.Object.create({title: "Keywords Input", route: "elements.keywordinput"})
      Ember.Object.create({title: "Multiple Toggler", route: "elements.multiple-toggler"})
      Ember.Object.create({title: "Labels", route: "elements.labels"})
      #Ember.Object.create({title: "Treeview", route: "elements.treeview"})

    ])


export default ElementsRoute
