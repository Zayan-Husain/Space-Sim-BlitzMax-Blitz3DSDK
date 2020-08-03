



'////////////////game_world/////////////////////

Type game_world Extends yworld
	
Field  p:player 
Field deletingMode
		
	Method update()
		
		Super.update()
		

	EndMethod
	
	Method twodupdate()

	EndMethod
		
	Method init()
		
		Super.init()
	
		'init skybox
		skybox = bbCreateSphere( 12 )
		clouds = bbLoadTexture( "gfx/realsky.bmp" )
		bbScaleEntity skybox, 100, 100, 100
		bbEntityTexture skybox, clouds
		'bbScaleTexture clouds, 0.25, 0.25
		bbEntityOrder skybox, 1
		bbFlipMesh skybox
		bbEntityAlpha skybox, 0.25
		bbEntityFX skybox, 8
		skb = yentity.Create( 0, -5, 0, skybox )
		add( skb )



		
		'init player
		c =  bbCreateCube()
		p = player.Create( -3, 0, 7, c, 0.2 )
		add( p )

	
	EndMethod' init
	

		
	
		
	Function Create:game_world()
		
		tst:game_world =  New game_world

		
		Return tst
	
	EndFunction

EndType


'////////////////end game_world/////////////////////