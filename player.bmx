
'////////////////player////////////////////

Type player Extends yentity
	
	Field trust:Float, pitch:Float, yaw:Float, roll:Float
	
	Field  pitchs:Float, yaws:Float, rolls:Float, tspeed:Float = 4
	
	Field shootTimer:ytimer, shootInterval = 0.5, team = 1, gun_type:String = "SMG", bullet_dmg = 1

	Method init()
	
		Super.init()
		
		shootTimer = ytimer.Create( shootInterval )
		

	End Method'end init
	
	Method update()
	
		Super.update()
		move()
		posCam()
		shoot()
	End Method'end update
	
	Method change_gun()
		
		If gun_type = "SMG" Then
			
			shootInterval = 0.5
			bullet_dmg = 1
			
		EndIf
		If gun_type = "pistol" Then
			
			shootInterval = 2
			bullet_dmg = 3
			
		EndIf
		If gun_type = "shotgun" Then
			
			shootInterval = 3
			bullet_dmg = 2
			
		EndIf
		
	EndMethod
	
	Method move()
		
		If kd( 30 ) Then
			trust = trust + 0.01
		EndIf
		If kd( 44 ) Then
			trust = trust - 0.01
		EndIf
		
		
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
		If kd( 2 ) Then 
			gun_type = "SMG"
		EndIf
		If kd( 3 ) Then 
			gun_type = "pistol"
		EndIf
		If kd( 4 ) Then 
			gun_type = "shotgun"
		EndIf
		Print gun_type
		change_gun()
		
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
		
		If kd( 57 ) And shootTimer.finished() Then
			
			b:bullet = bullet.Create( 0, 0, 0, bbCreateCone(), 1 )
			world.add( b )
			bbPositionEntity b.grafic, x, y+3, z 'place the bullet at the guns position
			bbTurnEntity b.grafic, bbEntityPitch( grafic ), bbEntityYaw( grafic ), bbEntityRoll( grafic )'the bullet with the gun
			b.dmg = bullet_dmg
			
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