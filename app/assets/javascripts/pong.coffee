window.Paddle       = Zephyr.Models.Paddle
window.Ball         = Zephyr.Models.Ball
window.Score        = Zephyr.Models.Score


#window.PongView     = new Zephyr.Views.PongView({})
# ......

###

  Pong!

  A tiny in-browser pong game. Let's make it multiplayer (wrap a lobby around it, etc.)

###

class Pong extends atom.Game
  constructor: ->
    super
    window.PlayerPaddle   = new Paddle({x:0,y:20,width:20,height:120})
    window.PlayerPaddleView     = new Zephyr.Views.PaddleView({model:PlayerPaddle})

  refresh: ->
    window.ComputerPaddle = window.ComputerPaddle or= new Paddle({x:atom.width-20,y:20,width:20,height:120})
    window.ActiveBall     = window.ActiveBall or= new Ball({x:atom.width/2,y:atom.height/2,vx:9,vy:9})
    window.CurrentScore   = window.CurrentScore or= new Score({y:atom.height/2,x:atom.width/2,human:0,cpu:0})
    window.ComputerPaddleView   = window.ComputerPaddleView or= new Zephyr.Views.PaddleView({model:ComputerPaddle})
    window.BallView             = window.BallView or= new Zephyr.Views.BallView({model:ActiveBall})
    window.ScoreView            = window.ScoreView or= new Zephyr.Views.ScoreView({model:CurrentScore})


  draw: ->
    @refresh()

    ctx = atom.context
    ctx.fillStyle = "black"
    ctx.fillRect 0,0,atom.width,atom.height

    PlayerPaddleView.render()
    ComputerPaddleView.render()
    BallView.render()
    ScoreView.render()

  update: (dt) ->
    @refresh()

    PlayerPaddle.trackY(atom.input.mouse.y)
    if ActiveBall.get('vx') > 0 && ActiveBall.get('x') > atom.width/2
      ComputerPaddle.trackY(ActiveBall.get('y'))
    ActiveBall.move()

    ballX = ActiveBall.get('x')
    ballY = ActiveBall.get('y')
    ballRadius = ActiveBall.get('radius')
    ballVelX = ActiveBall.get('vx')
    ballVelY = ActiveBall.get('vy')

    paddleY = PlayerPaddle.get('y')
    cpuPaddleY = ComputerPaddle.get('y')
    paddleWidth = PlayerPaddle.get('width')
    paddleHeight = PlayerPaddle.get('height')

    if ballX <= paddleWidth + ballRadius
      if ballY >= paddleY && ballY <= paddleHeight + paddleY
        ballVelX = -ballVelX
        console.log 'ping!'
      else
        @lose()
    if ballX >= atom.canvas.width - ballRadius - paddleWidth
      if ballY >= cpuPaddleY && ballY <= paddleHeight + cpuPaddleY
        ballVelX = -ballVelX
        console.log 'pong!'
      else
        @win()

    if ballY <= ballRadius + 25 || ballY >= atom.canvas.height - ballRadius
      ballVelY = -ballVelY

    ActiveBall.set('vx',ballVelX)
    ActiveBall.set('vy',ballVelY)

  lose: ->
    CurrentScore.incrementCpu()
    @restart()

  win: ->
    CurrentScore.incrementHuman()
    @restart()

  restart: ->
    ActiveBall.set({x:atom.width/2,y:atom.height/2})

pong = new Pong()
window.onblur = -> pong.stop()
window.onfocus = -> pong.run()
pong.run()
