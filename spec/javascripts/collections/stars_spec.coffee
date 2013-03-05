#describe "Stars collection", ->
#
#  beforeEach ->
#    console.log "--- before each, first..."
#    @stars = new Zephyr.Collections.Stars()
#    console.log "--- created @stars!"
#    console.log @stars
#    @starStub = sinon.stub(window, "Star")
#
#  afterEach ->
#    @starStub.restore()
#
#  describe "When instantiated with model literal", ->
#    beforeEach ->
#      console.log "--- attempting to create new Star..."
#      @model = new Star({
#        id: 5
#        x: 10
#        y: 25
#        silent: true
#      })
#      console.log "--- created it!"
#      console.log @model
#
#      @starStub.returns @star
#      @stars.model = Star
#      console.log "--- stars, before add (inner beforeEach): "
#      console.log @stars
#      @stars.add
#        id: 5
#        x: 10
#        y: 25
#      console.log "--- stars, after add (inner beforeEach): "
#      console.log @stars
#
#
#
#
#    it "should have 1 Star model", ->
#      console.log "--- stars, inside test 'should have 1 Star model': "
#      console.log @stars
#      expect(@stars.validate).toEqual true
#      expect(@stars.length).toEqual 1
#      expect(@starStub).toHaveBeenCalled()
#
##    it "should find a model by id", ->
##      expect(@stars.get(5).get("id")).toEqual @model.get("id")
#
##    it "should find a model by index", ->
##      expect(@stars.at(0).get("id")).toEqual @model.get("id")
#
#    it "should have called the Star constructor", ->
#      console.log "--- stars: "
#      console.log @stars
#
#      expect(@starStub).toHaveBeenCalledOnce()
#      expect(@starStub).toHaveBeenCalledWith
#        id: 5
#        x: 10
#        y: 25


# some example backbone-jasmine specs below... should've noted src :/
#describe "Stars collection", ->
#  beforeEach ->
#    @star = new Zephyr.Models.Star(
#      id: 1
#      x: 0
#      y: 0
#    )
#    @todo2 = new Zephyr.Models.Star(
#      id: 2
#      title: "Todo 2"
#      priority: 2
#    )
#    @star3 = new Zephyr.Models.Star(
#      id: 3
#      title: "Todo 3"
#      priority: 1
#    )
#    @star4 = new Zephyr.Models.Star(
#      id: 4
#      title: "Todo 4"
#      priority: 2
#    )
#    @stars = new Stars()
#    @todoStub = sinon.stub(window, "Todo")
#
#  afterEach ->
#    @todoStub.restore()
#
#  describe "When instantiated with model literal", ->
#    beforeEach ->
#      @model = new Zephyr.Models.Star(
#        id: 5
#        title: "Foo"
#      )
#      @todoStub.returns @model
#      @todos.model = Todo
#      @todos.add
#        id: 5
#        title: "Foo"
#
#
#    it "should have 1 Todo model", ->
#      expect(@todos.length).toEqual 1
#      expect(@todoStub).toHaveBeenCalled()
#
#    it "should find a model by id", ->
#      expect(@todos.get(5).get("id")).toEqual @model.get("id")
#
#    it "should find a model by index", ->
#      expect(@todos.at(0).get("id")).toEqual @model.get("id")
#
#    it "should have called the Todo constructor", ->
#      expect(@todoStub).toHaveBeenCalledOnce()
#      expect(@todoStub).toHaveBeenCalledWith
#        id: 5
#        title: "Foo"
#
#
#
#  describe "When adding models", ->
#    it "should order models by priority by default", ->
#      @todos.model = Todo
#      @todos.add [@todo1, @todo2, @todo3]
#      expect(@todos.at(0)).toBe @todo3
#      expect(@todos.at(1)).toBe @todo2
#      expect(@todos.at(2)).toBe @todo1
#
#
#  describe "when fetching collection from server", ->
#    beforeEach ->
#      @fixture = @fixtures.Todos.valid
#      @fixtureTodos = @fixture.response.todos
#      @server = sinon.fakeServer.create()
#      @server.respondWith "GET", "/todos", @validResponse(@fixture)
#
#    afterEach ->
#      @server.restore()
#
#    it "should make the correct request", ->
#      @todos.fetch()
#      expect(@server.requests.length).toEqual 1
#      expect(@server.requests[0].method).toEqual "GET"
#      expect(@server.requests[0].url).toEqual "/todos"
#
#    it "should parse the todos from the response", ->
#      @todos.fetch()
#      @server.respond()
#      expect(@todos.length).toEqual @fixture.response.todos.length
#      expect(@todos.get(1).get("title")).toEqual @fixture.response.todos[0].title
#
#    it "should inject the list name for each todo", ->
#      @todos.fetch()
#      @server.respond()
#      len = @fixtureTodos.length
#      expect(@todos.at(len).get("list")).toEqual @fixture.response.list  while len--
#
#
#  describe "Custom finds", ->
#    beforeEach ->
#      @todos.add [@todo1, @todo2, @todo3, @todo4]
#
#    describe "by priority", ->
#      it "should return only todos with the priority specified", ->
#        priority1 = @todos.findByPriority(2)
#        expect(priority1.length).toEqual 2
#        expect(priority1[0].get("priority")).toEqual 2
#        expect(priority1[1].get("priority")).toEqual 2
#
#
#
