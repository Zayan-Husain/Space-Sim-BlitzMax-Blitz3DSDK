Type enemy Extends yentity
	
	Field max_hp = 10, hp = max_hp, team = 2, shootTimer:ytimer, shootTimerInterval = 2
	
	Method init()
		
		Super.init()
		
		shootTimer = ytimer.Create(shootTimerInterval)
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		
		hit()
		shoot()
		
	EndMethod
	
	Method shoot()
		
		If shootTimer.finished() Then
			
			p:player = player( get_by_type("player").First() )
			
			b:bullet = bullet.Create( 0, 0, 0, bbCreateCone(), 1 )
			world.add( b )
			bbPositionEntity b.grafic, x, y+3, z 'place the bullet at the guns position
			bbPointEntity b.grafic, p.grafic
			b.team = team
		EndIf
		
	EndMethod
	
	Method hit()
		
		b:bullet = bullet(collide("bullet"))
		
		If b and b.team <> team Then
			
			hp = hp - b.dmg
			world.remove(b)
			
		EndIf
		If hp <= 0 Then
			
			world.remove(Self)
			
		EndIf
		
	EndMethod
	
	Function Create:enemy( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:enemy =  New enemy
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "enemy"

		
		Return e
	
	EndFunction
	
EndType