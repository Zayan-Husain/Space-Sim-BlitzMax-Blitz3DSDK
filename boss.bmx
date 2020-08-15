Type boss extends enemy
	
	Field movementType = 2, moves = 3, shoot_timer:ytimer
	
	Method init()
		
		Super.init()
		
		shoot_timer = ytimer.Create(2)
		hp = 100	
		
	EndMethod
	Method update()
		Super.update()
		If grafic = 0 then return
		warn()
		shoot()
	end method
	
	Method shoot()
		if not shoot_timer.finished() then return
		move2 = Rand(1, moves)
		if move2 = 1 Then
			p:player = player( get_by_type("player").First() )
			b:bullet = bullet.Create(x, y, z, bbCreateSphere(), 2)
			bbScaleEntity b.grafic, 2, 2, 2
			bbEntityColor b.grafic, 255, 75, 0
			world.add(b)
			bbPointEntity b.grafic, p.grafic
			b.team = team
			Print "It WORKS"
		EndIf
		If move2 = 2 Then
			For i = 0 Until 7
				b:bullet = bullet.Create(x, y, z, bbCreateCube(), speed)
				world.add(b)
				bbTurnEntity b.grafic, Rand(0, 360), Rand(0, 360), Rand(0, 360)
				bbEntityColor b.grafic, Rand(0, 255), Rand(0, 255), Rand(0, 255)
				b.team = team
				
			Next
		EndIf
		if move2 = 3 Then
			b:bullet = bullet.Create(x, y, z, bbCreateSphere(), 5)
			world.add(b)
			bbTurnEntity b.grafic, Rand(0, 360), Rand(0, 360), Rand(0, 360)
			b.collide_c = 15
			bbScaleEntity b.grafic, 15, 15, 15
			bbEntityColor b.grafic, Rand(0, 255), Rand(0, 255), Rand(0, 255)
			b.team = team
		EndIf
	EndMethod
	
	Method warn()
		
		if not shoot_timer.finished() then bbEntityColor grafic, 255, 10, 0 else bbEntityColor grafic, 0, 0, 0
		
	EndMethod
	
	Function Create:boss( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:boss =  New boss
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "boss"

		
		Return e
	
	EndFunction
	
EndType