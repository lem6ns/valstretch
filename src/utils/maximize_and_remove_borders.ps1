Add-Type -assemblyName WindowsBase
Add-Type -assemblyName PresentationFramework
Add-Type -assemblyName PresentationCore

$code = @"
[DllImport("user32.dll", SetLastError = true)]
public static extern int GetWindowLong(IntPtr hWnd, int nIndex);
[DllImport("user32.dll")]
public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
"@
Add-Type -MemberDefinition $code -Name Win32Util -Namespace System

$WS_BORDER = 0x00800000
$WS_DLGFRAME = 0x00400000
$WS_CAPTION = $WS_BORDER -bor $WS_DLGFRAME
$WS_THICKFRAME = 0x00040000
$WS_MINIMIZE = 0x20000000
$WS_MAXIMIZE = 0x01000000
$WS_SYSMENU = 0x00080000
$WS_EX_DLGMODALFRAME = 0x00000001
$WS_EX_CLIENTEDGE = 0x00000200
$WS_EX_STATICEDGE = 0x00020000

$MainWindowHandle = (Get-Process -Name VALORANT-Win64-Shipping).MainWindowHandle

$style = [System.Win32Util]::GetWindowLong($MainWindowHandle,$GWL_STYLE)
[System.Win32Util]::SetWindowLong($MainWindowHandle, -16, $style -band -bnot($WS_CAPTION -bor $WS_THICKFRAME -bor $WS_MINIMIZE -bor $WS_MAXIMIZE -bor $WS_SYSMENU))
[System.Win32Util]::ShowWindowAsync($MainWindowHandle, 3)