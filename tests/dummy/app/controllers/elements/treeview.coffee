`import Ember from 'ember'`
`import TreeNode from 'ember-leaf-tools/utils/node'`

TreeviewController = Ember.Controller.extend(


  FIXTURES: [
    {id: 1, title: 'Family', children: [
      {id: 10, title: 'Susan' }
      {id: 11, title: 'Luda' }

    ]}

    {id: 2, title: "Foo", children: [
      {id: 21, title: 'Susan' }
      {id: 22, title: 'Luda' }
      {id: 23, title: 'Buda' }
    ]}

    {id: 3, title: "Foo", children: [
      {id: 31, title: 'Susan' }
      {id: 32, title: 'Luda' }
      {id: 33, title: 'Fuda' }
      {id: 34, title: 'Guda', children: [
        {id: 341, title: 'Luda' }
        {id: 342, title: 'Fuda' }
      ]}
    ]}

  ]



  tree: ( ->
    TreeNode.create(children: @get('FIXTURES'))
  ).property('FIXTURES')

)
`export default TreeviewController`
