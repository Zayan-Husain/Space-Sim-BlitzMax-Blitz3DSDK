Type spawner extends yentity
	
	Field spawn_timer:ytimer, spawnInterval = 25
	
	Field spawn_type = 1, enemy_types = 4, hp, max_hp = 50, team = 2
	
	Method init()
		
		Super.init()
		
		spawn_timer = ytimer.Create(spawnInterval)
		hp = max_hp
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		if grafic = 0 then return
		hit()
		spawn()
		
	EndMethod
	
	Method spawn()
		
		If spawn_timer.finished() Then
			Print spawn_type
			spawn_type = Rand(1, enemy_types)
			Print spawn_type
			newEnemy:enemy = enemy.Create(x, y, z, bbCreateSphere(), 0.15)
			newEnemy.enemy_type = spawn_type
			newEnemy.parent_spawner = Self
			newEnemy.team = team
			world.add(newEnemy)
			
		EndIf
		
	End Method
	
	Method hit()
		
		b:bullet = bullet(collide("bullet"))
		
		If b And b.team <> team Then
			
			hp = hp - b.dmg
			world.remove(b)
			
		EndIf
		If hp <= 0 Then
			world.remove(Self)
		EndIf
		
	EndMethod
	
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