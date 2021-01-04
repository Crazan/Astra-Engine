// Простой пример работы с элементами графического движка
/*
 *  В данном примере загрузим геометрические элеемнты из произвольной папки
 *  и отрисуем их. Работа будет идти через контент и понятие универсальной детали.
 * 
 *  In this example, load geometric elements from an arbitrary folder    
 *  and draw them. The work will go through content and the concept of a universal part.
 *  
 *  2012-2020, E-mail: Ceishes@gmail.com, Copyright: Kataev А. А, Ivanov G. A, Shubin I.A.
 */
using System;
using System.Collections.Generic;
using System.Drawing;
//
using AstraEngine.Engine.GraphicCore;
using AstraEngine.Scene;
using AstraEngine.Geometry.Texture3D;
using AstraEngine.Geometry.Model3D;
using AstraEngine.Geometry.Sprite2D;
//
using StandartHelperLibrary.FileHelper;
//***************************************************************
namespace Example
{
    class TExample_AstraEngine_1 : IEngineInterface
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

            // EXAMPLE FOR 3D TEXTURE
            // 1. Create a geometric object (there can be three options - 3D texture, 3D model and sprite)
            TTexture3D Texture3D = new TTexture3D(Content.Game.Render);
            // 2. Load image from file 
            Texture3D.LoadTexture(AstraEngine.Engine.ETypeTextures.ColorTexture, TFile.GetCurrentPath() + "\\ImageTest.png");
            // 3. Specifying the position and rotation of the object
            Texture3D.Position = new Vector3(0, 0, -1000);
            Texture3D.Rotation = new Vector3(0, 30, 30);
            // 4. Using the lighting controller and setting the light
            Texture3D.ControlLight.AddDirectionLight(Color.Red, 1.0f, new Vector3(0, 1000, 1000));
            // 5. Bind the click event on the object
            Texture3D.OnClick_MouseButton += OnClick_MouseButton;
            // 6. We add the created geometry object to the universal content part.
            // This is necessary for creating complex programs and universal processing with scripts.
            Content.Add(new TContentPart("ImageTest", Texture3D));
            // Referring to the part recorded in the content by name
            var MyTestTexture3D = Content["ImageTest"];
            // Writing an additional arbitrary variable to a universal object
            MyTestTexture3D.SetData("MyTime", DateTime.Now);
            // Reading back
            var ReturnMyTime = MyTestTexture3D.ToDateTime("MyTime");

            // EXAMPLE FOR 3D MODEL
            // 1. Create a geometric object (there can be three options - 3D texture, 3D model and sprite)
            TModel3D Model3D = new TModel3D(Content.Game.Render);
            // 2. Load model from file
            Model3D.LoadModel(TFile.GetCurrentPath() + "\\ModelTest.fbx");
            // 3. Load color and normal maps
            Model3D.LoadTexture(AstraEngine.Engine.ETypeTextures.ColorTexture, TFile.GetCurrentPath() + "\\DiffuseMap.jpg");
            Model3D.LoadTexture(AstraEngine.Engine.ETypeTextures.NormalTexture, TFile.GetCurrentPath() + "\\NormalMap.jpg");
            // 4. Specifying the position and scale of the object
            Model3D.Position = new Vector3(500, 0, -1000);
            Model3D.Scale = new Vector3(2, 2, 2);
            // 5. Using the lighting controller and setting the light
            Model3D.ControlLight.SetAmbientLight(Color.White, 0.1f);
            Model3D.ControlLight.AddDirectionLight(Color.White, 0.5f, new Vector3(0, 1000, 1000));
            // 6. Bind the click event on the object
            Model3D.OnClick_MouseButton += OnClick_MouseButton;

            // EXAMPLE FOR 2D SPRITE AND TEXT
            // 1. Create a geometric object (there can be three options - 3D texture, 3D model and sprite)
            TSprite2D Sprite2D = new TSprite2D(Content.Game.Render);
            // 2. Using the font controller, set the font settings
            Sprite2D.ControlFont.SetFont(AstraEngine.Geometry.EFont.Arial, 20);
            Sprite2D.ControlFont.SetColour(Color.Green);
            // 3. Specifying the position of the object
            Sprite2D.Position = new Vector3(0, 0, 0);
            // 4. We add the created geometry object to the universal content part.
            // This is necessary for creating complex programs and universal processing with scripts.
            Content.Add(new TContentPart("MySrite", Sprite2D));
        }
//---------------------------------------------------------------
        /// <summary>
        /// On TTexture3D click
        /// </summary>
        private void OnClick_MouseButton(List<AstraEngine.Inputs.EButtonMouse> Buttons, Vector2 PositionCursor, AstraEngine.Geometry.IGeometry Geometry)
        {
            // Using content to manipulate the text in a previously created sprite
            Content["MySrite"].ToSprite2D().Text = "Click on: " + Geometry.GetTypeGeometry().ToString();
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
