
'////////////////player////////////////////

Type player Extends yentity
	
	Field trust:Float, pitch:Float, yaw:Float, roll:Float
	
	Field  pitchs:Float, yaws:Float, rolls:Float, tspeed:Float = 4
	
	Field shootTimer:ytimer, shootInterval = 0.8, team = 1, gun_type:String = "SMG", bullet_dmg = 1

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
	
	Method change_gun(gt$)
		
		gun_type = gt
		
		If gun_type = "SMG" Then
			
			shootInterval = 0.5
			bullet_dmg = 1
			shootTimer = ytimer.Create( shootInterval )
			
		EndIf
		If gun_type = "pistol" Then
			
			shootInterval = 1.3
			bullet_dmg = 3
			shootTimer = ytimer.Create( shootInterval )
			
		EndIf
		If gun_type = "shotgun" Then
			
			shootInterval = 2
			bullet_dmg = 2
			shootTimer = ytimer.Create( shootInterval )
			
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
			change_gun("SMG")
		EndIf
		If kd( 3 ) Then 
			change_gun("pistol")

		EndIf
		If kd( 4 ) Then 
			change_gun("shotgun")
		EndIf

	
		
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
			
			If gun_type = "shotgun" Then
			
				make_bullet(x,y+3,z,1)
				make_bullet(x-3,y+3,z,1)
				make_bullet(x+3,y+3,z,1)
				Return
			EndIf
			
			make_bullet(x,y+3,z,1)
		EndIf
		
	EndMethod
	
	Method make_bullet(yx,yy,yz,yspeed)
	
			b:bullet = bullet.Create( 0, 0, 0, bbCreateCone(), yspeed )
			world.add( b )
			bbPositionEntity b.grafic, yx, yy, yz 'place the bullet at the guns position
			bbTurnEntity b.grafic, bbEntityPitch( grafic ), bbEntityYaw( grafic ), bbEntityRoll( grafic )'the bullet with the gun
			b.dmg = bullet_dmg
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