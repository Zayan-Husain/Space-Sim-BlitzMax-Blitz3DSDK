Type enemy Extends yentity
	
	Field max_hp = 10, hp = max_hp, team = 2, shootTimer:ytimer, shootTimerInterval = 2, moveTimer:ytimer, movementType$ = "turret", randDir = 4,removed 
	Field body_dmg = 3, enemy_type = 1
	
	Method init()
		
		Super.init()
		
		shootTimer = ytimer.Create(shootTimerInterval)
		moveTimer = ytimer.Create(5)
		If movementType = "turret" Then
			move_by(0, 0, speed * 60)
		EndIf
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		
		hit()
		If removed Then return
		move()
		shoot()
		
	EndMethod
	
	Method move()
		
		If moveTimer.finished() Then
			
			randDir = Rand(1, 6)
			
		EndIf
		If movementType = "random" Then
			
			If randDir = 1 Then move_by(0, speed, 0) 'up
			If randDir = 2 Then move_by(0, -speed, 0) 'down
			If randDir = 3 Then move_by(-speed, 0, 0) 'left
			If randDir = 4 Then move_by(speed, 0, 0) 'right
			If randDir = 5 Then move_by(0, 0, speed) 'forward
			If randDir = 6 Then move_by(0, 0, speed) 'backward
			
		EndIf
		If movementType = "homing" Then
			
			p:player = player( get_by_type("player").First() )
			bbPointEntity(grafic, p.grafic)
			move_by(0, 0, speed)
			
		EndIf
		
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
		
		If b And b.team <> team Then
			
			hp = hp - b.dmg
			world.remove(b)
			
		EndIf
		If hp <= 0 Then
			
			world.remove(Self)
			removed = True
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