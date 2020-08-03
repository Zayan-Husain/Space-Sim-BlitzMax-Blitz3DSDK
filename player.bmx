
'////////////////player////////////////////

Type player Extends yentity
	
	Field trust:Float, pitch:Float, yaw:Float, roll:Float

	Method init()
	
		Super.init()


		

	End Method'end init
	
	Method update()
	
		Super.update()
		move()
		posCam()
	End Method'end update
	
	Method move()
		
		If kd( 30 ) Then
			trust = trust + 0.001
		EndIf
		If kd( 44 ) Then
			trust = trust - 0.001
		EndIf
		
		'yaw
		If kd( 203 ) Then
			yaw = yaw + 0.001
		EndIf
		If kd( 205 ) Then
			yaw = yaw - 0.001
		EndIf
		
		'pitch
		If kd( 200 ) Then
			pitch = pitch + 0.001
		EndIf
		If kd( 208 ) Then
			pitch = pitch - 0.001
		EndIf
		
		bbTurnEntity grafic, pitch, yaw, 0
		
		move_by( 0, 0, trust )
	
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