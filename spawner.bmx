Type spawner extends yentity
	
	Field spawn_timer:ytimer, spawnInterval = 5
	
	Field spawn_type = 1, enemy_types = 4
	
	Method init()
		
		Super.init()
		
		spawn_timer = ytimer.Create(spawnInterval)
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		
		spawn()
		
	EndMethod
	
	Method spawn()
		
		If spawn_timer.finished() Then
			Print spawn_type
			'spawn_type = Rand(1, enemy_types)
			spawn_type = 2
			Print spawn_type
			newEnemy:enemy = enemy.Create(x, y, z, bbCreateSphere(), 0.15)
			newEnemy.enemy_type = spawn_type
			newEnemy.parent_spawner = Self
			world.add(newEnemy)
			
		EndIf
		
	End Method
	
	Function Create:spawner( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:spawner =  New spawner
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "spawner"

		
		Return e
	
	EndFunction
	
End Type