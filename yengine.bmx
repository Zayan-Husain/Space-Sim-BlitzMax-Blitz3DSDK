



Type yengine

	Field current_world:yworld, camera, light
	
	Field worlds:TList =  New TList

	
	Method init()


'		worlds:TList =  New TList

		light = bbCreateLight()
		camera = bbCreateCamera()

		bbPositionEntity camera, 0, 0, -4
		
		current_world.init()
		 FPS = 30
		period = 1000/FPS
		time = MilliSecs()-period
		While Not bbKeyHit( 1 )
		
			Repeat
				elapsed = MilliSecs()-time
			Until elapsed
			
			update()
	
			bbRenderWorld
			twodupdate()
			bbFlip 1
			
			
		Wend
		
	EndMethod 'end init
	
	Method update()
	
		If current_world Then
			current_world.update()
		EndIf
		
	EndMethod
	
	Method twodupdate()
	
		If current_world Then
			current_world.twodupdate()
		EndIf
		
	EndMethod
	
	Method render()
	
		'current_world.update()
		
	EndMethod
	
	Method add_world( w:yworld, name:String )
	

		'Print name
		
		w.name = name
		
		w.ye = Self

		worlds.AddFirst w 
		
		
	EndMethod 'add_world
	
	Method change_world( name:String, init = 0 )
	
		w:yworld = Null;
		'Print "change world to "+name
		'find world
		For wt:yworld = EachIn worlds
			'Print  wt.name+" = "+name
			If wt.name = name Then
			
				w = wt
			EndIf
		Next
		'if not found exit
	   If w = Null Then Return
		
		If init = 1 And w <> Null Then
			w.init()
		EndIf

		If current_world Then current_world.hide_all()	
For wt:yworld = EachIn worlds
	wt.hide_all()
Next
		current_world = w

		current_world.show_all()
	
	EndMethod 'change_world
	
	Function Create:yengine()
	
		ye:yengine = New yengine
		Return ye
	
	EndFunction

EndType

Type yworld

	Field mcs:TList =  New TList
	Field name:String, ye:yengine
	
	Method init()
		
		remove_all()
		mcs = New TList
	EndMethod
	
	Method update()
		
		For e:yentity = EachIn mcs
			e.update()
		Next
	EndMethod
	
	Method twodupdate()
		

	EndMethod
	
	Method render()
	
		For e:yentity = EachIn mcs
			e.render()
		Next
		
	EndMethod
	
	Method add( e:yentity )
		
		 e.world = Self
		 e.init()
		
		 mcs.AddFirst e
	EndMethod
		
	Method remove( e:yentity )
		
		 e.remove()
		 mcs.Remove( e )
	EndMethod
	
	Method remove_all()
		
		For e:yentity = EachIn mcs
			remove( e )
		Next
	EndMethod
	
	Method hide_all()
		
		For e:yentity = EachIn mcs
			If e.grafic Then
				bbHideEntity( e.grafic )
			EndIf
		Next
	EndMethod
	
	Method show_all()

		For e:yentity = EachIn mcs
			If e.grafic Then
				bbShowEntity( e.grafic )
			EndIf
		Next
	EndMethod
		
	Function Create:yworld()
	
		yw:yworld = New yworld
		yw.mcs = New TList

		
		Return yw
	
	EndFunction
	
EndType

'test world
	
Type tstw Extends yworld

	Method update()
		
		Super.update()
		
	EndMethod
	
	Method init()
		
		Super.init()
		c =  bbCreateCube()
		add( yentity.Create( 0, 0, 0, c, 2 ) )
	
		ct =  bbCreateCube()
		add( yentity.Create( 0, 0, 2, ct, 2 ) )
	
	EndMethod
	
	Function Create:tstw()
		
		tst:tstw =  New tstw 

		
		Return tst
	
	EndFunction

EndType


