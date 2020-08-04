Type bullet extends yentity
	
	Field dmg, lifeTimer
	
	Method init()
		
		Super.init()
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		
		move()
		
	EndMethod
	
	Method move()
		
		move_by(0, 0, speed)
		
	EndMethod
	
	Function Create:bullet( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:bullet =  New bullet
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "bullet"

		
		Return e
	
	EndFunction
	
	
EndType