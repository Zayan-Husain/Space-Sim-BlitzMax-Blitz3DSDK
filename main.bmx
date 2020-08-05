
Import blitz3d.blitz3dsdk

Include "yengine.bmx"

Include "game_world.bmx"
Include "win_world.bmx"
Include "game_over.bmx"
Include "start_screen.bmx"

Include "player.bmx"
Include "enemy.bmx"
Include "bullet.bmx"



'//////init blitz3d//////
bbBeginBlitz3D
		
bbGraphics3D 800, 600, 0, 2
'///////set window title/////
Global  info1:String = "yengine"
If info1:String <> ""
	bbSetBlitz3DTitle info1:String, "Exit "+info1:String+" ?"
EndIf



'//start engine
Global ye:yengine = yengine.Create()

start = start_screen.Create()


tst:game_world  = game_world.Create()


winw =  win_world.Create()

_game_over = game_over.Create()

ye.add_world( start, "start_screen" )
ye.add_world( tst, "game_world" )
ye.add_world( winw, "win_world" )
ye.add_world( _game_over, "game_over" )

ye.change_world( "start_screen" )



ye.init()