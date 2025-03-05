using System;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEngine;
using Debug = UnityEngine.Debug;

namespace AppnomixKeyboardSDK.Editor
{
    public static class AppnomixPostBuild
    {
        [PostProcessBuild]
        public static void OnPostProcessBuild(BuildTarget target, string pathToBuiltProject)
        {
            if (Directory.Exists(pathToBuiltProject)) {
                Debug.Log("Running Appnomix PostProcessBuild script");
                IOSPostProcessBuild(target, pathToBuiltProject);
            }
        }

        private static void IOSPostProcessBuild(BuildTarget target, string pathToBuiltProject)
        {
            if (target == BuildTarget.iOS)
            {
                // Copy the AppnomixApp.xcassets folder
                CopyAssetsToXcodeProject(pathToBuiltProject);

                // checking for dependencies (ruby)
                string shellScriptPath = Application.dataPath + "/AppnomixKeyboardSDK/Editor/SetupDependencies.sh";

                Process proc = new Process();
                proc.StartInfo.FileName = "/bin/bash";
                proc.StartInfo.Arguments = $"\"{shellScriptPath}\" \"{pathToBuiltProject}\"";
                proc.StartInfo.UseShellExecute = false;
                proc.StartInfo.RedirectStandardOutput = true;
                proc.StartInfo.RedirectStandardError = true;
                proc.Start();

                string output = proc.StandardOutput.ReadToEnd();
                string error = proc.StandardError.ReadToEnd();

                proc.WaitForExit();

                Debug.Log("Ruby is installed.");
                Debug.Log(output);
                if (!string.IsNullOrEmpty(error))
                {
                    Debug.LogError(error);
                }

                // setup Xcode project
                shellScriptPath = Application.dataPath + "/AppnomixKeyboardSDK/Editor/SetupXcode.sh";

                proc = new Process();
                proc.StartInfo.FileName = "/bin/bash";
                proc.StartInfo.Arguments = $"\"{shellScriptPath}\" \"{pathToBuiltProject}\"";
                proc.StartInfo.UseShellExecute = false;
                proc.StartInfo.RedirectStandardOutput = true;
                proc.StartInfo.RedirectStandardError = true;
                proc.Start();

                output = proc.StandardOutput.ReadToEnd();
                error = proc.StandardError.ReadToEnd();

                proc.WaitForExit();

                Debug.Log("Xcode project setup completed.");
                Debug.Log(output);
                if (!string.IsNullOrEmpty(error))
                {
                    Debug.Log($"ERROR:\n{error}");
                    // false errors are stoppping the process
                    //UnityEngine.Debug.LogError(error);
                }
            }
        }

        private static void CopyAssetsToXcodeProject(string pathToBuiltProject)
        {
            // Copy AppnomixApp.xcassets folder to Xcode project
            string unityAssetsPath = Path.Combine(Application.dataPath, "AppnomixKeyboardSDK/Resources", "AppnomixApp.xcassets");
            string xcodeProjectPath = Path.Combine(pathToBuiltProject, "AppnomixApp.xcassets");

            if (!Directory.Exists(unityAssetsPath))
            {
                Debug.LogError("XCAssets folder not found in Unity: " + unityAssetsPath);
                return;
            }

            try
            {
                CopyDirectory(unityAssetsPath, xcodeProjectPath);
                Debug.Log("XCAssets folder copied successfully to Xcode project: " + xcodeProjectPath);
            }
            catch (Exception e)
            {
                Debug.LogError("Error copying XCAssets folder: " + e.Message);
            }

            // Copy AppnomixKeyboard.xcassets folder to Xcode project
            unityAssetsPath = Path.Combine(Application.dataPath, "AppnomixKeyboardSDK/Resources", "AppnomixKeyboard.xcassets");
            xcodeProjectPath = Path.Combine(pathToBuiltProject, "AppnomixKeyboard.xcassets");

            if (!Directory.Exists(unityAssetsPath))
            {
                Debug.LogError("XCAssets folder not found in Unity: " + unityAssetsPath);
                return;
            }

            try
            {
                CopyDirectory(unityAssetsPath, xcodeProjectPath);
                Debug.Log("XCAssets folder copied successfully to Xcode project: " + xcodeProjectPath);
            }
            catch (Exception e)
            {
                Debug.LogError("Error copying XCAssets folder: " + e.Message);
            }
        }
        private static void CopyDirectory(string sourceDir, string destinationDir)
        {
            if (!Directory.Exists(destinationDir))
            {
                Directory.CreateDirectory(destinationDir);
            }

            foreach (var file in Directory.GetFiles(sourceDir))
            {
                string destFile = Path.Combine(destinationDir, Path.GetFileName(file));
                File.Copy(file, destFile, true);
            }

            foreach (var subDir in Directory.GetDirectories(sourceDir))
            {
                string destSubDir = Path.Combine(destinationDir, Path.GetFileName(subDir));
                CopyDirectory(subDir, destSubDir);
            }
        }
    }
}