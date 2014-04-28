package 
{
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
	import flash.text.TextFormat;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.TextField;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import fl.motion.easing.Linear;
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
		var enemy1:Enemy1 = new Enemy1  ;
		var enemy2:Enemy1 = new Enemy1  ;
		var enemy3:Enemy1 = new Enemy1  ;

		var enemy4:Enemy1 = new Enemy1  ;
		var enemy5:Enemy1 = new Enemy1  ;
		var enemy6:Enemy1 = new Enemy1  ;
		var enemy7:Enemy1 = new Enemy1  ;

		var enemy8:Enemy1 = new Enemy1  ;
		var enemy9:Enemy1 = new Enemy1  ;
		var enemy10:Enemy1 = new Enemy1  ;
		var enemy11:Enemy1 = new Enemy1  ;

		var movingTimer1:Timer = new Timer(100);
		var movingTimer2:Timer = new Timer(100);

		var hoverTimer:Timer = new Timer(3000,1);
		var hoverTimer2:Timer = new Timer(2500, 1);
		var hoverTimer3:Timer = new Timer(2500, 1);

		var score4:int = 0;
		var grannyTimer:Timer = new Timer(15,830);
		var moveBoxTimer:Timer = new Timer(10);
		var reFoggingTimer:Timer = new Timer(5000,1);
		var timeLeft:Timer = new Timer(1000, 30);
		
		public static var playerName:String;
		public static var SOuname:String;
		public static var nameSet:int;
		public static var scoreSet:int;

		public static var scoring:int;

		public static var arrScoresSet:Array;
		public static var scores:Object;
		public static var scoreBoard:ScoreBoard = new ScoreBoard();
		public static var scoreBoard2:ScoreBoard = new ScoreBoard();
		public static var scoreBoard3:ScoreBoard = new ScoreBoard();
		public static var btnHome:HomeButton = new HomeButton();
		public static var btnNext:NextButton = new NextButton();
		public static var btnBack:BackButton = new BackButton();
		public static var isClicked:Boolean = false;

		public var storeScoreArray:Array = new Array();
		public var mySO:SharedObject;
		
		var mySound6:Sound = new Sound();
		var myChannel6:SoundChannel = new SoundChannel();
		var mySound9:Sound = new Sound();
		var myChannel9:SoundChannel = new SoundChannel();
		var mySound8:Sound = new Sound();
		var myChannel8:SoundChannel = new SoundChannel();
		var mySound7:Sound = new Sound();
		var myChannel7:SoundChannel = new SoundChannel();
		
		var channelTimer:Timer = new Timer(1,1);

		public function MazeClass()
		{
			
			var socket:XMLSocket;
			stage.addEventListener(MouseEvent.CLICK, doConnect);
		
			playerName = "Player1";

			scoring = 0;
			trace(scoring + ": scoring");
			scores = {};
			mySO = SharedObject.getLocal("maze1");
			
			arrScoresSet = [scores["user1"] = {score:10,uname:"martin"},scores["user2"] = {score:9,uname:"harry"},scores["user3"] = {score:8,uname:"mike"},scores["user4"] = {score:7,uname:"jane"},scores["user5"] = {score:6,uname:"mary"},scores["user6"] = {score:5,uname:"Rolf"},scores["user7"] = {score:4,uname:"James"},scores["user8"] = {score:3,uname:"Sinead"},scores["user9"] = {score:2,uname:"Bob"},scores["user10"] = {score:1,uname:"Frank"}];

			arrScoresSet = arrScoresSet.sortOn("score",Array.DESCENDING | Array.NUMERIC);
			for each (var value in arrScoresSet)
			{
				trace(value.score + " " + value.uname);
			}

			trace(("score: " + scores["user1"].score));

			scoreSet = 0;
			trace(("3. Name is: " + playerName));
			
			if ((nameSet == 1))
			{
				trace(("4. Name is: " + playerName));
			}

			btnHome.addEventListener(MouseEvent.CLICK,homePress);
			btnNext.addEventListener(MouseEvent.CLICK,nextPress);
			btnBack.addEventListener(MouseEvent.CLICK,backPress);

			function doConnect(evt:Event):void
			{
				stage.removeEventListener(MouseEvent.CLICK, doConnect);
				socket = new XMLSocket("127.0.0.1",9001);
				socket.addEventListener(Event.CONNECT, onConnect);
				socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			}

			function onConnect(evt:Event):void
			{
				trace("Connected to the server");
				socket.removeEventListener(Event.CONNECT, onConnect);
				socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				socket.addEventListener(DataEvent.DATA, onDataReceived);
				socket.addEventListener(Event.CLOSE, onSocketClose);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			}

			function onSocketClose(evt:Event):void
			{
				trace("Connection Closed");
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				socket.removeEventListener(Event.CLOSE, onSocketClose);
				socket.removeEventListener(DataEvent.DATA, onDataReceived);
			}

			function keyUp(evt:KeyboardEvent):void
			{
				if (evt.keyCode == 81)
				{
					socket.send("exit");
				}
				else
				{
					socket.send(evt.keyCode);
				}
			}

			function onDataReceived(evt:DataEvent):void
			{
				try
				{
					trace( "From Server:", evt.data );
				}

				catch (e:Error)
				{
					trace('error');
				}
			}

			function onError(evt:IOErrorEvent):void
			{
				trace("Connect failed");
				socket.removeEventListener(Event.CONNECT, onConnect);
				socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
				stage.addEventListener(MouseEvent.CLICK, doConnect);
			}

			function sortScoreBoard()
			{
				arrScoresSet = arrScoresSet.sortOn("score",Array.DESCENDING | Array.NUMERIC);
				trace(("0. contents is : " + mySO.data.contents));

				for each (var value in arrScoresSet)
				{
					trace(value.score + " " + value.uname);
				}
			}

			function level1Comp()
			{
				trace("hello level 1 comp.");
				trace(("score is: " + scoreSet));

				trace(("score: " + scores["user1"].score));
				trace(("name: " + scores["user1"].uname));

				updateScoreBoard();
			}

			function showScoreBoard()
			{
				gotoAndStop(4);
			}

			function homePress(e:Event):void
			{
				trace("Home Button Clicked");
				trace("uname: ");
				gotoAndStop(3);
			}

			function backPress(e:Event):void
			{
				isClicked = false;
				trace("Back Button Clicked");
				trace("uname: ");

				SOuname = mySO.data.userName;

				scoreBoard.visible = true;
				scoreBoard2.visible = false;

				scoreBoard.addChild(btnHome);
				trace(SOuname);
			}

			function nextPress(e:Event):void
			{
				isClicked = true;

				scoreBoard2.visible = true;
				scoreBoard.visible = false;
				
				var name6:TextField = new TextField  ;
				var name7:TextField = new TextField  ;
				var name8:TextField = new TextField  ;
				var name9:TextField = new TextField  ;
				var name10:TextField = new TextField  ;
				var score6:TextField = new TextField  ;
				var score7:TextField = new TextField  ;
				var score8:TextField = new TextField  ;
				var score9:TextField = new TextField  ;
				var score10:TextField = new TextField  ;
				var labela:TextField = new TextField  ;
				var labelb:TextField = new TextField  ;
				var labelc:TextField = new TextField  ;
				var labeld:TextField = new TextField  ;
				var labele:TextField = new TextField  ;
				var labelf:TextField = new TextField  ;
				var labelg:TextField = new TextField  ;

				stage.addChild(scoreBoard2);
				scoreBoard2.addChild(btnHome);
				scoreBoard2.addChild(btnBack);

				scoreBoard2.addChild(name6);
				scoreBoard2.addChild(name7);
				scoreBoard2.addChild(name8);
				scoreBoard2.addChild(name9);
				scoreBoard2.addChild(name10);

				scoreBoard2.addChild(score6);
				scoreBoard2.addChild(score7);
				scoreBoard2.addChild(score8);
				scoreBoard2.addChild(score9);
				scoreBoard2.addChild(score10);

				scoreBoard2.addChild(labela);
				scoreBoard2.addChild(labelb);
				scoreBoard2.addChild(labelc);
				scoreBoard2.addChild(labeld);
				scoreBoard2.addChild(labele);
				scoreBoard2.addChild(labelf);
				scoreBoard2.addChild(labelg);

				trace("Next Button Clicked");

				var myFormat:TextFormat = new TextFormat  ;
				myFormat.size = 15;
				myFormat.color = 0xFFFFFF;
				myFormat.font = "Myriad Pro";
				myFormat.bold = true;

				labela.defaultTextFormat = labelb.defaultTextFormat = labelc.defaultTextFormat = labeld.defaultTextFormat = labele.defaultTextFormat = labelf.defaultTextFormat = labelg.defaultTextFormat = myFormat;

				name6.defaultTextFormat = myFormat;
				name7.defaultTextFormat = myFormat;
				name8.defaultTextFormat = myFormat;
				name9.defaultTextFormat = myFormat;
				name10.defaultTextFormat = myFormat;

				score6.defaultTextFormat = myFormat;
				score7.defaultTextFormat = myFormat;
				score8.defaultTextFormat = myFormat;

				score9.defaultTextFormat = myFormat;
				score10.defaultTextFormat = myFormat;

				labela.text = '' + '6';
				labelb.text = '' + '7';
				labelc.text = '' + '8';
				labeld.text = '' + '9';
				labele.text = '' + '10';
				labelf.text = '' + 'Name';
				labelg.text = '' + 'Score';

				name6.text = '' + scores["user6"].uname;
				name7.text = '' + scores["user7"].uname;
				name8.text = '' + scores["user8"].uname;
				name9.text = '' + scores["user9"].uname;
				name10.text = '' + scores["user10"].uname;

				score6.text = '' + scores["user6"].score;
				score7.text = '' + scores["user7"].score;
				score8.text = '' + scores["user8"].score;
				score9.text = '' + scores["user9"].score;
				score10.text = '' + scores["user10"].score;

				name6.width = name7.width = name8.width = name9.width = name10.width = score6.width = score7.width = score8.width = score9.width = score10.width = 107;

				name6.height = name7.height = name8.height = name9.height = name10.height = score6.height = score7.height = score8.height = score9.height = score10.height = 27.35;

				name6.x = name7.x = name8.x = name9.x = name10.x = 280;

				score6.x = score7.x = score8.x = score9.x = score10.x = 400;

				labelf.x = 280;
				labelg.x = 400;

				labela.x = 250;
				labelb.x = labela.x;
				labelc.x = labelb.x;
				labeld.x = labelc.x;
				labele.x = labeld.x;

				labelf.y = 100;
				labelg.y = 100;

				labela.y = 125;
				labelb.y = 160;
				labelc.y = 200;
				labeld.y = 235;
				labele.y = 270;

				name6.y = 125;
				name7.y = 160;
				name8.y = 200;
				name9.y = 235;
				name10.y = 270;

				score6.y = 125;
				score7.y = 160;
				score8.y = 200;
				score9.y = 235;
				score10.y = 270;

				btnHome.x = 180;
				btnHome.y = 320;

				btnBack.x = 380;
				btnBack.y = 320;
			}

			function updateScoreBoard()
			{
				playerName = playerName.toUpperCase();
				trace("ScoreBoard");

				scoreSet = scoreSet + 0;
				scoreSet = scoring;
				trace(scoring + ": scoring");

				if ((scoreSet >= scores["user1"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scores["user5"].score;
					scores["user5"].score = scores["user4"].score;
					scores["user4"].score = scores["user3"].score;
					scores["user3"].score = scores["user2"].score;
					scores["user2"].score = scores["user1"].score;
					scores["user1"].score = scoreSet;
					scores["user1"].uname = playerName;
					trace(((("score is here Position 1: " + scores["user1"].score) + " ") + scores["user1"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user2"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scores["user5"].score;
					scores["user5"].score = scores["user4"].score;
					scores["user4"].score = scores["user3"].score;
					scores["user3"].score = scores["user2"].score;
					scores["user2"].score = scoreSet;
					scores["user2"].uname = playerName;
					trace(((("score is here Position 2: " + scores["user2"].score) + " ") + scores["user2"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user3"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scores["user5"].score;
					scores["user5"].score = scores["user4"].score;
					scores["user4"].score = scores["user3"].score;
					scores["user3"].score = scoreSet;
					scores["user3"].uname = playerName;
					trace(((("score is here Position 3: " + scores["user3"].score) + " ") + scores["user3"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user4"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scores["user5"].score;
					scores["user5"].score = scores["user4"].score;
					scores["user4"].score = scoreSet;
					scores["user4"].uname = playerName;
					trace(((("score is here Position 4: " + scores["user4"].score) + " ") + scores["user4"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user5"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scores["user5"].score;
					scores["user5"].score = scoreSet;
					scores["user5"].uname = playerName;
					trace(((("score is here Position 5: " + scores["user5"].score) + " ") + scores["user5"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user6"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user6"].score = scoreSet;
					scores["user6"].uname = playerName;
					trace(((("score is here Position 6: " + scores["user6"].score) + " ") + scores["user6"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user7"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user7"].score = scores["user6"].score;
					scores["user7"].score = scoreSet;
					scores["user7"].uname = playerName;
					trace(((("score is here Position 7: " + scores["user7"].score) + " ") + scores["user7"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user8"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user8"].score = scores["user7"].score;
					scores["user8"].score = scoreSet;
					scores["user8"].uname = playerName;
					trace(((("score is here Position 8: " + scores["user8"].score) + " ") + scores["user8"].uname));
					sortScoreBoard();
				}
			
				else if ((scoreSet >= scores["user9"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user9"].score = scores["user8"].score;
					scores["user9"].score = scoreSet;
					scores["user9"].uname = playerName;
					trace(((("score is here Position 9: " + scores["user9"].score) + " ") + scores["user9"].uname));
					sortScoreBoard();
				}
		
				else if ((scoreSet >= scores["user10"].score))
				{
					scores["user10"].score = scores["user9"].score;
					scores["user10"].score = scoreSet;
					scores["user10"].uname = playerName;
					trace(((("score is here Position 10: " + scores["user10"].score) + " ") + scores["user10"].uname));
					sortScoreBoard();
				}
			
				else
				{
					trace("something wrong");
					sortScoreBoard();
				}

				// store values on file from variables
				mySO.data.userName = playerName;
				mySO.data.userScore = scoreSet;
				mySO.data.itemNumbers = storeScoreArray;
				mySO.data.content1a = arrScoresSet[0].uname;
				mySO.data.contents = arrScoresSet;
				mySO.data.content1b = arrScoresSet[0].score;
				mySO.flush();

				trace("end");

				trace("sbscreen1");
				// format text for scoreboard
				var myFormat:TextFormat = new TextFormat  ;
				myFormat.size = 15;
				myFormat.color = 0xFFFFFF;
				myFormat.font = "Myriad Pro";
				myFormat.bold = true;

				stage.addChild(scoreBoard);

				trace(("clicked? : " + isClicked));
				if (isClicked)
				{
					trace("IsClicked true");
				}
				scoreBoard.addChild(btnHome);
				scoreBoard.addChild(btnNext);

				var name1:TextField = new TextField  ;
				var name2:TextField = new TextField  ;
				var name3:TextField = new TextField  ;
				var name4:TextField = new TextField  ;
				var name5:TextField = new TextField  ;

				var score1:TextField = new TextField  ;
				var score2:TextField = new TextField  ;
				var score3:TextField = new TextField  ;
				var score4:TextField = new TextField  ;
				var score5:TextField = new TextField  ;

				var label1:TextField = new TextField  ;
				var label2:TextField = new TextField  ;
				var label3:TextField = new TextField  ;
				var label4:TextField = new TextField  ;
				var label5:TextField = new TextField  ;
				var label6:TextField = new TextField  ;
				var label7:TextField = new TextField  ;

				label1.defaultTextFormat = label2.defaultTextFormat = label3.defaultTextFormat = label4.defaultTextFormat = label5.defaultTextFormat = label6.defaultTextFormat = label7.defaultTextFormat = myFormat;

				name1.defaultTextFormat = myFormat;
				name2.defaultTextFormat = myFormat;
				name3.defaultTextFormat = myFormat;
				name4.defaultTextFormat = myFormat;
				name5.defaultTextFormat = myFormat;

				score1.defaultTextFormat = myFormat;
				score2.defaultTextFormat = myFormat;
				score3.defaultTextFormat = myFormat;
				score4.defaultTextFormat = myFormat;
				score5.defaultTextFormat = myFormat;

				scoreBoard.addChild(name1);
				scoreBoard.addChild(name2);
				scoreBoard.addChild(name3);
				scoreBoard.addChild(name4);
				scoreBoard.addChild(name5);

				scoreBoard.addChild(score1);
				scoreBoard.addChild(score2);
				scoreBoard.addChild(score3);
				scoreBoard.addChild(score4);
				scoreBoard.addChild(score5);

				scoreBoard.addChild(label1);
				scoreBoard.addChild(label2);
				scoreBoard.addChild(label3);
				scoreBoard.addChild(label4);
				scoreBoard.addChild(label5);
				scoreBoard.addChild(label6);
				scoreBoard.addChild(label7);

				label1.text = '' + '1';
				label2.text = '' + '2';
				label3.text = '' + '3';
				label4.text = '' + '4';
				label5.text = '' + '5';
				label6.text = '' + 'Name';
				label7.text = '' + 'Score';

				name1.text = '' + scores["user1"].uname;
				name2.text = '' + scores["user2"].uname;
				name3.text = '' + scores["user3"].uname;
				name4.text = '' + scores["user4"].uname;
				name5.text = '' + scores["user5"].uname;

				score1.text = '' + scores["user1"].score;
				score2.text = '' + scores["user2"].score;
				score3.text = '' + scores["user3"].score;
				score4.text = '' + scores["user4"].score;
				score5.text = '' + scores["user5"].score;

				name1.width = name2.width = name3.width = name4.width = name5.width = score1.width = score2.width = score3.width = score4.width = score5.width = 107;

				name1.height = name2.height = name3.height = name4.height = name5.height = score1.height = score2.height = score3.height = score4.height = score5.height = 27.35;

				name1.x = name2.x = name3.x = name4.x = name5.x = 280;

				score1.x = score2.x = score3.x = score4.x = score5.x = 400;

				label6.x = 280;
				label7.x = 400;

				label1.x = 250;
				label2.x = label1.x;
				label3.x = label2.x;
				label4.x = label3.x;
				label5.x = label4.x;

				label6.y = 100;
				label7.y = 100;

				label1.y = 125;
				label2.y = 160;
				label3.y = 200;
				label4.y = 235;
				label5.y = 270;


				name1.y = 125;
				name2.y = 160;
				name3.y = 200;
				name4.y = 235;
				name5.y = 270;

				score1.y = 125;
				score2.y = 160;
				score3.y = 200;
				score4.y = 235;
				score5.y = 270;

				btnHome.x = 180;
				btnHome.y = 320;
				btnNext.x = 380;
				btnNext.y = 320;
			}

			var button:Sound = new Sound();
			var buttonChannel:SoundChannel = new SoundChannel();
			button.load(new URLRequest("Sounds/Button.mp3"));
			
			stage.addEventListener(Event.ENTER_FRAME,theFunction);

			function theFunction(event:Event)
			{				
				if ((currentFrame == 2))
				{
					
					theStart.alpha = .5;
					stage.addEventListener(MouseEvent.MOUSE_MOVE,userUpdated);

					function userUpdated(event:MouseEvent)
					{
						theHand.x = mouseX;
						theHand.y = mouseY;
					}
					
					if (theHand.hitTestObject(theStart) == true)
					{	
						theStart.alpha = 1;
												
						if (theStart.alpha == 1)
						{							
							hoverTimer.start();
							hoverTimer.addEventListener(TimerEvent.TIMER_COMPLETE,hoverHandler);
							hoverTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
							function completeHandler(event:TimerEvent)
							{
								buttonChannel = button.play();
							}

							function hoverHandler(event:TimerEvent)
							{
								gotoAndStop(3);
								
							}
						}
					}

					if (theHand.hitTestObject(theStart) == false)
					{
						theStart.alpha = .5;

						if (theStart.alpha == .5)
						{
							hoverTimer.stop();
						}
					}
				}

				if ((currentFrame == 3))
				{
					myChannel6.stop();
					myChannel7.stop();
					myChannel8.stop();
					myChannel9.stop();
			
					goMaze.alpha = .5;
					stage.addEventListener(MouseEvent.MOUSE_MOVE,userUpdated2);

					function userUpdated2(event:MouseEvent)
					{
						theHand2.x = mouseX;
						theHand2.y = mouseY;
					}

					if (goMaze.hitTestObject(theHand2) == true)
					{
						goMaze.alpha = 1;

						if (goMaze.alpha == 1)
						{
							hoverTimer3.stop();
							hoverTimer2.start();
							hoverTimer2.addEventListener(TimerEvent.TIMER_COMPLETE, hoverHandler2);

							function hoverHandler2(event:TimerEvent)
							{
								gotoAndStop(4);
							}
						}
					}

					if (goMaze.hitTestObject(theHand2) == false)
					{
						goMaze.alpha = .5;

						if (goMaze.alpha == .5)
						{
							hoverTimer2.stop();
						}
					}

					if (goCar.hitTestObject(theHand2) == true)
					{
						goCar.alpha = 1;

						if (goCar.alpha == 1)
						{
							hoverTimer2.stop();
							hoverTimer3.start();
							hoverTimer3.addEventListener(TimerEvent.TIMER_COMPLETE, hoverHandler3);

							function hoverHandler3(event:TimerEvent)
							{
								gotoAndStop(8);
							}
						}
					}

					if (goCar.hitTestObject(theHand2) == false)
					{
						goCar.alpha = .5;

						if (goCar.alpha == .5)
						{
							hoverTimer3.stop();
						}
					}
				}

				if ((currentFrame == 4))
				{
					myChannel1.stop();
					
					mySound6.load(new URLRequest("Sounds/Maze_Lv1.mp3"));
								
					myChannel6 = mySound6.play();

					theHand2.alpha = 0.5;
					theHand2.scaleX = 0.1;
					theHand2.scaleY = 0.1;
					theHand2.x = mouseX;
					theHand2.y = mouseY;
					stage.removeEventListener(Event.ENTER_FRAME,theFunction);

					var levelOneCollision:Array = new Array();
					levelOneCollision.push(cc1, cc2, cc3, cc4, cc5, cc6, cc7, cc8, cc9, cc10, cc11, cc12, cc13, cc14, cc15, cc16, cc17, cc18, cc19, cc20, cc21, cc22, cc23, cc24, cc25, cc26, cc27, cc28, cc29, cc30, cc31, cc32, cc33, cc34, cc35, cc36, cc37, cc38, cc39, cc40, cc41, cc42, cc43, cc44, cc45, cc46, cc47, cc48, cc49, cc50, cc51, cc52, cc53, cc54, cc55, cc56, cc57, cc58, cc59, cc60, cc61, cc62, cc63, cc64, cc65, cc66, cc67, cc68, cc69, cc70, cc71, cc72, cc73, cc74, cc75, cc76, cc77, cc78, cc79, cc80, cc81, cc82, cc83, cc84, cc85, cc86, cc87, cc88, cc89, cc90, cc91, cc92, cc93, cc94, cc95, cc96, cc97, cc98, cc99, cc100, cc101, cc102, cc103, cc104, cc105, cc106, cc107, cc108, cc109, cc110, cc111, cc112, cc113, cc114, cc115, cc116, cc117, cc118, cc119, cc120, cc121, cc122, cc123, cc124, cc125, cc126, cc127, cc128, cc129, cc130, cc131, cc132, cc133, cc134, cc135, cc136, cc137, cc138, cc139, cc140, cc141, cc142, cc143, cc144, cc145, cc146, cc147, cc148, cc149, cc150, cc151, cc152, cc153, cc154, cc155, cc156, cc157, cc158, cc159, cc160, cc161, cc162, cc163, cc164, cc165, cc166, cc167, cc168, cc169);
					levelOneCollision.alpha = 0.1;
					stage.addEventListener(MouseEvent.MOUSE_MOVE,userUpdated3);
					
					function userUpdated3(event:MouseEvent)
					{
						if(theHand2.hitTestObject(character1))
						{
							character1.x = mouseX;
							character1.y = mouseY;
						}
						
						else
						{
							character1.x = 55;
							character1.y = 345;
						}

						for (var i:int = 0; i < levelOneCollision.length; i++)
						{
							levelOneCollision[i].alpha = 1;

							if (levelOneCollision[i].hitTestObject(character1) == true)
							{
								trace("hit maze");
								character1.x = 55;
								character1.y = 345;
							}
						}
					}

					var livesArray:Array = new Array  ;
					livesArray.push(one,two,three,four);
					var lives:int = 5;

					var score:int = 0;

					var myTextField:TextField = new TextField  ;
					myTextField.backgroundColor = 0xFFFFFF;
					myTextField.height = 20;
					myTextField.width = 40;
					myTextField.background = true;
					myTextField.x = 85;
					myTextField.y = 15;
					myTextField.text = "" + String(score);
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
					movingTimer1.addEventListener(TimerEvent.TIMER,handler1);
					movingTimer2.addEventListener(TimerEvent.TIMER,handler2);

					function handler1(event:TimerEvent)
					{
						if (enemy1.x <= 115)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy2.y >= 250)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy3.x <= 483)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						else
						{
							enemy1.x -=  enemy1.moveSkull;
							enemy1.scaleX = +.025;
							enemy1.scaleY = +.025;

							enemy2.y +=  enemy2.moveSkull;
							enemy2.scaleX = +.025;
							enemy2.scaleY = +.025;

							enemy3.x -=  enemy3.moveSkull;
							enemy3.scaleX = +.025;
							enemy3.scaleY = +.025;
						}
					}

					function handler2(event:TimerEvent)
					{
						if (enemy1.x >= 173)
						{
							movingTimer2.stop();
							movingTimer1.start();

						}

						if (enemy2.y <= 210)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy3.x >= 582)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						else
						{
							enemy1.x +=  enemy1.moveSkull;
							enemy1.scaleX = -.025;

							enemy2.y -=  enemy2.moveSkull;
							enemy2.scaleX = -.025;

							enemy3.x +=  enemy3.moveSkull;
							enemy3.scaleX = -.025;
						}
					}

					stage.addEventListener(Event.ENTER_FRAME,collisionHandler);

					function collisionHandler(event:Event)
					{
						if(goal.hitTestObject(character1) == true)
						{
							gotoAndStop(5);
							stage.removeChild(enemy1);
							stage.removeChild(enemy2);
							stage.removeChild(enemy3);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER,handler1);
							movingTimer2.removeEventListener(TimerEvent.TIMER,handler2);
							stage.removeEventListener(Event.ENTER_FRAME,collisionHandler);
							stage.addEventListener(Event.ENTER_FRAME,theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated3);
							stage.removeChild(myTextField);
						}
						
						else
						{
							for (var j:int = 0; j < livesArray.length; j++)
							{
								if (character1.hitTestObject(enemy1))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (character1.hitTestObject(enemy2))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (character1.hitTestObject(enemy3))
								{
									removeChild(livesArray[j]);
									livesArray.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (livesArray.length <= 0)
								{
									trace("Game Over!!!");
									removeChild(character1);
									updateScoreBoard();
								}

							}

							if (bonus.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(bonus);
								gate.play();
								score++;
								scoring++;
								myTextField.text = "" + String(score);
								gate.play();
							}

							if (coin.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin);
								score++;
								scoring++;
								myTextField.text = "" + String(score);
							}

							if (secondCoin.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(secondCoin);
								score++;
								scoring++;
								myTextField.text = "" + String(score);
							}

							if (thirdCoin.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(thirdCoin);
								score++;
								scoring++;
								myTextField.text = "" + String(score);
							}
						}
					}
					
					logoutBtn.addEventListener(MouseEvent.CLICK, clickingHandler2);
					function clickingHandler2(event:MouseEvent)
					{
						myChannel1 = mySound1.play();
						stage.removeChild(enemy1);
						stage.removeChild(enemy2);
						stage.removeChild(enemy3);
						movingTimer2.stop();
						movingTimer1.stop();
						movingTimer1.removeEventListener(TimerEvent.TIMER,handler1);
						movingTimer2.removeEventListener(TimerEvent.TIMER,handler2);
						stage.removeEventListener(Event.ENTER_FRAME,collisionHandler);
						stage.addEventListener(Event.ENTER_FRAME,theFunction);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated3);
						stage.removeChild(myTextField);
						gotoAndStop(3);
					}
				}

				if ((currentFrame == 5))
				{
					myChannel6.stop();
					mySound7.load(new URLRequest("Sounds/Maze_Lv2.mp3"));
			
					myChannel7 = mySound7.play();
					
					var levelOneCollision2:Array = new Array();
					levelOneCollision2.push(cc170, cc171, cc172, cc173, cc174, cc175, cc176, cc177, cc178, cc179, cc11, cc180, cc182, cc183, cc184, cc185, cc186, cc187, cc188, cc189, cc190, cc191, cc192, cc193, cc194, cc195, cc196, cc197, cc198, cc199, cc200, cc201, cc202, cc203, cc204, cc205, cc206, cc207, cc208, cc209, cc210, cc211, cc212, cc213, cc214);
					
					stage.removeEventListener(Event.ENTER_FRAME,theFunction);

					stage.addEventListener(MouseEvent.MOUSE_MOVE,userUpdated4);

					function userUpdated4(event:MouseEvent)
					{
						if(theHand2.hitTestObject(character1))
						{
							character1.x = mouseX;
							character1.y = mouseY;
						}
						
						else
						{
							character1.x = 55;
							character1.y = 345;
						}
					}

					var livesArray2:Array = new Array(one1,two2,three3,four4);
					var lives2:int = 5;

					var score2:int = 0;

					var myTextField2:TextField = new TextField  ;
					myTextField2.backgroundColor = 0xFFFFFF;
					myTextField2.height = 20;
					myTextField2.width = 40;
					myTextField2.background = true;
					myTextField2.x = 475;
					myTextField2.y = 47;
					myTextField2.text = "" + String(score2);
					stage.addChild(myTextField2);

					enemy4.moveSkull = 2;
					enemy5.moveSkull = 2.5;
					enemy6.moveSkull = 2;
					enemy7.moveSkull = 2.4;

					stage.addChild(enemy4);
					enemy4.x = 115;
					enemy4.y = 145;
					enemy4.scaleX = +.025;
					enemy4.scaleY = +.025;

					stage.addChild(enemy5);
					enemy5.x = 405;
					enemy5.y = 290;
					enemy5.scaleX = +.025;
					enemy5.scaleY = +.025;

					stage.addChild(enemy6);
					enemy6.x = 660;
					enemy6.y = 230;
					enemy6.scaleX = +.025;
					enemy6.scaleY = +.025;

					stage.addChild(enemy7);
					enemy7.x = 335;
					enemy7.y = 165;
					enemy7.scaleX = +.025;
					enemy7.scaleY = +.025;

					movingTimer1.start();
					movingTimer1.addEventListener(TimerEvent.TIMER,handler3);
					movingTimer2.addEventListener(TimerEvent.TIMER,handler4);

					function handler3(event:TimerEvent)
					{
						if (enemy4.x <= 45)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy5.x <= 295)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy6.x <= 580)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy7.x <= 245)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						else
						{
							enemy4.x -=  enemy4.moveSkull;
							enemy4.scaleX = +.025;

							enemy5.x -=  enemy5.moveSkull;
							enemy5.scaleX = +.025;

							enemy6.x -=  enemy6.moveSkull;
							enemy6.scaleX = +.025;

							enemy7.x -=  enemy7.moveSkull;
							enemy7.scaleX = +.025;
						}
					}

					function handler4(event:TimerEvent)
					{
						if (enemy4.x >= 155)
						{
							movingTimer2.stop();
							movingTimer1.start();

						}

						if (enemy5.x >= 405)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy6.x >= 660)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy7.x >= 335)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						else
						{
							enemy4.x +=  enemy4.moveSkull;
							enemy4.scaleX = -.025;

							enemy5.x +=  enemy5.moveSkull;
							enemy5.scaleX = -.025;

							enemy6.x +=  enemy6.moveSkull;
							enemy6.scaleX = -.025;

							enemy7.x +=  enemy7.moveSkull;
							enemy7.scaleX = -.025;
						}
					}

					stage.addEventListener(Event.ENTER_FRAME,collisionHandler2);

					function collisionHandler2(event:Event)
					{
						if (cc170.hitTestObject(character1) == true || cc171.hitTestObject(character1) == true || cc172.hitTestObject(character1) == true || cc173.hitTestObject(character1) == true || cc174.hitTestObject(character1) == true || cc175.hitTestObject(character1) == true || cc176.hitTestObject(character1) == true || cc177.hitTestObject(character1) == true || cc178.hitTestObject(character1) == true || cc179.hitTestObject(character1) == true || cc180.hitTestObject(character1) == true || cc182.hitTestObject(character1) == true || cc183.hitTestObject(character1) == true || cc184.hitTestObject(character1) == true || cc185.hitTestObject(character1) == true || cc186.hitTestObject(character1) == true || cc187.hitTestObject(character1) == true || cc188.hitTestObject(character1) == true || cc189.hitTestObject(character1) == true || cc190.hitTestObject(character1) == true || cc191.hitTestObject(character1) == true || cc192.hitTestObject(character1) == true || cc193.hitTestObject(character1) == true || cc194.hitTestObject(character1) == true || cc195.hitTestObject(character1) == true || cc196.hitTestObject(character1) == true || cc197.hitTestObject(character1) == true || cc198.hitTestObject(character1) == true || cc199.hitTestObject(character1) == true || cc200.hitTestObject(character1) == true || cc201.hitTestObject(character1) == true || cc202.hitTestObject(character1) == true || cc203.hitTestObject(character1) == true || cc204.hitTestObject(character1) == true || cc205.hitTestObject(character1) == true || cc206.hitTestObject(character1) == true || cc207.hitTestObject(character1) == true || cc208.hitTestObject(character1) == true || cc209.hitTestObject(character1) == true || cc210.hitTestObject(character1) == true || cc211.hitTestObject(character1) == true || cc212.hitTestObject(character1) == true || cc213.hitTestObject(character1) == true || cc214.hitTestObject(character1) == true)
						{
							trace("hit");
							trace("hit level 2 maze");
							character1.x = 55;
							character1.y = 345;
						}

						if (theSign2.hitTestObject(character1) == true)
						{
							gotoAndStop(6);
							stage.removeChild(enemy4);
							stage.removeChild(enemy5);
							stage.removeChild(enemy6);
							stage.removeChild(enemy7);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER,handler3);
							movingTimer2.removeEventListener(TimerEvent.TIMER,handler4);
							stage.removeEventListener(Event.ENTER_FRAME,collisionHandler2);
							stage.addEventListener(Event.ENTER_FRAME,theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated4);
							stage.removeChild(myTextField2);
						}
						
						else
						{
							for (var j:int = 0; j < livesArray2.length; j++)
							{
								if (character1.hitTestObject(enemy4))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (character1.hitTestObject(enemy5))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (character1.hitTestObject(enemy6))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (character1.hitTestObject(enemy7))
								{
									removeChild(livesArray2[j]);
									livesArray2.splice(j,1);
									character1.x = 55;
									character1.y = 345;
								}

								if (livesArray2.length <= 0)
								{
									trace("Game Over!!!");
									removeChild(character1);
									updateScoreBoard();
								}
							}
							
							if (bonus1.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(bonus1);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (bonus2.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(bonus2);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin1.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin1);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin2.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin2);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin3.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin3);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin4.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin4);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin5.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin5);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin6.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin6);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (coin7.hitTestObject(character1))
							{
								trace("bonus points scored");
								removeChild(coin7);
								score2++;
								scoring++;
								myTextField2.text = "" + String(score2);
							}

							if (!bonus1.stage && !bonus2.stage && !coin1.stage && !coin2.stage && !coin3.stage
							   && !coin4.stage && !coin5.stage && !coin6.stage && !coin7.stage)
							{
								trace("all points removed.");
								updateScoreBoard();
							}
						}
					}

					logoutBtn.addEventListener(MouseEvent.CLICK, clickingHandler3);
					function clickingHandler3(event:MouseEvent)
					{
						
						myChannel1 = mySound1.play();
						stage.removeChild(enemy4);
						stage.removeChild(enemy5);
						stage.removeChild(enemy6);
						stage.removeChild(enemy7);
						movingTimer2.stop();
						movingTimer1.stop();
						movingTimer1.removeEventListener(TimerEvent.TIMER,handler3);
						movingTimer2.removeEventListener(TimerEvent.TIMER,handler4);
						stage.removeEventListener(Event.ENTER_FRAME,collisionHandler2);
						stage.addEventListener(Event.ENTER_FRAME,theFunction);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated4);
						stage.removeChild(myTextField2);
						gotoAndStop(3);
					}
				}

				if ((currentFrame == 6))
				{
					myChannel7.stop();
					mySound8.load(new URLRequest("Sounds/Maze_Lv3.mp3"));
			
					myChannel8 = mySound8.play();

					stage.removeEventListener(Event.ENTER_FRAME,theFunction);
					stage.addEventListener(MouseEvent.MOUSE_MOVE,userUpdated5);

					function userUpdated5(event:MouseEvent)
					{						
						if(theHand2.hitTestObject(character3))
						{
							character3.x = mouseX;
							character3.y = mouseY;
						}
						
						else
						{
							character1.x = 45;
							character1.y = 170;
						}
					}

					var livesArray3:Array = new Array(oneOne,twoTwo,threeThree,fourFour);
					var lives3:int = 5;
					
					var score3:int = 0;

					var myTextField3:TextField = new TextField  ;
					myTextField3.backgroundColor = 0xFFFFFF;
					myTextField3.height = 20;
					myTextField3.width = 40;
					myTextField3.background = true;
					myTextField3.x = 80;
					myTextField3.y = 20;
					myTextField3.text = "" + String(score3);
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
					movingTimer1.addEventListener(TimerEvent.TIMER,handler5);
					movingTimer2.addEventListener(TimerEvent.TIMER,handler6);

					function handler5(event:TimerEvent)
					{
						if (enemy8.x <= 45)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy9.x <= 295)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy10.x <= 580)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}

						if (enemy11.x <= 245)
						{
							movingTimer1.stop();
							movingTimer2.start();
						}
						else
						{
							enemy8.x -=  enemy8.moveSkull;
							enemy8.scaleX = +.025;

							enemy9.x -=  enemy9.moveSkull;
							enemy9.scaleX = +.025;

							enemy10.x -=  enemy10.moveSkull;
							enemy10.scaleX = +.025;

							enemy11.x -=  enemy11.moveSkull;
							enemy11.scaleX = +.025;
						}
					}

					function handler6(event:TimerEvent)
					{
						if (enemy8.x >= 155)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy9.x >= 405)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy10.x >= 660)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}

						if (enemy11.x >= 335)
						{
							movingTimer2.stop();
							movingTimer1.start();
						}
						else
						{
							enemy8.x +=  enemy8.moveSkull;
							enemy8.scaleX = -.025;

							enemy9.x +=  enemy9.moveSkull;
							enemy9.scaleX = -.025;

							enemy10.x +=  enemy10.moveSkull;
							enemy10.scaleX = -.025;

							enemy11.x +=  enemy11.moveSkull;
							enemy11.scaleX = -.025;
						}
					}

					stage.addEventListener(Event.ENTER_FRAME,collisionHandler3);

					function collisionHandler3(event:Event)
					{
						if(cc215.hitTestObject(character3) == true || cc216.hitTestObject(character3) == true || cc217.hitTestObject(character3) == true || cc218.hitTestObject(character3) == true || cc219.hitTestObject(character3) == true || cc220.hitTestObject(character3) == true || cc221.hitTestObject(character3) == true || cc222.hitTestObject(character3) == true || cc223.hitTestObject(character3) == true || cc225.hitTestObject(character3) == true || cc226.hitTestObject(character3) == true || cc227.hitTestObject(character3) == true || cc228.hitTestObject(character3) == true || cc229.hitTestObject(character3) == true || cc230.hitTestObject(character3) == true || cc231.hitTestObject(character3) == true || cc232.hitTestObject(character3) == true || cc233.hitTestObject(character3) == true || cc234.hitTestObject(character3) == true || cc235.hitTestObject(character3) == true || cc236.hitTestObject(character3) == true || cc237.hitTestObject(character3) == true || cc238.hitTestObject(character3) == true || cc239.hitTestObject(character3) == true || cc240.hitTestObject(character3) == true || cc241.hitTestObject(character3) == true || cc242.hitTestObject(character3) == true || cc243.hitTestObject(character3) == true || cc244.hitTestObject(character3) == true || cc245.hitTestObject(character3) == true || cc246.hitTestObject(character3) == true || cc247.hitTestObject(character3) == true || cc248.hitTestObject(character3) == true || cc249.hitTestObject(character3) == true || cc250.hitTestObject(character3) == true || cc251.hitTestObject(character3) == true || cc253.hitTestObject(character3) == true || cc254.hitTestObject(character3) == true || cc255.hitTestObject(character3) == true || cc256.hitTestObject(character3) == true || cc257.hitTestObject(character3) == true || cc258.hitTestObject(character3) == true || cc259.hitTestObject(character3) == true || cc260.hitTestObject(character3) == true || cc261.hitTestObject(character3) == true || cc262.hitTestObject(character3) == true || cc263.hitTestObject(character3) == true || cc264.hitTestObject(character3) == true || cc265.hitTestObject(character3) == true || cc266.hitTestObject(character3) == true || cc267.hitTestObject(character3) == true || cc268.hitTestObject(character3) == true || cc269.hitTestObject(character3) == true || cc270.hitTestObject(character3) == true || cc271.hitTestObject(character3) == true || cc272.hitTestObject(character3) == true || cc273.hitTestObject(character3) == true || cc274.hitTestObject(character3) == true || cc275.hitTestObject(character3) == true || cc276.hitTestObject(character3) == true || cc277.hitTestObject(character3) == true || cc278.hitTestObject(character3) == true || cc279.hitTestObject(character3) == true || cc280.hitTestObject(character3) == true || cc281.hitTestObject(character3) == true || cc282.hitTestObject(character3) == true || cc283.hitTestObject(character3) == true || cc284.hitTestObject(character3) == true || cc285.hitTestObject(character3) == true || cc286.hitTestObject(character3) == true || cc287.hitTestObject(character3) == true || cc288.hitTestObject(character3) == true || cc289.hitTestObject(character3) == true || cc290.hitTestObject(character3) == true || cc291.hitTestObject(character3) == true || cc292.hitTestObject(character3) == true || cc293.hitTestObject(character3) == true || cc294.hitTestObject(character3) == true || cc295.hitTestObject(character3) == true || cc296.hitTestObject(character3) == true || cc297.hitTestObject(character3) == true || cc298.hitTestObject(character3) == true || cc299.hitTestObject(character3) == true || cc300.hitTestObject(character3) == true || cc301.hitTestObject(character3) == true || cc302.hitTestObject(character3) == true || cc303.hitTestObject(character3) == true || cc304.hitTestObject(character3) == true || cc305.hitTestObject(character3) == true || cc306.hitTestObject(character3) == true || cc307.hitTestObject(character3) == true || cc308.hitTestObject(character3) == true || cc309.hitTestObject(character3) == true || cc310.hitTestObject(character3) == true || cc311.hitTestObject(character3) == true || cc312.hitTestObject(character3) == true || cc314.hitTestObject(character3) == true || cc315.hitTestObject(character3) == true || cc316.hitTestObject(character3) == true || cc317.hitTestObject(character3) == true || cc318.hitTestObject(character3) == true || cc319.hitTestObject(character3) == true || cc320.hitTestObject(character3) == true || cc321.hitTestObject(character3) == true || cc322.hitTestObject(character3) == true || cc323.hitTestObject(character3) == true || cc324.hitTestObject(character3) == true || cc325.hitTestObject(character3) == true || cc326.hitTestObject(character3) == true || cc327.hitTestObject(character3) == true || cc328.hitTestObject(character3) == true || cc329.hitTestObject(character3) == true || cc330.hitTestObject(character3) == true || cc331.hitTestObject(character3) == true || cc332.hitTestObject(character3) == true || cc333.hitTestObject(character3) == true || cc334.hitTestObject(character3) == true || cc335.hitTestObject(character3) == true)
						{
							trace("hit");
							trace("hit level 2 maze");
							character3.x = 40;
							character3.y = 170;
						}
						
						if (goal2.hitTestObject(character1) == true)
						{
							gotoAndStop(3);
							stage.removeChild(enemy8);
							stage.removeChild(enemy9);
							stage.removeChild(enemy10);
							stage.removeChild(enemy11);
							movingTimer2.stop();
							movingTimer1.stop();
							movingTimer1.removeEventListener(TimerEvent.TIMER,handler5);
							movingTimer2.removeEventListener(TimerEvent.TIMER,handler6);
							stage.removeEventListener(Event.ENTER_FRAME,collisionHandler3);
							stage.addEventListener(Event.ENTER_FRAME,theFunction);
							stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated5);
							stage.removeChild(character3);
							stage.removeChild(myTextField3);
						}
						
						else
						{
							for (var j:int = 0; j < livesArray3.length; j++)
							{
								if (character3.hitTestObject(enemy8))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
									character3.x = 45;
									character3.y = 170;
								}

								if (character3.hitTestObject(enemy9))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
									character3.x = 45;
									character3.y = 170;
								}

								if (character3.hitTestObject(enemy10))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
									character3.x = 45;
									character3.y = 170;
								}

								if (character3.hitTestObject(enemy11))
								{
									removeChild(livesArray3[j]);
									livesArray3.splice(j,1);
									character3.x = 45;
									character3.y = 170;
								}

								if (livesArray3.length <= 0)
								{
									trace("Game Over!!!");
									removeChild(character3);
									updateScoreBoard();
								}

							}
							
							if (bonus4.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus4);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus5.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus5);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus6.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus6);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus7.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus7);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus8.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus8);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus9.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus9);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (bonus10.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(bonus10);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin1c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin1c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin2c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin2c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin3c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin3c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin4c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin4c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin5c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin5c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin6c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin6c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin7c.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin7c);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin8.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin8);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin9.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin9);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin10.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin10);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin11.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin11);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin12.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin12);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin13.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin13);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin14.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin14);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin15.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin15);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin16.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin16);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin17.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin17);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin18.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin18);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin19.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin19);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin20.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin20);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}

							if (coin21.hitTestObject(character3))
							{
								trace("bonus points scored");
								removeChild(coin21);
								score3++;
								scoring++;
								myTextField3.text = "" + String(score3);
							}
						}
					}
					
					logoutBtn2.addEventListener(MouseEvent.CLICK, clickingHandler);
					function clickingHandler(event:MouseEvent)
					{
						
						myChannel1 = mySound1.play();
						stage.removeChild(enemy8);
						stage.removeChild(enemy9);
						stage.removeChild(enemy10);
						stage.removeChild(enemy11);
						movingTimer2.stop();
						movingTimer1.stop();
						movingTimer1.removeEventListener(TimerEvent.TIMER,handler5);
						movingTimer2.removeEventListener(TimerEvent.TIMER,handler6);
						stage.removeEventListener(Event.ENTER_FRAME,collisionHandler3);
						stage.addEventListener(Event.ENTER_FRAME,theFunction);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE,userUpdated5);
						character3.alpha = 0;
						stage.removeChild(myTextField3);
						gotoAndStop(3);
					}
				}

				if ((currentFrame == 8))
				{
					myChannel8.stop();
					myChannel1.stop();
					mySound9.load(new URLRequest("Sounds/car3.mp3"));
					
	
					var score4:int = 0;
					var scoreUpdating2:Timer = new Timer(1000);

					var myTextField4:TextField = new TextField  ;
					myTextField4.backgroundColor = 0xE3E5E0;
					myTextField4.height = 17;
					myTextField4.width = 45;
					myTextField4.background = true;
					myTextField4.x = 300;
					myTextField4.y = 41;
					myTextField4.text = "" + String(score4);
					stage.addChild(myTextField4);				
	
					var score5:int = 30;
					var timeRemaning:TextField = new TextField  ;
					timeRemaning.backgroundColor = 0xFFFFFF;
					timeRemaning.height = 16;
					timeRemaning.width = 45;
					timeRemaning.background = true;
					timeRemaning.x = 398;
					timeRemaning.y = 349;
					timeRemaning.text = "Fuel: " + String(score5);
					
					timeLeft.addEventListener(TimerEvent.TIMER, remaningTime);
					
					function remaningTime(event:TimerEvent)
					{
						if(score5 <= 0)
						{
							updateScoreBoard();
							removeChild(theRight);
						}
						
						else
						{
							timeRemaning.text = "Fuel: " + String(score5 --);
						}
					}
					
					stage.addChild(timeRemaning);
					
					removeChild(theHand2);
					stage.removeEventListener(Event.ENTER_FRAME, theFunction);
					
					var theRight:RightHand = new RightHand();
					addChild(theRight);
					
					poles.stop();
					cactusRight.stop();
					cactusLeft.stop();
					roadLines.stop();
					
					var timer2:Timer = new Timer(100,1000);
					
					theRight.scaleX = .1;
					theRight.scaleY = .1;
					theRight.alpha = .4;
					timer2.addEventListener(TimerEvent.TIMER, notifier2);
					
					function notifier2(event:TimerEvent):void
					{
						fog.alpha = 1;
						var timing2 = timer2.currentCount;

						stage.addEventListener(MouseEvent.MOUSE_MOVE, maskMove);
						stage.addEventListener(MouseEvent.ROLL_OUT, maskOut);
						stage.addEventListener(MouseEvent.ROLL_OVER, maskOver);
						stage.addEventListener(MouseEvent.MOUSE_OVER, startDrawing);
					}

					timer2.start();

					/******  MASKING  *******/
					var lineSize:Number = 50;
					var doDraw:Boolean = false;
					var resumeDrawing:Boolean = false;

					var erasableBitmapData:BitmapData = new BitmapData(700,400,true,0xFFFFFFFF);
					var erasableBitmap:Bitmap = new Bitmap(erasableBitmapData);
					erasableBitmap.cacheAsBitmap = true;
					addChild(erasableBitmap);

					fog.cacheAsBitmap = true;
					fog.mask = erasableBitmap;


					/*******  ERASER  *******/
					var eraserClip:Sprite = new Sprite();
					initEraser();

					function initEraser():void
					{
						eraserClip.graphics.lineStyle(lineSize,0xff0000);
						eraserClip.graphics.moveTo(mouseX,mouseY);
					}

					var drawnBitmapData:BitmapData = new BitmapData(700,400,true,0x00000000);
					var drawnBitmap:Bitmap = new Bitmap(drawnBitmapData);


					/******  MOUSE EVENTS  ********/
					function startDrawing(e:MouseEvent):void
					{
						eraserClip.graphics.moveTo(mouseX,mouseY);
						doDraw = true;
					}
					
					function maskOut(e:Event):void
					{
						if (doDraw)
						{
							addChild(theRight);
								
							poles.stop();
							cactusRight.stop();
							cactusLeft.stop();
							roadLines.stop();

							var timer2:Timer = new Timer(100, 1000);
							theRight.scaleX = .1;
							theRight.scaleY = .1;
							theRight.alpha = .4;
							timer2.addEventListener(TimerEvent.TIMER, notifier2);

							function notifier2(event:TimerEvent):void
							{
								fog.alpha=1;
								var timing2 = timer2.currentCount;
								stage.addEventListener(MouseEvent.MOUSE_MOVE, maskMove);
								stage.addEventListener(MouseEvent.ROLL_OUT, maskOut); 
								stage.addEventListener(MouseEvent.ROLL_OVER, maskOver);
								stage.addEventListener(MouseEvent.MOUSE_OVER, startDrawing);
							}
							
							resumeDrawing = true;
						}
					}

					function maskOver(e:MouseEvent):void
					{
						if (resumeDrawing)
						{
							resumeDrawing = false
							eraserClip.graphics.moveTo(mouseX,mouseY);
						}
					}

					function maskMove(e:MouseEvent):void
					{
						if (doDraw && !resumeDrawing)
						{
							eraserClip.graphics.lineTo(stage.mouseX,stage.mouseY);
							drawnBitmapData.fillRect(drawnBitmapData.rect, 0x00000000);
							drawnBitmapData.draw(eraserClip , new Matrix(), null, BlendMode.NORMAL);
							erasableBitmapData.fillRect(erasableBitmapData.rect, 0xFFFFFFFF);
							erasableBitmapData.draw(drawnBitmap, new Matrix(), null, BlendMode.ERASE);

							theRight.x = mouseX;
							theRight.y = mouseY;
						}
						
						if(theRight.x <= 215 && theRight.y >= 350)
						{
							theRight.x = 215;
							theRight.y = 350;
						}

						if (theRight.x >= 480 && theRight.y >= 370)
						{
							myChannel9 = mySound9.play();
							
							moveBoxTimer.start();
							moveBoxTimer.addEventListener(TimerEvent.TIMER, moveBoxHandler);

							grannyTimer.start();
							grannyTimer.addEventListener(TimerEvent.TIMER, skatingGrannyHandler);
							granny.moveGranny = 1;
							
							function skatingGrannyHandler(event:TimerEvent)
							{
								granny.x +=  granny.moveGranny;
							}

							function moveBoxHandler(event:TimerEvent)
							{
								if(doDraw && !resumeDrawing)
								{
									eraserClip.graphics.lineTo(stage.mouseX,stage.mouseY);
									drawnBitmapData.fillRect(drawnBitmapData.rect, 0x00000000); 
									drawnBitmapData.draw(eraserClip , new Matrix(), null, BlendMode.NORMAL);
									erasableBitmapData.fillRect(erasableBitmapData.rect, 0xFFFFFFFF);
									erasableBitmapData.draw(drawnBitmap, new Matrix(), null, BlendMode.ERASE);
									
									theRight.x = mouseX;
									theRight.y = mouseY;
								}
								
								fog.alpha = 1;
								poles.play();
								cactusRight.play();
								cactusLeft.play();
								roadLines.play();
								theDash.play();
								
								proCar.x += .05;
							
								if(proCar.x >= 520)
								{
									reFoggingTimer.stop();
									scoreUpdating2.stop();
									updateScoreBoard();
								}
							}
							
							scoreUpdating2.start();
							scoreUpdating2.addEventListener(TimerEvent.TIMER, updatingTheScore);
							
							function updatingTheScore(event:TimerEvent)
							{
								myTextField4.text = "" + String(score4 ++);
								timeLeft.start();
							}
							
							reFoggingTimer.start();
							reFoggingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, refoggingHandler);
							
							function refoggingHandler(event:TimerEvent)
							{
								eraserClip.graphics.clear();
								initEraser();
								erasableBitmapData.fillRect(erasableBitmapData.rect, 0xFFFFFFFF);
								scoreUpdating2.stop();
								timeLeft.stop();
							}
							
							fog.alpha = 1;
						}
						
						else if(theRight.x <= 480 && theRight.y <=370)
						{
							poles.stop();
							cactusRight.stop();
							cactusLeft.stop();
							roadLines.stop();
							scoreUpdating2.stop();
							moveBoxTimer.stop();
							grannyTimer.stop();
						}
					}
					
					theDash.stop();
					
					var mirror:Mirror = new Mirror();
					addChild(mirror);
					mirror.x = 296;
					mirror.y = 13;
					
					carHome.addEventListener(MouseEvent.CLICK, clickingHandler4);
					function clickingHandler4(event:MouseEvent)
					{
						
						myChannel1 = mySound1.play();
						myChannel9.stop();
						poles.stop();
						cactusRight.stop();
						cactusLeft.stop();
						roadLines.stop();
						scoreUpdating2.stop();
						moveBoxTimer.stop();
						grannyTimer.stop();
						timer2.stop();/*
						movingTimer2.stop();
						movingTimer1.stop();
						movingTimer1.removeEventListener(TimerEvent.TIMER,handler5);
						movingTimer2.removeEventListener(TimerEvent.TIMER,handler6);*/
						stage.addEventListener(Event.ENTER_FRAME,theFunction);
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, maskMove);
						stage.removeEventListener(MouseEvent.ROLL_OUT, maskOut); 
						stage.removeEventListener(MouseEvent.ROLL_OVER, maskOver);
						stage.removeEventListener(MouseEvent.MOUSE_OVER, startDrawing);
						moveRightTimer.stop();
						moveLeftTimer.stop();
						moveRightTimer.removeEventListener(TimerEvent.TIMER, movingRight);
						moveLeftTimer.removeEventListener(TimerEvent.TIMER, movingLeft);
						removeChild(theRight);
						removeChild(mirror);
						removeChild(erasableBitmap);
						stage.removeChild(myTextField4);
						stage.removeChild(timeRemaning);
						gotoAndStop(3);
					}
				}
			}
		}
	}
}