// Простой пример работы с элементами графического движка
// Загрузка, отрисовка геометрических объектов, работа с деталями
// A simple example of working with elements of the graphics engine
// Loading, drawing geometric objects, working with details
// 2012-2020, E-mail: Ceishes@gmail.com, Copyright: Kataev А. А, Ivanov G. A, Shubin I.A.
using System;
using AstraEngine.Engine.GraphicCore;
using Example;
//****************************************************************
namespace Example_AstraEngine_1
{
    static class Program
    {
        /// <summary>
        /// Главная точка входа для приложения.
        /// </summary>
        [STAThread]
        static void Main()
        {
            // Создаем исполняемую программу игры или приложения
            // Create an executable game or application program
            TExample_AstraEngine_1 Example_AstraEngine_1 = new TExample_AstraEngine_1();
            // Создаем движок и выполняем в нем программу игры или приложения
            // We create an engine and execute a game program or application in it
            TGraphicEngine GraphicEngine = new TGraphicEngine();
            GraphicEngine.Run(Example_AstraEngine_1);
        }
    }
}
