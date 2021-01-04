// An example of working with content and data model. All game objects can be created in xml
// Displayed objects are described in the core folder in the content folder
// Textures and models are in the mods folder in the content folder
// 2012-2020, E-mail: Ceishes@gmail.com, Copyright: Kataev А. А, Ivanov G. A, Shubin I.A.
using System;
using System.Collections.Generic;
using System.Drawing;
//
using AstraEngine.Engine.GraphicCore;
using AstraEngine.Scene;
//***************************************************************
namespace Example
{
    class TExample_AstraEngine_2 : IEngineInterface
    {
        /// <summary>
        /// Engine body reference
        /// </summary>
        public TGraphicEngine Engine { get; set; }
        /// <summary>
        /// Basis of the game (Render, camera, data entry ...)
        /// </summary>
        private TGameBase GameBase;
        /// <summary>
        /// All game content, variables, scripts
        /// </summary>
        private TContent Content;
//---------------------------------------------------------------
        /// <summary>
        /// Initialization 
        /// </summary>
        public void Intitialize(TGraphicEngine GraphicEngine)
        {
            // 1. Let's initialize the engine. Render, camera and data entry
            GameBase = new TGameBase(GraphicEngine);
            // 2. Initializing content
            Content = new TContent(GameBase);
        }
//---------------------------------------------------------------
        /// <summary>
        /// Loading main content
        /// </summary>
        public void LoadContent(TGraphicEngine GraphicEngine)
        {
            // Loading content by the engine (same for all programs)
            // In this example, there is no content, we load it manually
            #region LoadContentEngine
            // 1. Загружаем заставку
            // Loading the splash screen
            GameBase.LoadIntro();
            // 2. Загружаем ядро описывающее все данные программы
            // Load the kernel describing all program data
            Content.LoadCore();
            // 3. Загружаем стартовые события игры (там инициализируются события - например примение настроек под конкретную игру, загрузочный экран)
            // We load the starting events of the game (events are initialized there - for example, applying settings for a specific game, loading screen)
            GameBase.LoadEvents(Content);
            // 5. Загружаем настройки пользователей
            // Loading user settings
            //Content.LoadGameOptions("SimpleDraw", "GameOptions");
            // 6. Загружаем стартовую сцену и те бинарные данные которые нужны для нее
            // We load the starting scene and the binary data that is needed for it
            //Content.LoadScene("MainScene");
            //Content.LoadScene("Scene_TestMonoForms");
            Content.LoadScene("");
            // 7. Загружаем стартовую логику игры (там инициализируются логические скрипты)
            // We load the starting logic of the game (logic scripts are initialized there)
            GameBase.LoadLogic(Content);
            #endregion

            // EXAMPLE 
            // An example of working with content and data model. All game objects can be created in xml
            // ! Displayed objects are described in the core folder in the content folder (Test.xml)
            // ! Textures and models are in the mods folder in the content folder

            // Referencing created to Test.xml items 
            Content["My3DModelObject"].ToModel3D().OnClick_MouseButton += OnClick_MouseButton;
            Content["My3DTextureAnimatedObject"].ToTexture3D().OnClick_MouseButton += OnClick_MouseButton;

            // Run script for My3DTextureAnimatedObject (it is set in Test.xml, see  )
            Content.Add(new TScript_Test());
        }
//---------------------------------------------------------------
        /// <summary>
        /// On TTexture3D click
        /// </summary>
        private void OnClick_MouseButton(List<AstraEngine.Inputs.EButtonMouse> Buttons, Vector2 PositionCursor, AstraEngine.Geometry.IGeometry Geometry)
        {
            // Using content to manipulate the text in a previously created sprite
            Content["MyTextObject"].ToSprite2D().Text = "Click on: " + Geometry.GetTypeGeometry().ToString();
        }
//---------------------------------------------------------------
        /// <summary>
        /// Removing a program
        /// </summary>
        public void Dispose()
        {
            GameBase.Dispose();
        }
//---------------------------------------------------------------
        /// <summary>
        /// Game update loop (Can't update logic, for logic use scripts or Content.Game.OnUpdate_Logic)
        /// </summary>
        public void Update(TGraphicEngine GraphicEngine, TimeSpan Time)
        {
            GameBase.Update(Time);
        }
//---------------------------------------------------------------
        /// <summary>
        /// Rendering method, all rendering goes through the render
        /// </summary>
        public void Draw(TGraphicEngine GraphicEngine, TimeSpan Time)
        {
            GameBase.Draw();
        }
//---------------------------------------------------------------
    }
}
