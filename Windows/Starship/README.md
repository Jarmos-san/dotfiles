# Starship

Starship is a cross-platform customizable prompt. This README holds all the instructions to properly set it up on your local Windows machine.

## How-to Setup Starship

1. Download the x86_64 from GitHub: https://github.com/starship/starship/releases
2. Extract the zipped files to `C:\Tools` which was already added to `$PATH`.
3. Edit the `$Profile` file with the following lines:
        
        ```powershell
        Invoke-Expression (& starship init powershell)
        $ENV:STARSHIP_CONFIG = "$HOME\.starship"
        ```

4. Then create a `.starship` directory & a `starship.toml` file under it. The following two lines of code should do the deed.

        ```powershell
        New-Item -Path "$HOME" -Name ".starship" -ItemType "directory"
        ```

        &

        ```powershell
        New-Item -Path "$HOME\.startship" -Name "starship.toml" -ItemType "file"
        ```

5. Then run the `. $Profile` to reload the PowerShell profile.
