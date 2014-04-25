package
{
	/*import com.as3nui.nativeExtensions.air.kinect.data.SkeletonJoint;
	import com.as3nui.nativeExtensions.air.kinect.data.Position;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;
	import com.as3nui.nativeExtensions.air.kinect.bridge.ExtensionContextBridge;
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.*;*/
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.ui.MouseCursorData;
	import flash.text.StageText;
	import flash.net.Socket;
	import flash.net.XMLSocket;
	import flash.events.KeyboardEvent;
	import flash.net.SecureSocket;
	import flash.events.*;
	import fl.motion.easing.Back;
	import flash.utils.clearInterval;
	import flash.display.Bitmap; 
	import flash.display.BitmapData; 
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	

	public class MazeClass extends MovieClip
	{
		//var device:Kinect;
		
		var enemy1:Enemy1 = new Enemy1();
		var enemy2:Enemy1 = new Enemy1();
		var enemy3:Enemy1 = new Enemy1();
		
		var enemy4:Enemy1 = new Enemy1();
		var enemy5:Enemy1 = new Enemy1();
		var enemy6:Enemy1 = new Enemy1();
		var enemy7:Enemy1 = new Enemy1();
		
		var enemy8:Enemy1 = new Enemy1();
		var enemy9:Enemy1 = new Enemy1();
		var enemy10:Enemy1 = new Enemy1();
		var enemy11:Enemy1 = new Enemy1();
		
		var movingTimer1:Timer = new Timer(100);
		var movingTimer2:Timer = new Timer(100);
		var hoverTimer:Timer = new Timer(5000, 1);
		var hoverTimer2:Timer = new Timer(5000, 1);
		//public var theHand:RightHand = new RightHand();
		public function MazeClass()
		{
			
		/*	if (Kinect.isSupported())
			{
				device = Kinect.getDevice();
				var settings:KinectSettings = new KinectSettings();
				settings.skeletonEnabled = true; 
				device.start(settings);
			}*/
			
			stage.addEventListener(Event.ENTER_FRAME, theFunction);
				
			function theFunction(event:Event)
			{
				
				if(currentFrame == 2)
				{
					theStart.alpha = .5;
					//device.addEventListener(UserEvent.USERS_UPDATED, userUpdated);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, userUpdated);

					//function userUpdated(e:UserEvent)
					function userUpdated(event:MouseEvent)
					{
						/*if (e.users.length > 0)
						{
							var u:User = e.users[0];
							
							if (u.hasSkeleton)
							{ */
								//theHand.x = u.rightHand.position.world.x;
								//theHand.y = u.rightHand.position.world.y * -1;
								
								theHand.x = mouseX;
								theHand.y = mouseY;
								
								//if(u.rightHand.position.world.x <= 0)
								if(mouseX <= 0)
								{
									theHand.x = 0;
								}
									
								//if(u.rightHand.position.world.x >= 650)
								if(mouseX >= 650)
								{
									theHand.x = 650;
								}
								
								//if(u.rightHand.position.world.y >= -0)
								if(mouseY <= 0)
								{
									theHand.y = 0;
								}
									
								//if(u.rightHand.position.world.y <= -360)
								if(mouseY >= 360)
								{
									theHand.y = 360;
								}
							/*}
						}*/
					}
					
					if(theHand.hitTestObject(theStart) == true)
					{
						theStart.alpha = 1;
						
						if(theStart.alpha == 1)
						{
							//trace("over");
							hoverTimer.start();
							hoverTimer.addEventListener(TimerEvent.TIMER_COMPLETE, hoverHandler);
						
							function hoverHandler(event:TimerEvent)
							{
								gotoAndStop(3);
							}
						}
					}
					
					if(theHand.hitTestObject(theStart) == false)
					{
						//trace("out");
						theStart.alpha = .5;
						
						if(theStart.alpha == .5)
						{
							hoverTimer.stop();
						}
					}
					
					
					//var userName = username.text;
					//var passWord = password.text;
					
					/*loginBtn.buttonMode = true;
					loginBtn.addEventListener(MouseEvent.CLICK, clickHandler);*/
				
					/*function clickHandler(event:MouseEvent)
					{*/
						//Prevents user from starting connection more than once
						
						// XMLSocket is listening at Port 3000
						//socket = new XMLSocket("127.0.0.1", 3000);
						// Further functions being created from here
						//socket.addEventListener(Event.CONNECT, onConnect);
						// The socket is listening for an input/output error
						//socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
						
						//Filtering event listeners once connection is established
						//function onConnect(evt:Event):void
						//{
						//	trace("You're finally connected!!!");
						//	socket.removeEventListener(Event.CONNECT, onConnect);
						//	socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);

						//	socket.addEventListener(DataEvent.DATA, onDataReceived);
						//	socket.addEventListener(Event.CLOSE, onSocketClose);				
						//	stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
						//}
						//		
						//// Closing the server connection	
						//function onSocketClose(evt:Event):void
						//{
						//	trace("Why did you close the connection???");
						//	stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
						//	socket.removeEventListener(Event.CLOSE, onSocketClose);
						//	socket.removeEventListener(DataEvent.DATA, onDataReceived);
						//}
						//				
						//function keyUp(evt:KeyboardEvent):void
						//{
						//	// "Q" kills the server
						//	if (evt.keyCode == 81)
						//	{
						//		socket.send("You killed the server");
						//	}
						//	
						//	// "P" pauses the game
						//	if (evt.keyCode == 80)
						//	{
						//		socket.send("Game is paused");
						//	}
						//	
						//	else
						//	{
						//		// recognizes other keys
						//		socket.send(evt.keyCode);
						//	}
						//}
						//		
						//function onDataReceived(evt:DataEvent):void
						//{
						//	try 
						//	{
						//		trace( "From Server:", evt.data );
						//	}
						//	catch (e:Error) 
						//	{
						//		trace('error');
						//	}
						//}
						//		
						//function onError(evt:IOErrorEvent):void
						//{
						//	trace("You ruined the connection!");
						//	socket.removeEventListener(Event.CONNECT, onConnect);
						//	socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
						//	stage.addEventListener(MouseEvent.CLICK, clickHandler);
						//}
						
						//if(userName == "kinect" && passWord == "1234")
						//{
						//	gotoAndStop(2);
						//	//loginBtn.removeEventListener(MouseEvent.CLICK, clickHandler);
						//}
					//}
				}
				
				if(currentFrame == 3)
				{
					//trace("frame 3");
					//stage.removeEventListener(Event.ENTER_FRAME, theFunction);
					goMaze.alpha = .5;
					//device.addEventListener(UserEvent.USERS_UPDATED, userUpdated2);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, userUpdated2);

					//function userUpdated2(e:UserEvent)
					function userUpdated2(event:MouseEvent)
					{
						/*if (e.users.length > 0)
						{
							var u:User = e.users[0];
							
							if (u.hasSkeleton)
							{*/
								//theHand2.x = u.rightHand.position.world.x;
								//theHand2.y = u.rightHand.position.world.y * -1;
								
								theHand2.x = mouseX;
								theHand2.y = mouseY;
								
								//if(u.rightHand.position.world.x <= 0)
								if(mouseX <= 0)
								{
									theHand2.x = 0;
								}
									
								//if(u.rightHand.position.world.x >= 650)
								if(mouseX >= 650)
								{
									theHand2.x = 650;
								}
								
								//if(u.rightHand.position.world.y >= -0)
								if(mouseY <= 0)
								{
									theHand2.y = 0;
								}
									
								//if(u.rightHand.position.world.y <= -360)
								if(mouseY >= 360)
								{
									theHand2.y = 360;
								}
							/*}
						}*/
					}
					
					if(goMaze.hitTestObject(theHand2) == true)
					{
						goMaze.alpha = 1;
						
						if(goMaze.alpha == 1)
						{
							//trace("over");
							hoverTimer2.start();
							hoverTimer2.addEventListener(TimerEvent.TIMER_COMPLETE, hoverHandler2);;
						
							function hoverHandler2(event:TimerEvent)
							{
								gotoAndStop(4);
							}
						}
					}
					
					if(goMaze.hitTestObject(theHand2) == false)
					{
						//trace("out");
						goMaze.alpha = .5;
						
						if(goMaze.alpha == .5)
						{
							hoverTimer2.stop();
						}
					}
				}

				if(currentFrame == 4)
				{
					removeChild(theHand2);
					stage.removeEventListener(Event.ENTER_FRAME, theFunction);
					
					//if(
					//var myBitmapDataObject:MazeBack1 = new MazeBack1();
					//device.addEventListener(UserEvent.USERS_UPDATED, userUpdated3);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, userUpdated3);
					
					//function userUpdated3(event:UserEvent)
					function userUpdated3(event:MouseEvent)
					{
						/*if (e.users.length > 0)
						{
							var u:User = e.users[0];
							
							if (u.hasSkeleton)
							{*/
								//character1.x = u.rightHand.position.world.x;
								//character1.y = u.rightHand.position.world.y * -1;
								
								//var bmd1:BitmapData = new BitmapData(100, 100, false, Maze);
								
								character1.x = mouseX;
								character1.y = mouseY;
						
								
								/*if(myBitmapDataObject.hitTestPoint(character1) == true)
								{
									trace("hitting");
								}*/
								
								//if(u.rightHand.position.world.x <= 0)
								if(mouseX <= 15)
								{
									character1.x = 15;
								}
									
								//if(u.rightHand.position.world.x >= 650)
								if(mouseX >= 680)
								{
									character1.x = 680;
								}
								
								//if(u.rightHand.position.world.y >= -0)
								if(mouseY <= 50)
								{
									character1.y = 50;
								}
									
								//if(u.rightHand.position.world.y <= -360)
								if(mouseY >= 375)
								{
									character1.y = 375;
								}
							//}
								/*if(character.x == Bitmap(Maze.png))
								{
									trace("hit2");
								}*/
							/*}*/
					}
				
					// Setup an XMLSocket
					//var socket:XMLSocket;

					// Scoring updates
					//var betweenLives:Boolean;
					var livesArray:Array = new Array();
					livesArray.push(one, two, three, four);
					var lives:int = 5;
					//var score:int = 0;
				
					//The Score Board
					var score:int = 0;

					var myTextField:TextField = new TextField();
					myTextField.backgroundColor = 0xFFFFFF;
					myTextField.height = 20;
					myTextField.width = 100;
					myTextField.background = true; 
					myTextField.x = 180;
					myTextField.y = 30;
					myTextField.text = "SCORE: " + String(score); 
					stage.addChild(myTextField);
					
					enemy1.moveSkull = 2;
					enemy2.moveSkull = 1.4;
					enemy3.moveSkull = 2.9;
					
					stage.addChild(enemy1);
					enemy1.x = 173;
					enemy1.y = 125;
					enemy1.scaleX = +.025;
					enemy1.scaleY = +.025;
					
					stage.addChild(enemy2);
					enemy2.x = 380;
					enemy2.y = 210;
					enemy2.scaleX = +.025;
					enemy2.scaleY = +.025;
					
					stage.addChild(enemy3);
					enemy3.x = 582;
					enemy3.y = 340;
					enemy3.scaleX = +.025;
					enemy3.scaleY = +.025;
					
					movingTimer1.start();
					movingTimer1.addEventListener(TimerEvent.TIMER, handler1);
					movingTimer2.addEventListener(TimerEvent.TIMER, handler2);
					
					function handler1(event:TimerEvent)
					{
						if(enemy1.x <= 115)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy2.y >= 250)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy3.x <= 483)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						else
						{
							enemy1.x -= enemy1.moveSkull;
							enemy1.scaleX = +.025;
							enemy1.scaleY = +.025;
						
							enemy2.y += enemy2.moveSkull;;
							enemy2.scaleX = +.025;
							enemy2.scaleY = +.025;
						
							enemy3.x -= enemy3.moveSkull;;
							enemy3.scaleX = +.025;
							enemy3.scaleY = +.025;
						}
					}
					
					function handler2(event:TimerEvent)
					{
						if(enemy1.x >= 173)
						{
							movingTimer2.stop();
							movingTimer1.start();
							
						}
						
						if(enemy2.y <= 210)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						if(enemy3.x >= 582)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						else
						{
							enemy1.x += enemy1.moveSkull;
							enemy1.scaleX = -.025;
							
							enemy2.y -= enemy2.moveSkull;
							enemy2.scaleX = -.025;
							
							enemy3.x += enemy3.moveSkull;
							enemy3.scaleX = -.025;
						}
					}
				
					stage.addEventListener(Event.ENTER_FRAME, collisionHandler);
				
					function collisionHandler(event:Event)
					{
						//var theMazeback:MazeBack1;
						//var myBitmapDataObject:MazeBack1 = new MazeBack1(100, 100);
						
						
						if(goal.hitTestObject(character1) == true) 
						{
							gotoAndStop(5);
							stage.removeChild(enemy1);
							stage.removeChild(enemy2);
							stage.removeChild(enemy3);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER, handler1);
							movingTimer2.removeEventListener(TimerEvent.TIMER, handler2);
							stage.removeEventListener(Event.ENTER_FRAME, collisionHandler);
							stage.addEventListener(Event.ENTER_FRAME, theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE, userUpdated3);
							stage.removeChild(myTextField);

						}
						
						else
						{
							for(var j:int = 0; j<livesArray.length; j++)
							{
								if(character1.hitTestObject(enemy1))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy2))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy3))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
								}
								
								if(livesArray.length <= 0)
								{
									trace("Game Over!!!");
								}
								
							}
							//if(enemy1.hitTestObject(character1))
							//{
							//	trace("One Life Gone");
							//	
							//	if(livesArray[two].splice == true)
							//	{
							//		livesArray.splice(three);
							//	}
							//	
							//	if(livesArray[three].splice == true)
							//	{
							//		livesArray.splice(four);
							//	}
							//	
							//	if(livesArray[four].splice == true)
							//	{
							//		trace("game over!!!!!!");
							//	}
							//	//trace("Lives:" + lives --);
							//}
							
							//Collecting the bonus coin
							if(bonus.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus);
								removeChild(gate);
								score++;
								myTextField.text = "SCORE: " + String(score);
							}
							
							if(coin.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin);
								score++;
								myTextField.text = "SCORE: " + String(score);
							}
							
							if(secondCoin.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(secondCoin);
								score++;
								myTextField.text = "SCORE: " + String(score);
							}
							
							if(thirdCoin.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(thirdCoin);
								score++;
								myTextField.text = "SCORE: " + String(score);
							}
						}
					}
					//function changePlayer():void 
					//{
					//	// character dead
					//	//betweenLives = true;
					//	trace(" still dead ");
					//}

					// Game has ended
					//function gameOver():void 
					//{
					//	//stage.removeEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
					//	//stage.removeEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
					//	//stage.removeEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
					//	//gotoAndStop(3);
					//}
				}
				
				if(currentFrame == 5)
				{
					//trace("frame 5");
					stage.removeEventListener(Event.ENTER_FRAME, theFunction);
					//stage.removeChild(character1);

					
					//device.removeEventListener(UserEvent.USERS_UPDATED, userUpdated3);
					
					
					
					//device.addEventListener(UserEvent.USERS_UPDATED, userUpdated4);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, userUpdated4);

					//function userUpdated4(e:UserEvent)
					function userUpdated4(event:MouseEvent)
					{
						/*if (e.users.length > 0)
						{
							var u:User = e.users[0];
							
							if (u.hasSkeleton)
							{*/
								//character2.x = u.rightHand.position.world.x;
								//character2.y = u.rightHand.position.world.y * -1;
								
								character1.x = mouseX;
								character1.y = mouseY;
								
								//if(u.rightHand.position.world.x <= 0)
								if(mouseX <= 0)
								{
									character1.x = 0;
								}
									
								//if(u.rightHand.position.world.x >= 650)
								if(mouseX >= 670)
								{
									character1.x = 670;
								}
								
								//if(u.rightHand.position.world.y >= -0)
								if(mouseY <= 0)
								{
									character1.y = 0;
								}
									
								//if(u.rightHand.position.world.y <= -360)
								if(mouseY >= 360)
								{
									character1.y = 360;
								}
							/*}
						}*/
					}
					
					var livesArray2:Array = new Array(one1, two2, three3, four4);
					var lives2:int = 5;
					//var score:int = 0;
				
					//The Score Board
					var score2:int = 0;

					var myTextField2:TextField = new TextField();
					myTextField2.backgroundColor = 0xFFFFFF;
					myTextField2.height = 20;
					myTextField2.width = 100;
					myTextField2.background = true; 
					myTextField2.x = 180;
					myTextField2.y = 30;
					myTextField2.text = "SCORE: " + String(score2); 
					stage.addChild(myTextField2);
					
					enemy4.moveSkull = 2;
					enemy5.moveSkull = 2.5;
					enemy6.moveSkull = 2;
					enemy7.moveSkull = 2.4;
					
					stage.addChild(enemy4);
					enemy4.x = 115;
					enemy4.y = 150;
					enemy4.scaleX = +.025;
					enemy4.scaleY = +.025;
					
					stage.addChild(enemy5);
					enemy5.x = 405;
					enemy5.y = 295;
					enemy5.scaleX = +.025;
					enemy5.scaleY = +.025;
					
					stage.addChild(enemy6);
					enemy6.x = 660;
					enemy6.y = 235;
					enemy6.scaleX = +.025;
					enemy6.scaleY = +.025;
					
					stage.addChild(enemy7);
					enemy7.x = 335;
					enemy7.y = 170;
					enemy7.scaleX = +.025;
					enemy7.scaleY = +.025;
					
					movingTimer1.start();
					movingTimer1.addEventListener(TimerEvent.TIMER, handler3);
					movingTimer2.addEventListener(TimerEvent.TIMER, handler4);
					
					function handler3(event:TimerEvent)
					{
						if(enemy4.x <= 45)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy5.x <= 295)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy6.x <= 580)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy7.x <= 245)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						else
						{
							enemy4.x -= enemy4.moveSkull;
							enemy4.scaleX = +.025;
						
							enemy5.x -= enemy5.moveSkull;;
							enemy5.scaleX = +.025;
						
							enemy6.x -= enemy6.moveSkull;;
							enemy6.scaleX = +.025;
							
							enemy7.x -= enemy7.moveSkull;;
							enemy7.scaleX = +.025;
						}
					}
					
					function handler4(event:TimerEvent)
					{
						if(enemy4.x >= 155)
						{
							movingTimer2.stop();
							movingTimer1.start();
							
						}
						
						if(enemy5.x >= 405)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						if(enemy6.x >= 660)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						if(enemy7.x >= 335)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						else
						{
							enemy4.x += enemy4.moveSkull;
							enemy4.scaleX = -.025;
							
							enemy5.x += enemy5.moveSkull;
							enemy5.scaleX = -.025;
							
							enemy6.x += enemy6.moveSkull;
							enemy6.scaleX = -.025;
							
							enemy7.x += enemy7.moveSkull;
							enemy7.scaleX = -.025;
						}
					}
					
					stage.addEventListener(Event.ENTER_FRAME, collisionHandler2);
				
					function collisionHandler2(event:Event)
					{
						//var theMazeback:MazeBack1;
						//var myBitmapDataObject:MazeBack1 = new MazeBack1(100, 100);
						
						
						if(theParrot.hitTestObject(character1) == true) 
						{
							gotoAndStop(6);
							stage.removeChild(enemy4);
							stage.removeChild(enemy5);
							stage.removeChild(enemy6);
							stage.removeChild(enemy7);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER, handler3);
							movingTimer2.removeEventListener(TimerEvent.TIMER, handler4);
							stage.removeEventListener(Event.ENTER_FRAME, collisionHandler2);
							stage.addEventListener(Event.ENTER_FRAME, theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE, userUpdated4);
							removeChild(character1);
							stage.removeChild(myTextField2);
						}
						
						else
						{
							for(var j:int = 0; j<livesArray2.length; j++)
							{
								if(character1.hitTestObject(enemy4))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy5))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy6))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy7))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
								}
								
								if(livesArray2.length <= 0)
								{
									trace("Game Over!!!");
								}
								
							}
							//if(enemy1.hitTestObject(character1))
							//{
							//	trace("One Life Gone");
							//	
							//	if(livesArray[two].splice == true)
							//	{
							//		livesArray.splice(three);
							//	}
							//	
							//	if(livesArray[three].splice == true)
							//	{
							//		livesArray.splice(four);
							//	}
							//	
							//	if(livesArray[four].splice == true)
							//	{
							//		trace("game over!!!!!!");
							//	}
							//	//trace("Lives:" + lives --);
							//}
							
							//Collecting the bonus coin
							if(bonus1.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus1);
								//removeChild(gate);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(bonus2.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus2);
								//removeChild(gate);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin1.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin1);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin2.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin2);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin3.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin3);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin4.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin4);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin5.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin5);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin6.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin6);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
							
							if(coin7.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin7);
								score2++;
								myTextField2.text = "SCORE: " + String(score2);
							}
						}
					}
					
					/*if(goMaze.hitTestObject(theHand2))
					{
						hoverTimer2.start();
						hoverTimer2.addEventListener(TimerEvent.TIMER_COMPLETE, hoverHandler2);
						
						function hoverHandler2(event:TimerEvent)
						{
							gotoAndStop(4);	
						}
						
						
					}*/
				}
				
				
					//stage.removeChild(character1);

					
					//device.removeEventListener(UserEvent.USERS_UPDATED, userUpdated3);
					
				if(currentFrame == 6)
				{
					stage.removeEventListener(Event.ENTER_FRAME, theFunction);
					//device.addEventListener(UserEvent.USERS_UPDATED, userUpdated4);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, userUpdated5);

					//function userUpdated4(e:UserEvent)
					function userUpdated5(event:MouseEvent)
					{
						/*if (e.users.length > 0)
						{
							var u:User = e.users[0];
							
							if (u.hasSkeleton)
							{*/
								//character2.x = u.rightHand.position.world.x;
								//character2.y = u.rightHand.position.world.y * -1;
								stage.addChild(character1);
								character1.x = mouseX;
								character1.y = mouseY;
								
								//if(u.rightHand.position.world.x <= 0)
								if(mouseX <= 0)
								{
									character1.x = 0;
								}
									
								//if(u.rightHand.position.world.x >= 650)
								if(mouseX >= 670)
								{
									character1.x = 670;
								}
								
								//if(u.rightHand.position.world.y >= -0)
								if(mouseY <= 0)
								{
									character1.y = 0;
								}
									
								//if(u.rightHand.position.world.y <= -360)
								if(mouseY >= 360)
								{
									character1.y = 360;
								}
							/*}
						}*/
					}
					
					var livesArray3:Array = new Array(oneOne, twoTwo, threeThree, fourFour);
					var lives3:int = 5;
					//var score:int = 0;
				
					//The Score Board
					var score3:int = 0;

					var myTextField3:TextField = new TextField();
					myTextField3.backgroundColor = 0xFFFFFF;
					myTextField3.height = 20;
					myTextField3.width = 100;
					myTextField3.background = true; 
					myTextField3.x = 180;
					myTextField3.y = 30;
					myTextField3.text = "SCORE: " + String(score3); 
					stage.addChild(myTextField3);
					
					enemy8.moveSkull = 2;
					enemy9.moveSkull = 2.5;
					enemy10.moveSkull = 2;
					enemy11.moveSkull = 2.4;
					
					stage.addChild(enemy8);
					enemy8.x = 115;
					enemy8.y = 270;
					enemy8.scaleX = +.025;
					enemy8.scaleY = +.025;
					
					stage.addChild(enemy9);
					enemy9.x = 405;
					enemy9.y = 295;
					enemy9.scaleX = +.025;
					enemy9.scaleY = +.025;
					
					stage.addChild(enemy10);
					enemy10.x = 660;
					enemy10.y = 255;
					enemy10.scaleX = +.025;
					enemy10.scaleY = +.025;
					
					stage.addChild(enemy11);
					enemy11.x = 335;
					enemy11.y = 170;
					enemy11.scaleX = +.025;
					enemy11.scaleY = +.025;
					
					movingTimer1.start();
					movingTimer1.addEventListener(TimerEvent.TIMER, handler5);
					movingTimer2.addEventListener(TimerEvent.TIMER, handler6);
					
					function handler5(event:TimerEvent)
					{
						if(enemy8.x <= 45)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy9.x <= 295)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy10.x <= 580)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						if(enemy11.x <= 245)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						
						else
						{
							enemy8.x -= enemy8.moveSkull;
							enemy8.scaleX = +.025;
						
							enemy9.x -= enemy9.moveSkull;;
							enemy9.scaleX = +.025;
						
							enemy10.x -= enemy10.moveSkull;;
							enemy10.scaleX = +.025;
							
							enemy11.x -= enemy11.moveSkull;;
							enemy11.scaleX = +.025;
						}
					}
					
					function handler6(event:TimerEvent)
					{
						if(enemy8.x >= 155)
						{
							movingTimer2.stop();
							movingTimer1.start();
							
						}
						
						if(enemy9.x >= 405)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						if(enemy10.x >= 660)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						if(enemy11.x >= 335)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						
						else
						{
							enemy8.x += enemy8.moveSkull;
							enemy8.scaleX = -.025;
							
							enemy9.x += enemy9.moveSkull;
							enemy9.scaleX = -.025;
							
							enemy10.x += enemy10.moveSkull;
							enemy10.scaleX = -.025;
							
							enemy11.x += enemy11.moveSkull;
							enemy11.scaleX = -.025;
						}
					}
					
					stage.addEventListener(Event.ENTER_FRAME, collisionHandler3);
				
					function collisionHandler3(event:Event)
					{
						//var theMazeback:MazeBack1;
						//var myBitmapDataObject:MazeBack1 = new MazeBack1(100, 100);
						
						
						if(goal2.hitTestObject(character1) == true) 
						{
							gotoAndStop(3);
							stage.removeChild(enemy8);
							stage.removeChild(enemy9);
							stage.removeChild(enemy10);
							stage.removeChild(enemy11);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER, handler5);
							movingTimer2.removeEventListener(TimerEvent.TIMER, handler6);
							stage.removeEventListener(Event.ENTER_FRAME, collisionHandler3);
							stage.addEventListener(Event.ENTER_FRAME, theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE, userUpdated5);
							stage.removeChild(character1);
							stage.removeChild(myTextField3);
						}
						
						else
						{
							for(var j:int = 0; j<livesArray3.length; j++)
							{
								if(character1.hitTestObject(enemy8))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy9))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy10))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
								}
								
								if(character1.hitTestObject(enemy11))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
								}
								
								if(livesArray3.length <= 0)
								{
									trace("Game Over!!!");
								}
								
							}
							//if(enemy1.hitTestObject(character1))
							//{
							//	trace("One Life Gone");
							//	
							//	if(livesArray[two].splice == true)
							//	{
							//		livesArray.splice(three);
							//	}
							//	
							//	if(livesArray[three].splice == true)
							//	{
							//		livesArray.splice(four);
							//	}
							//	
							//	if(livesArray[four].splice == true)
							//	{
							//		trace("game over!!!!!!");
							//	}
							//	//trace("Lives:" + lives --);
							//}
							
							//Collecting the bonus coin
							if(bonus4.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus4);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus5.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus5);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus6.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus6);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus7.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus7);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus8.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus8);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus9.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus9);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(bonus10.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(bonus10);
								//removeChild(gate);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin1c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin1c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin2c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin2c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin3c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin3c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin4c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin4c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin5c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin5c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin6c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin6c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin7c.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin7c);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin8.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin8);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin9.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin9);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin10.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin10);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin11.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin11);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin12.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin12);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin13.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin13);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin14.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin14);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin15.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin15);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin16.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin16);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin17.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin17);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin18.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin18);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin19.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin19);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin20.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin20);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
							
							if(coin21.hitTestObject(character1)) 
							{
								trace("bonus points scored");
								removeChild(coin21);
								score3++;
								myTextField3.text = "SCORE: " + String(score3);
							}
						}
					}
				}
			}
		}
	}
}