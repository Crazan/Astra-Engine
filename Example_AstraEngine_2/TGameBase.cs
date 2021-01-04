// The basis of the game. Storing key variables
// 2012-2020, E-mail: Ceishes@gmail.com, Copyright: Kataev А. А, Ivanov G. A, Shubin I.A.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Drawing;
//
using AstraEngine.Inputs;
using AstraEngine.Scene;
using AstraEngine.Engine.GraphicCore;
using AstraEngine.Engine.GraphicCore.Input;
//*******************************************************************************
namespace Example
{
    /// <summary>
    /// The basis of the game. Storing key variables
    /// </summary>
    class TGameBase : TGame
    {
//--------------------------------------------------------------------------
        /// <summary>
        /// The basis of the game. Storing key variables
        /// </summary>
        /// <param name="GraphicEngine">Graphics engine</param>
        public TGameBase(TGraphicEngine GraphicEngine) :
                         base(GraphicEngine, Color.Black)
        {
        }
//--------------------------------------------------------------------------
        /// <summary>
        /// Load start events
        /// </summary>
        /// <param name="Content">Link to content</param>
        public void LoadEvents(TContent Content)
        {
            // 1. We indicate how the game settings will be applied in this game
            Content.GameOptions.OnApplyOption += GameOptions_OnApplyOption;
        }
//--------------------------------------------------------------------------
        /// <summary>
        /// Load start logic (game scripts)
        /// </summary>
        /// <param name="Content">Ссылка на контент</param>
        public void LoadLogic(TContent Content)
        {
            // Load start logic (game scripts)
            // The application is built through content and scripts. 
            // Each script is a state machine that performs a simple action.
            // The content contains a single list of universal parts.
            // Each part can be geometry, interface, any data and their copies
            // Content.ScriptProcessor.Add(new TScript_LoadGame());
        }
//--------------------------------------------------------------------------
        /// <summary>
        /// Applying game settings for the current game
        /// </summary>
        private void GameOptions_OnApplyOption(TContent Content, TContentPart Options)
        {
            // Camera
            // Resetting the basic settings
            Camera.ClearControl();
            // Set position camera
            Camera.PositionCamera = new Vector3(0, 0, 1000);
            // Enable perspective camera
            Camera.Content.ViewCamera3D = AstraEngine.Camera.EViewCamera3D.Perspective;
            // Linear move on mouse
            Camera.ControlMouse.SetControllerLinearMove(new AstraEngine.Camera.SButtonMoveMouse
            {
                ButtonIncreamenDown = EButtonMouse.ScrollUpButton,
                ButtonIncreamenUp = EButtonMouse.ScrollDownButton,
                ButtonMoveInPlane = EButtonMouse.MiddleButton,
                SensitiveIncreamenDown = 25,
                SensitiveIncreamenUp = 25,
                SensitiveMoveInPlaneX = 25,
                SensitiveMoveInPlaneY = 25
            });
            // Move to keyboard
            Camera.ControlKeybord.SetControllerLinearMove(new AstraEngine.Camera.SButtonMoveKeyboard
            {
                ButtonLeft = Keys.A,
                ButtonRight = Keys.D,
                ButtonUp = Keys.Q,
                ButtonDown = Keys.E,
                ButtonBackward = Keys.S,
                ButtonForward = Keys.W,
                SensitiveDown = 25,
                SensitiveLeft = 25,
                SensitiveRight = 25,
                SensitiveUp = 25,
                SensitiveAcceleration = 2
            });
        }
//--------------------------------------------------------------------------
    }
}
