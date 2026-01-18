# Guide: Konfigurer SSH for Flere GitHub-Kontoer på Windows

Denne guiden gir en detaljert, steg-for-steg-prosess for å sette opp og administrere SSH-nøkler for flere GitHub-kontoer på et Windows-system. Dette lar deg sømløst veksle mellom ulike kontoer (f.eks. en personlig og en jobb-konto) uten autentiseringskonflikter.

## Forutsetninger

Før du begynner, sørg for at du har **OpenSSH Client** installert. Moderne versjoner av Windows 10 og 11 inkluderer dette som standard. Du kan verifisere installasjonen ved å åpne PowerShell og kjøre `ssh -V`.

---

## Steg 1: Generer Unike SSH-Nøkler for Hver Konto

Det første steget er å generere et unikt SSH-nøkkelpar for hver GitHub-konto. Det er kritisk å lagre hver nøkkel i en egen fil for å unngå overskriving.

1.  **Åpne PowerShell**.

2.  **Generer en nøkkel for din første konto** (f.eks. `brA`). Bruk `-f` flagget for å spesifisere et unikt filnavn. Vi anbefaler `ed25519`-algoritmen for bedre sikkerhet og ytelse [1].

    ```powershell
    ssh-keygen -t ed25519 -C "din-epost-for-brA@example.com" -f ~/.ssh/id_ed25519_brA
    ```

3.  **Generer en nøkkel for din andre konto** (f.eks. `brB`), og gi den et annet filnavn.

    ```powershell
    ssh-keygen -t ed25519 -C "din-epost-for-brB@example.com" -f ~/.ssh/id_ed25519_brB
    ```

Når du blir spurt om en "passphrase", kan du trykke Enter for å la den være tom, eller angi et passord for ekstra sikkerhet.

## Steg 2: Legg til Nøklene i SSH-Agenten

SSH-agenten er et bakgrunnsprogram som holder styr på SSH-nøklene dine og passordene deres. Dette forhindrer at du må skrive inn passordet hver gang du kobler til.

1.  **Sørg for at SSH-agenten kjører**. Åpne PowerShell som administrator og kjør følgende kommandoer:

    ```powershell
    # Sjekk statusen til agenten
    Get-Service ssh-agent

    # Sett oppstartstypen til automatisk og start tjenesten
    Set-Service -Name ssh-agent -StartupType Automatic
    Start-Service ssh-agent
    ```

2.  **Legg til de nye SSH-nøklene** i agenten:

    ```powershell
    ssh-add ~/.ssh/id_ed25519_brA
    ssh-add ~/.ssh/id_ed25519_brB
    ```

## Steg 3: Legg til Offentlige Nøkler i GitHub

Hver GitHub-konto må kjenne til den offentlige delen av SSH-nøkkelen din for å kunne autentisere deg.

1.  **Kopier innholdet i den offentlige nøkkelen**. For konto `brA`:

    ```powershell
    Get-Content ~/.ssh/id_ed25519_brA.pub | Set-Clipboard
    ```

2.  **Naviger til GitHub-innstillingene**:
    - Logg inn på GitHub-kontoen `brA`.
    - Gå til **Settings** > **SSH and GPG keys**.
    - Klikk på **New SSH key**.

3.  **Lim inn nøkkelen**: Gi den et beskrivende navn (f.eks. "Windows Laptop") og lim inn nøkkelen fra utklippstavlen.

4.  **Gjenta prosessen** for konto `brB` med den tilhørende offentlige nøkkelen (`id_ed25519_brB.pub`).

## Steg 4: Konfigurer SSH-klienten (`~/.ssh/config`)

Dette er det viktigste steget. Du skal nå fortelle SSH-klienten hvilken nøkkel den skal bruke for hvilken vert. Dette gjøres i `config`-filen.

1.  **Opprett eller åpne `config`-filen** i `~/.ssh/`-mappen. Du kan bruke en tekst-editor som Notepad eller VS Code.

    ```powershell
    # Oppretter filen hvis den ikke finnes
    if (-not (Test-Path ~/.ssh/config)) { New-Item ~/.ssh/config }

    # Åpner filen i Notepad
    notepad ~/.ssh/config
    ```

2.  **Legg til følgende konfigurasjon**. Denne oppretter unike "Host"-alias for hver GitHub-konto.

    ```
    # GitHub-konto 1 (brA)
    Host github.com-brA
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_brA
        IdentitiesOnly yes

    # GitHub-konto 2 (brB)
    Host github.com-brB
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_ed25519_brB
        IdentitiesOnly yes
    ```

| Direktiv       | Beskrivelse                                                                                             |
| :------------- | :------------------------------------------------------------------------------------------------------ |
| `Host`         | Et unikt alias du vil bruke for å referere til denne konfigurasjonen.                                   |
| `HostName`     | Det faktiske vertsnavnet du kobler til (alltid `github.com`).                                           |
| `User`         | Brukernavnet for SSH-tilkoblingen (alltid `git` for GitHub).                                            |
| `IdentityFile` | Stien til den private SSH-nøkkelen som skal brukes for denne verten.                                    |
| `IdentitiesOnly`| `yes` sikrer at SSH kun prøver nøkkelen spesifisert i `IdentityFile`, og ikke alle nøkler i agenten [2]. |


## Steg 5: Klon og Push med Riktig Konto

Nå som alt er konfigurert, må du bruke de nye `Host`-aliasene i Git-kommandoene dine.

-   **For å klone et repository** fra konto `brA`:

    ```powershell
    git clone git@github.com-brA:brA/repository-navn.git
    ```

-   **For et eksisterende repository**, må du oppdatere `remote`-URL-en:

    ```powershell
    # Naviger til repository-mappen
    cd sti/til/ditt/repo

    # Oppdater URL-en til å bruke det nye aliaset
    git remote set-url origin git@github.com-brA:brA/repository-navn.git
    ```

## Steg 6: Verifiser Tilkoblingen

Du kan enkelt teste at hver konfigurasjon fungerer som forventet.

-   **Test tilkobling for `brA`**:

    ```powershell
    ssh -T git@github.com-brA
    ```

    Forventet svar: `Hi brA! You've successfully authenticated...`

-   **Test tilkobling for `brB`**:

    ```powershell
    ssh -T git@github.com-brB
    ```

    Forventet svar: `Hi brB! You've successfully authenticated...`

---

## Referanser
[1] Stenberg, D. (2021). *On ED25519*. Hentet fra [daniel.haxx.se](https://daniel.haxx.se/blog/2021/09/23/on-ed25519/)
[2] OpenBSD. (u.å.). *ssh_config(5) - OpenBSD manual pages*. Hentet fra [man.openbsd.org](https://man.openbsd.org/ssh_config.5#IdentitiesOnly)
