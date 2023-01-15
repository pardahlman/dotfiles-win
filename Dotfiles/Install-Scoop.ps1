function Install-Scoop {

    if(Test-CommandExist "scoop")
    {
        return;
    }

    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}