



'////////////////game_world/////////////////////

Type game_world Extends yworld
	
Field  p:player 
Field range = 250, coin_timer:ytimer, coinInterval = 10, score = 0, coinIncrement = 10
		
	Method update()
		
		Super.update()
		
		spawn_coin()

	EndMethod
	
	Method twodupdate()

	EndMethod
		
	Method init()
		
		Super.init()
	
		'init skybox
		skybox = bbCreateSphere( 12 )
		clouds = bbLoadTexture( "gfx/realsky.bmp" )
		bbScaleEntity skybox, 500, 500, 500
		bbEntityTexture skybox, clouds
		'bbScaleTexture clouds, 0.25, 0.25
		bbEntityOrder skybox, 1
		bbFlipMesh skybox
		bbEntityAlpha skybox, 0.25
		bbEntityFX skybox, 8
		skb = yentity.Create( 0, -5, 0, skybox )
		add( skb )



		e:enemy = enemy.Create( 0, 0, 0, bbCreateSphere(), 0.15 )
		add( e )
		
		'init player
		c =  bbCreateCube()
		p = player.Create( -3, 0, 7, c, 0.2 )
		add( p )
		
		coin_timer = ytimer.Create( coinInterval )
		
		'spawner
		sp:spawner = spawner.Create( 5, -4, 7, bbCreateCylinder(), 0 )
		add( sp )
		
		boss2:boss = boss.Create( 3, 3, 3, bbCreateCylinder(), 0.075 )
		bbScaleEntity boss2.grafic, 5, 5, 5
		boss2.collide_c = 5
		add( boss2 )
		

	
	EndMethod' init
	
	Method spawn_coin()
		
		if coin_timer.finished() then
			coinX = Rand( 0, range - 10 )
			coinY = Rand( 0, range - 10 )
			coinZ = Rand( 0, range - 10 )
			c:yentity = yentity.Create( coinX, coinY, coinZ, bbCreateSphere(), 0 )
			bbEntityColor c.grafic, 255, 255, 0
			add( c )
			c.ytype = "coin"
		endif
		
	EndMethod
		
	
		
	Function Create:game_world()
		
		tst:game_world =  New game_world

		
		Return tst
	
	EndFunction

EndType


'////////////////end game_world/////////////////////