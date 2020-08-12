
'////////////////player////////////////////

Type player Extends yentity
	
	Field trust:Float, pitch:Float, yaw:Float, roll:Float, maxTrust = 5, minTrust = -3
	
	Field  pitchs:Float, yaws:Float, rolls:Float, tspeed:Float = 4
	
	Field shootTimer:ytimer, shootInterval = 0.8, team = 1, gun_type:String = "SMG", bullet_dmg = 1
	
	Field max_hp = 99999999999, hp = max_hp
	
	Field  tr:yentity
	
	Field target, home_range = 100

	Method init()
	
		Super.init()
		'tr = yentity( get_by_type( "enemy" ).First() )

		
		shootTimer = ytimer.Create( shootInterval )
		'create target
		target = bbLoadSprite( "gfx/target.bmp", 1, ye.camera )
		bbPositionEntity target, 0, 1.5, 60

	End Method'end init
	
	Method update()
	
		Super.update()
		move()
		posCam()
		shoot()
		hit()
		fps_cam()
		boundaries()
	End Method'end update
	
	Method boundaries()
		
		w:game_world = game_world( world )
		if x > w.range then sx( w.range )
		if x < -w.range then sx( -w.range )
		if y < -w.range then sxyz( x, -w.range, z )
		if y > w.range then sxyz( x, w.range, z )
		if z < -w.range then sxyz( x, y, -w.range )
		if z > w.range then sxyz( x, y, w.range )
	EndMethod
	
	Method set_home_target()
		
		enemies:TList = get_by_type( "enemy" )
		
		For e:enemy = EachIn enemies
			dist = bbEntityDistance( grafic, e.grafic )
			If dist < home_range Then
				'Print "enemy in distance: " + dist
				tr = e
				Return
			EndIf
		Next
	EndMethod
	
	Method fps_cam()
		
		bbHidePointer()
		y_camera = grafic'ye.camera
		bbTurnEntity y_camera, 0, -bbMouseXSpeed()/5.0, 0
		bbTurnEntity y_camera, bbMouseYSpeed() /5.0, 0, 0 'rotate camera up/down according to mouse Y movement
		If bbEntityPitch( y_camera ) < -45 'don't allow camera to look below -45 degrees
		'bbRotateEntity y_camera, -45, bbEntityYaw( y_camera ), bbEntityRoll( y_camera )
		EndIf
		If bbEntityPitch( y_camera ) > 45 'don't allow camera to look above 45 degrees
		'bbRotateEntity y_camera, 45, bbEntityYaw( y_camera ), bbEntityRoll( y_camera )
		EndIf
		bbMoveMouse bbGraphicsWidth()/2, bbGraphicsHeight()/2'reset mouse position to middle of screen
		
	EndMethod 'end fps cam
	
	Method change_gun( gt:String )
		
		gun_type = gt
		
		If gun_type = "SMG" Then
			
			shootInterval = 0.5
			bullet_dmg = 1
			
		EndIf
		If gun_type = "pistol" Then
			
			shootInterval = 1.3
			bullet_dmg = 3
			
		EndIf
		If gun_type = "shotgun" Then
			
			shootInterval = 2
			bullet_dmg = 2
			
		EndIf
		
		If gun_type = "homing" Then
			
			shootInterval = 4
			bullet_dmg = 7
			
		EndIf
		
		shootTimer = ytimer.Create( shootInterval )
		
	EndMethod
	
	Method move()
		
		If kd( 30 ) Then
			trust = trust + 0.01
		EndIf
		If kd( 44 ) Then
			trust = trust - 0.01
		EndIf
		If trust > maxTrust Then trust = maxTrust
		If trust < minTrust Then trust = minTrust
		
		
		
		'tspeed devided by 10
		tspeed_dt:Float = tspeed/10
		
		'yaw
		If kd( 203 ) Then
			yaws = yaws +( tspeed-yaws ) * tspeed_dt
		EndIf
		If kd( 205 ) Then
			yaws = yaws +( -tspeed-yaws ) * tspeed_dt
		EndIf
		
		'pitch
		If kd( 208 ) Then
			pitchs = pitchs +( tspeed-pitchs ) * tspeed_dt
		EndIf
		If kd( 200 ) Then
			pitchs = pitchs +( -tspeed-pitchs ) * tspeed_dt
		EndIf
		
		yaw = yaw +yaws
		If yaw < -180 Then yaw = yaw+360
		If yaw >= 180 Then yaw = yaw-360
		
		pitch = pitch + pitchs
		If pitch < -180 Then pitch = pitch+360
		If pitch >= 180 Then pitch = pitch-360		
		
		'switch guns
		If kd( 2 ) Then change_gun( "SMG" )
		If kd( 3 ) Then change_gun( "pistol" )
		If kd( 4 ) Then change_gun( "shotgun" )
		If kd( 5 ) Then change_gun( "homing" )

	
		
		'rotate and move ship
		bbTurnEntity grafic, pitch, yaw, 0
		
		move_by( 0, 0, trust )
		
		'apply friction
		pitchs = 0
		pitch = 0
		yaws = 0
		yaw = 0
	EndMethod
	
	Method shoot()
		
		If bbMouseDown( 1 ) And shootTimer.finished() Then
			
			If gun_type = "shotgun" Then
			
				make_bullet( x, y+3, z, 1 )
				make_bullet( x-3, y+3, z, 1 )
				make_bullet( x+3, y+3, z, 1 )
				Return
			EndIf
			If gun_type = "homing" Then
				set_home_target()
				b:bullet = make_bullet( x, y+3, z, 1 )
				If tr <> Null Then
					b.target = tr
					b.movementType = "homing"
				EndIf
				Return
			EndIf
			b = make_bullet( x, y+3, z, 1 )
			bbPointEntity b.grafic, target
		EndIf
		
	EndMethod
	
	Method make_bullet:bullet( yx, yy, yz, yspeed )
	
			b:bullet = bullet.Create( 0, 0, 0, bbCreateCone(), yspeed )
			world.add( b )
			bbPositionEntity b.grafic, yx, yy, yz 'place the bullet at the guns position
			bbTurnEntity b.grafic, bbEntityPitch( grafic ), bbEntityYaw( grafic ), bbEntityRoll( grafic )'the bullet with the gun
			b.dmg = bullet_dmg
			b.alpha( 0.5 )
			Return b
	EndMethod
	
	Method hit()
		
		b:bullet = bullet( collide( "bullet" ) )
		zo:enemy = enemy( collide( "enemy" ) )
		c:yentity = yentity( collide( "coin" ) )
		If b And b.team <> team Then
			hp = hp - b.dmg
			world.remove( b )
		EndIf
		If zo Then
			
			hp = hp - zo.body_dmg
			zo.move_by( 0, 0, -7 )
			
		EndIf
		if c then
			gw:game_world = game_world( world )
			gw.score + = gw.coinIncrement
			world.remove( c )
		endif
		If hp <= 0 Then
			
			ye.change_world( "game_over" )
			
		EndIf
		
	EndMethod
	
	Method posCam()
		
		cam = ye.camera
		bbEntityParent cam, grafic
		bbPositionEntity cam, 0, 1, -5
	EndMethod

	
	'///////constructor////////
	
	Function Create:player( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:player =  New player
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "player"

		
		Return e
	
	EndFunction

EndType


'////////////////end player////////////////////
Rem
random spawn for turret ✔
arena movement limit ✔
make the background move with player
coins ✔
boss
make bullets sprites
bigger bullet hitbox FOR PLAYER ONLY


MAYBE LATER:
level system
EndRem