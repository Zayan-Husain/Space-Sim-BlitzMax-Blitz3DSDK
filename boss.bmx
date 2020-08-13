Type boss extends enemy
	
	Field movementType = 2, moves = 5, shoot_timer:ytimer
	
	Method init()
		
		Super.init()
		
		shoot_timer = ytimer.Create(2)
		
	EndMethod
	Method update()
		Super.update()
		shoot()
	end method
	
	Method shoot()
		if not shoot_timer.finished() then return
		'move = Rand(1, moves)
		move2 = 1
		'move = 2
		'move = 3
		'move = 4
		'move = 5
		if move2 = 1 Then
			b:bullet = bullet.Create(x, y+3, z, bbCreateSphere(), 0)
			bbScaleEntity b.grafic, 2, 2, 2
			bbEntityColor b.grafic, 255, 0, 0
			b.team = team
			world.add(b)
		EndIf
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