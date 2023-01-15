function Invoke-Scoop {
    param($Command, $Arguments)
    & scoop $Command $Arguments
}