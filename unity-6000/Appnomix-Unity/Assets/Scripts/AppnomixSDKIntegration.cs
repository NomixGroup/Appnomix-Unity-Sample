using AOT;
using AppnomixKeyboardSDK.Scripts;
using TMPro;
using UnityEngine;

public class AppnomixSDKIntegration : MonoBehaviour
{
    public TMP_Text onboardingStatus;
    
    private static bool _textChanged;
    
    private static AppnomixKeyboardSDKWrapper _keyboardSdk;

    void Start()
    {
        Debug.Log("AppnomixSDKIntegration Started");
        if (onboardingStatus != null)
        {
            onboardingStatus.text = "Onboarding";
        }

        _keyboardSdk ??= new AppnomixKeyboardSDKWrapper();
    }

    public void LaunchOnboarding()
    {
        _keyboardSdk.LaunchOnboarding();
    }

    public void TrackOffer(string context)
    {
    }

    // Update is called once per frame
    void Update()
    {
    }
}
