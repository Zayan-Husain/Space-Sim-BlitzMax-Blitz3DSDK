Type bullet extends yentity
	
	Field dmg = 1, disappearTimer:ytimer, disappearTimerLength# = 5, team = 1
	
	Method init()
		
		Super.init()
		
		disappearTimer = ytimer.Create(disappearTimerLength)
		
	EndMethod
	
	Method update()
		
		Super.update()
		
		'methods
		
		move()
		disappear()
		
	EndMethod
	
	Method disappear()
		
		If disappearTimer.finished() Then
			
			world.remove( Self )
			
		EndIf
		
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