Type yentity
	
	Field x:Float, y:Float, z:Float, speed:Float, grafic, ytype:String = "entity", world:yworld, collide_c:Float = 2, fadeOutTimer:ytimer
	
	Method init()
		
		'Print "init entity"
		
		If grafic <> Null Then
		bbPositionEntity grafic, x, y, z
		EndIf 
		fadeOutTimer = ytimer.Create( 0.5 )
		

		
	EndMethod
	
	Method update()
		
		If grafic = Null Then Return
		
	    x = bbEntityX( grafic )
		y = bbEntityY( grafic )	
		z = bbEntityZ( grafic )
		'Print x+"xe"
		'Print y+"ye"
		'Print z+"ze"
		Rem If collide("entity",0,0,1) Then
			Print "hit"
		EndIf
		End Rem
		'If click() Then Print "click"
		
		'If kd(200) Then Print "up"

	
	EndMethod
	
	Method render()
	
		
	EndMethod
	
	Method move_by( mx:Float = 0, my:Float = 0, mz:Float = 0 )
	
		If grafic <> 0 Then bbMoveEntity grafic, mx:Float, my:Float, mz:Float
	
		
		
	EndMethod
	
		
	Method set_pos( mx:Float = 0, my:Float = 0, mz:Float = 0 )
		
		bbPositionEntity grafic, mx:Float, my:Float, mz:Float
		
	EndMethod
	
	Method get_by_type:TList( stype:String )
		
		ret:TList =   New TList
		
		For e:yentity = EachIn world.mcs
			If e.ytype = stype Then
				ret.AddFirst e
			EndIf
		Next
		Return ret
	EndMethod 'get_by_type
	
	Method collide:yentity( stype:String, mx:Float = 0, my:Float = 0, mz:Float = 0 )
		
		dist:Float = 0
		
		tst = bbCreatePivot( grafic )
		bbTranslateEntity tst, mx, my, mz
		es:TList  = get_by_type( stype )
		
		For e:yentity = EachIn es
			dist = bbEntityDistance( tst, e.grafic )
			If dist < collide_c And e <> Self Then
				bbFreeEntity tst
				es.clear()
				Return e
			EndIf
		Next
		bbFreeEntity tst
		es.clear()
		Return Null
	EndMethod 'end collide
	
		
	Method remove()
		
		bbFreeEntity grafic
		grafic = 0
		
	EndMethod ' remove
	
	
			
	Method visable( is )
		
		If is = 0 Then bbHideEntity grafic
		If is = 1 Then bbShowEntity grafic
		 
		
	EndMethod ' remove
	
	Method alpha( a:Float )
	
		bbEntityAlpha grafic, a:Float 
		
	EndMethod 'alpha
	
	Method fadeOut( s:Float )
		
		'every seconds / 1000, reduce alpha by 0.001
	EndMethod
	
		
	Method click( mb )

		bbEntityPickMode grafic, 1
		If bbMouseDown( mb )Then
			picked = bbCameraPick( world.ye.camera, bbMouseX(), bbMouseY() )
			'Print(picked +" "+grafic )
			If picked = grafic Then
				Return True
			EndIf
		EndIf 	
		Return False
		
	EndMethod ' click
	

	
	Method sxyz( mx:Float = 0, my:Float = 0, mz:Float = 0 )
		
		bbPositionEntity grafic, mx, my, mz
	EndMethod
	
	Method sy( v:Float )
	
		bbPositionEntity grafic, bbEntityX( grafic ), v, bbEntityZ( grafic )
		
	EndMethod 'sy
	
	Method printxyz()
		
		 Print x+"xe"
		Print y+"ye"
		Print z+"ze"
	EndMethod
	
	
	Function Create:yentity( x:Float = 0, y:Float = 0, z:Float = 0, grafic:Int = 0, speed:Float = 0 )
		
		e:yentity = New yentity
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "entity"
		Return e
	
	EndFunction

EndType

Type ytimer
	
	Field count, max_count, yfinished
	
	Method finished()
		
		yfinished = False
		count = count+1
		If count >= max_count Then
			count = 0
			yfinished = True
		EndIf
		Return 	yfinished 
	EndMethod
	
	
	Function Create:ytimer( max_count2 = 1 )
		
		t:ytimer = New ytimer
		max_count2 = max_count2 * 60
		t.count = 0
		t.max_count = max_count2
		t.yfinished = 0
		
		Return t
	
	EndFunction
EndType


'//////////////////helper funcs/////////////////////////


Function ycount_filis_in_dir:Int( dirn:String )

	dir = ReadDir( dirn )
	
	c = 0
	
	Repeat
		t:String = NextFile( dir )
		If t = "" Exit
		If t = "." Or t = ".." Continue
		'Print t	
		c = c+1
	Forever
	


	Return c
EndFunction


Function ysign( n )

	If n > 0 Then Return 1
	If n < 0 Then Return -1
	If n = 0 Then Return 0
	

EndFunction

Function ylabs( n )

	If n > 0 Then Return n
	If n < 0 Then Return n*-1
	If n = 0 Then Return 0
	

EndFunction

Function kd( key )

	If bbKeyDown( key ) Then Return True
	
EndFunction 'key down