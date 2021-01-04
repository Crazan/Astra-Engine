// Universal script. We use a similar approach to create any application
// Here the principle of finite state machines and a single grid with 
// which they interact performing operations to Initialize, Load, Update
// Content is used as a grid for finite machines
// 2012-2020, E-mail: Ceishes@gmail.com, Copyright: Kataev А. А, Ivanov G. A, Shubin I.A.
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//
using AstraEngine.Engine.GraphicCore;
using AstraEngine.Scene;
//**************************************************************
namespace Example
{
    /// <summary>
    /// Universal script
    /// </summary>
    class TScript_Test : IScript
    {
//------------------------------------------------------------------------------------
        /// <summary>
        /// Executed when the script is registered in the system (Here we write what should be executed once)
        /// </summary>
        public void Initialize(int ID, TContentPart Part, TContent Content)
        {
        }
//------------------------------------------------------------------------------------
        /// <summary>
        /// Loading script parameters
        /// </summary>
        public void Load(out string Name, out TUsingTypeScript UsingTypeScript, out bool Enable)
        {
            // The name we work with script
            Name = "MyTestScript";
            // Parametrs: in which loop do we execute, whether we bind to a universal content item
            UsingTypeScript = new TUsingTypeScript() { TypeScript = ETypeScript.ToLogicLoop, PerformByName = true };
            // Is the script included initially
            Enable = true;
        }
//------------------------------------------------------------------------------------
        /// <summary>
        /// Executing a script in a loop 16 ms
        /// </summary>
        /// <param name="ID">Unique script identifier</param>
        /// <param name="Part">Content item</param>
        /// <param name="Content">All content</param>
        /// <param name="Values">External variables, transmitted by the programmer</param>
        public void Update(int ID, TContentPart Part, TContent Content, Dictionary<string, string> Values)
        {
            // We rotate the object that came to the universal script by
            // the value of the variable given to Test.xml to My3DTextureAnimatedObject
            Part.ToTexture3D().Rotation = new Vector3(0, 0,
            Part.ToTexture3D().Rotation.Z + Content["My3DTextureAnimatedObject"].ToInt("MyTestVariable"));
        }
//------------------------------------------------------------------------------------
    }
}

